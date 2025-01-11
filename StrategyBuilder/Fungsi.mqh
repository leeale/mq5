#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include "Input.mqh"

#define BUTTON_NAME "closeall"
#define BUTTON_NAME1 "closeallsymbol"

double m_savedBalance;
bool m_isBalanceLoaded;

CPositionInfo pos;
CTrade trade;

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

//=============== FUNGSI PEMBANTU === ==============

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
