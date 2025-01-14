#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include "Input.mqh"

#define BUTTON_NAME "closeall"
#define BUTTON_NAME1 "closeallsymbol"

double m_savedBalance;
bool m_isBalanceLoaded;

CPositionInfo pos;
CTrade trade;

void FillArrayWithLastValue(string &dest[], string &source[], int totalSize)
{
    int sourceSize = ArraySize(source);
    if (sourceSize == 0 || totalSize <= 0)
        return;

    // Resize array tujuan
    ArrayResize(dest, totalSize);

    // Copy array sumber dulu
    ArrayCopy(dest, source);

    // Ambil nilai terakhir dari source
    string lastValue = source[sourceSize - 1];

    // Isi sisa array dengan nilai terakhir
    for (int i = sourceSize; i < totalSize; i++)
    {
        dest[i] = lastValue;
    }
}

ENUM_TIMEFRAMES StringToTimeframe(string tf_string)
{
    string timeframe = tf_string;
    StringToUpper(timeframe); // Konversi ke uppercase

    // Cek format text
    if (timeframe == "M1")
        return PERIOD_M1;
    if (timeframe == "M5")
        return PERIOD_M5;
    if (timeframe == "M15")
        return PERIOD_M15;
    if (timeframe == "M30")
        return PERIOD_M30;
    if (timeframe == "H1")
        return PERIOD_H1;
    if (timeframe == "H4")
        return PERIOD_H4;
    if (timeframe == "D1")
        return PERIOD_D1;
    if (timeframe == "W1")
        return PERIOD_W1;
    if (timeframe == "MN1")
        return PERIOD_MN1;

    // Cek format angka
    if (timeframe == "1")
        return PERIOD_M1;
    if (timeframe == "5")
        return PERIOD_M5;
    if (timeframe == "15")
        return PERIOD_M15;
    if (timeframe == "30")
        return PERIOD_M30;
    if (timeframe == "60")
        return PERIOD_H1;
    if (timeframe == "240")
        return PERIOD_H4;
    if (timeframe == "1440")
        return PERIOD_D1;
    if (timeframe == "10080")
        return PERIOD_W1;
    if (timeframe == "43200")
        return PERIOD_MN1;

    Print("Timeframe tidak valid: ", tf_string, " menggunakan default M1");
    return PERIOD_M1;
}

int GetSignalBase(string symbol, BaseSymbol baseSymbol)
{
    Print("GetSignalBase: ", symbol, " ", baseSymbol);
    string baseStr = GetBaseSymbolString(baseSymbol);
    bool isBaseFirst = (StringSubstr(symbol, 0, 3) == baseStr);
    bool isBaseSecond = (StringSubstr(symbol, 3, 3) == baseStr);

    // Jika simbol tidak mengandung base currency yang dicari
    if (!isBaseFirst && !isBaseSecond)
        return 0;
    if (base_direction == ENUM_BASE_DIRECTION::BUY)
    {
        if (isBaseFirst)
            return 1; // Buy BASE/XXX
        else
            return -1; // Sell XXX/BASE
    }
    else if (base_direction == ENUM_BASE_DIRECTION::SELL)
    {
        if (isBaseFirst)
            return -1; // Sell BASE/XXX
        else
            return 1; // Buy XXX/BASE
    }
    else if (base_direction == ENUM_BASE_DIRECTION::ALL_BUY)
        return 1; // Buy
    else if (base_direction == ENUM_BASE_DIRECTION::ALL_SELL)
        return -1; // Sell

    return 0;
}
void SetTargetBalance()
{
    if (m_targetProfit > 0)
    {
        m_savedBalance = 0;
        m_isBalanceLoaded = false;
        LoadBalance();
        ShowTargetOnChart();
    }
}
bool IsCorrelatedSymbol(string pair, BaseSymbol baseSymbol)
{
    // Daftar pasangan dengan korelasi positif untuk setiap simbol dasar
    switch (baseSymbol)
    {
    case USD:
        return (StringFind(pair, "USD") >= 0); // Semua pasangan yang mengandung USD
    case GBP:
        return (StringFind(pair, "GBP") >= 0); // Semua pasangan yang mengandung GBP
    case EUR:
        return (StringFind(pair, "EUR") >= 0); // Semua pasangan yang mengandung EUR
    case JPY:
        return (StringFind(pair, "JPY") >= 0); // Semua pasangan yang mengandung JPY
    case CAD:
        return (StringFind(pair, "CAD") >= 0); // Semua pasangan yang mengandung CAD
    case CHF:
        return (StringFind(pair, "CHF") >= 0); // Semua pasangan yang mengandung CHF
    case AUD:
        return (StringFind(pair, "AUD") >= 0); // Semua pasangan yang mengandung AUD
    case NZD:
        return (StringFind(pair, "NZD") >= 0); // Semua pasangan yang mengandung NZD
    }
    return false; // Default: tidak ada pasangan yang cocok
}

string GetBaseSymbolString(BaseSymbol baseSymbol)
{
    switch (baseSymbol)
    {
    case USD:
        return "USD";
    case GBP:
        return "GBP";
    case EUR:
        return "EUR";
    case JPY:
        return "JPY";
    case CAD:
        return "CAD";
    case CHF:
        return "CHF";
    case AUD:
        return "AUD";
    case NZD:
        return "NZD";
    }
    return ""; // Default: return empty string jika tidak ada yang cocok
}
void SetBreakEven(string symbol, double profitTrigger = 1.0, double buffer = 30)
{
    double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
    double minimalStopLoss = SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL) * point;

    // Iterasi semua posisi
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (!pos.SelectByIndex(i)) // Pilih posisi berdasarkan indeks
            continue;

        // Hanya proses posisi pada simbol yang sesuai
        if (pos.Symbol() != symbol)
            continue;

        // Informasi simbol dan nilai point
        string positionSymbol = pos.Symbol();
        double point = SymbolInfoDouble(positionSymbol, SYMBOL_POINT); // Nilai _Point untuk simbol posisi

        // Informasi posisi
        ulong ticket = pos.Ticket();
        double openPrice = pos.PriceOpen();
        double currentProfit = pos.Profit();
        double stopLoss = pos.StopLoss();
        ENUM_POSITION_TYPE positionType = pos.PositionType();

        // Cek apakah posisi memenuhi syarat profit trigger
        if (currentProfit >= profitTrigger)
        {
            double newStopLoss = 0.0;

            if (positionType == POSITION_TYPE_BUY)
            {
                newStopLoss = openPrice + buffer * point; // Tambahkan buffer
            }
            else if (positionType == POSITION_TYPE_SELL)
            {
                newStopLoss = openPrice - buffer * point; // Tambahkan buffer
            }

            // Update Stop Loss hanya jika belum disetel atau lebih buruk dari Break-Even
            if ((positionType == POSITION_TYPE_BUY && (stopLoss < newStopLoss || stopLoss == 0)) ||
                (positionType == POSITION_TYPE_SELL && (stopLoss > newStopLoss || stopLoss == 0)))
            {
                if (trade.PositionModify(ticket, newStopLoss, pos.TakeProfit()))
                {
                    Print("Stop Loss dipindahkan ke Break-Even untuk posisi ", ticket, " pada simbol ", positionSymbol);
                }
                else
                {
                    Print("Gagal memodifikasi Stop Loss untuk posisi ", ticket, ". Mencoba set Stop Loss minimal.");

                    // Coba atur Stop Loss minimal jika modifikasi gagal
                    if (positionType == POSITION_TYPE_BUY)
                    {
                        newStopLoss = openPrice - minimalStopLoss * point; // Minimal SL di bawah harga buka
                    }
                    else if (positionType == POSITION_TYPE_SELL)
                    {
                        newStopLoss = openPrice + minimalStopLoss * point; // Minimal SL di atas harga buka
                    }

                    if (trade.PositionModify(ticket, newStopLoss, pos.TakeProfit()))
                    {
                        Print("Stop Loss minimal berhasil disetel untuk posisi ", ticket, " pada simbol ", positionSymbol);
                    }
                    else
                    {
                        Print("Gagal menetapkan Stop Loss minimal untuk posisi ", ticket);
                    }
                }
            }
        }
    }
}
bool IsPositionBySymbol(string symbol)
{
    bool hasPosition = false;
    for (int i = 0; i < PositionsTotal(); i++)
    {
        if (pos.SelectByIndex(i))
        {
            if (pos.Symbol() == symbol)
            {
                hasPosition = true;
                break;
            }
        }
    }
    return hasPosition;
}
bool IsNewBar(ENUM_TIMEFRAMES timeframe)
{
    static datetime last_time = 0;
    datetime current_time = iTime(NULL, timeframe, 0); //
    if (current_time != last_time)
    {
        last_time = current_time;
        return true;
    }
    return false;
}
void CloseAllOrders(string symbol = NULL)
{

    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (pos.SelectByIndex(i))
        {
            if (symbol == NULL)
            {
                if (!trade.PositionClose(pos.Ticket()))
                    Print("Error closing position: ", GetLastError());
                else
                    Print("Position closed: ", pos.Symbol());
            }
            else
            {
                if (pos.Symbol() == symbol)
                {
                    if (!trade.PositionClose(pos.Ticket()))
                        Print("Error closing position: ", GetLastError());
                    else
                        Print("Position closed: ", pos.Symbol());
                }
            }
        }
    }

    // Close pending orders if any
    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        ulong ticket = OrderGetTicket(i);
        if (ticket > 0)
        {
            trade.OrderDelete(ticket);
        }
    }
}
void CreateCloseButton()
{
    if (ObjectFind(0, "closeall") >= 0)
        ObjectDelete(0, "closeall");

    if (!ObjectCreate(0, "closeall", OBJ_BUTTON, 0, 0, 0))
    {
        Print("Failed to create button: ", GetLastError());
        return;
    }

    ObjectSetInteger(0, "closeall", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "closeall", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "closeall", OBJPROP_YDISTANCE, 30);
    ObjectSetInteger(0, "closeall", OBJPROP_XSIZE, 100);
    ObjectSetInteger(0, "closeall", OBJPROP_YSIZE, 30);
    ObjectSetString(0, "closeall", OBJPROP_TEXT, "Close All");
    ObjectSetInteger(0, "closeall", OBJPROP_COLOR, clrBlack);
    ObjectSetInteger(0, "closeall", OBJPROP_BORDER_COLOR, clrBlack);
    ObjectSetInteger(0, "closeall", OBJPROP_BGCOLOR, clrWhite);
    ObjectSetInteger(0, "closeall", OBJPROP_SELECTABLE, false);
}
void CreateCloseButtonSymbol()
{
    if (ObjectFind(0, "closeallsymbol") >= 0)
        ObjectDelete(0, "closeallsymbol");

    if (!ObjectCreate(0, "closeallsymbol", OBJ_BUTTON, 0, 0, 0))
    {
        Print("Failed to create button: ", GetLastError());
        return;
    }

    ObjectSetInteger(0, "closeallsymbol", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_XDISTANCE, 130);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_YDISTANCE, 30);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_XSIZE, 130);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_YSIZE, 30);
    ObjectSetString(0, "closeallsymbol", OBJPROP_TEXT, "Close All Symbol");
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_COLOR, clrWhite);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_BORDER_COLOR, clrBlack);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_BGCOLOR, clrRed);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_SELECTABLE, false);
}
void ShowTargetOnChart()
{
    double currentEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double targetBalance = m_savedBalance + m_targetProfit;
    double remainingToTarget = currentEquity - targetBalance + m_targetProfit;

    if (ObjectFind(0, "TargetLabel1") < 0)
        ObjectCreate(0, "TargetLabel1", OBJ_LABEL, 0, 0, 0);

    ObjectSetInteger(0, "TargetLabel1", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_YDISTANCE, 80);
    ObjectSetString(0, "TargetLabel1", OBJPROP_TEXT,
                    "Target: $" + DoubleToString(targetBalance, 2));
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_COLOR, clrWhite);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_FONTSIZE, 10);

    if (ObjectFind(0, "TargetLabel2") < 0)
        ObjectCreate(0, "TargetLabel2", OBJ_LABEL, 0, 0, 0);

    ObjectSetInteger(0, "TargetLabel2", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_YDISTANCE, 95);
    ObjectSetString(0, "TargetLabel2", OBJPROP_TEXT,
                    "Remaining: $" + DoubleToString(remainingToTarget, 2));
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_COLOR, remainingToTarget > 0 ? clrLime : clrRed);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_FONTSIZE, 10);

    ChartRedraw(0);
}
void CheckAndCloseAllOrders()
{
    double currentEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double targetBalance = m_savedBalance + m_targetProfit;

    if (currentEquity >= targetBalance)
    {
        Print("Target reached! Initial balance: ", m_savedBalance,
              " Target: ", targetBalance,
              " Current equity: ", currentEquity);

        CloseAllOrders();

        double newBalance = AccountInfoDouble(ACCOUNT_BALANCE);
        string filename = "balance_history.txt";
        int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
        if (handle != INVALID_HANDLE)
        {
            FileWriteString(handle, DoubleToString(newBalance, 2));
            FileClose(handle);
            m_savedBalance = newBalance;
            Print("New balance saved: ", newBalance);
        }
    }
}
double LoadBalance()
{
    if (!m_isBalanceLoaded)
    {
        string filename = "balance_history.txt";
        if (m_balancedManual > 0)
        {
            // Jika balance diset manual, gunakan nilai tersebut
            m_savedBalance = m_balancedManual;

            m_savedBalance = m_balancedManual;
            int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
            if (handle != INVALID_HANDLE)
            {
                FileWriteString(handle, DoubleToString(m_balancedManual, 2));
                FileClose(handle);
            }
        }
        else
        {
            if (FileIsExist(filename))
            {
                int handle = FileOpen(filename, FILE_READ | FILE_TXT | FILE_ANSI);
                string content = FileReadString(handle);
                m_savedBalance = StringToDouble(content);
                FileClose(handle);
            }
            else
            {
                double currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);
                int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
                FileWriteString(handle, DoubleToString(currentBalance, 2));
                FileClose(handle);
                m_savedBalance = currentBalance;
            }
        }
        m_isBalanceLoaded = true;
    }
    return m_savedBalance;
}
