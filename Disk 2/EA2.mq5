#property strict

#define TOTAL_SYMBOLS 28
#define BB_PERIOD 20
#define BB_SHIFT 0
#define BB_DEVIATION 2

#include <Trade/SymbolInfo.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/Trade.mqh>
#include "TargetManager.mqh"
CSymbolInfo Symbol;
CPositionInfo Position;
CTrade Trade;
CTargetManager targetManager;

input ENUM_TIMEFRAMES TimeFrame = PERIOD_M15; // TimeFrame Strategy
input bool Debug = true;
input const string kosong = "======================";  // Filter Validation
input bool MaxOrder = true;                            // Max Order 1 (PerBar)
input ENUM_TIMEFRAMES TimeFrameMax = PERIOD_H1;        // TimeFrame Max Order
input int maxspread = 35;                              // Max spread
input const string kosong2 = "======================"; // ======================
input int iStopLoss = 100;                             // Stop Loss (Point)
input double iLotSize = 0.01;                          // Lot Size
input string iComment = "";                            // Comment
input int iMagicNumber = 123456;                       // Magic Number
                                                       // Tambahkan input parameter untuk jam trading
input const string kosong3 = "======================"; // Trading Hours
input bool UseTimeFilter = true;                       // Use Trading Hours
input int StartHour = 2;                               // Start Hour (Server Time)
input int StartMinute = 0;                             // Start Minute
input int EndHour = 22;                                // End Hour (Server Time)
input int EndMinute = 0;                               // End Minute
input const string kosong4 = "======================"; // DAFTAR STRATEGY

enum ENUM_STRATEGY
{
    STRATEGY_1, // Strategy 1
    STRATEGY_2, // Strategy 2
    STRATEGY_3  // Strategy 3
};
input ENUM_STRATEGY Strategy = STRATEGY_1;

string g_SymbolName[TOTAL_SYMBOLS];
int g_HandleBB[TOTAL_SYMBOLS];
int g_HandleMA[TOTAL_SYMBOLS];

double upper_band[], lower_band[], price_now[], ma_values[];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{

    Trade.SetExpertMagicNumber(iMagicNumber);
    targetManager.Init();
    ArrayResize(upper_band, 3);
    ArrayResize(lower_band, 3);
    ArrayResize(price_now, 3);
    ArrayResize(ma_values, 1);
    ArraySetAsSeries(upper_band, true);
    ArraySetAsSeries(lower_band, true);
    ArraySetAsSeries(price_now, true);
    ArraySetAsSeries(ma_values, true);

    if (TOTAL_SYMBOLS != SymbolsTotal(true))
    {
        Print("init_failed");
        return (INIT_FAILED);
    }

    for (int i = 0; i < TOTAL_SYMBOLS; i++)
    {
        g_SymbolName[i] = SymbolName(i, true);
        g_HandleMA[i] = INVALID_HANDLE;
        g_HandleBB[i] = INVALID_HANDLE;
    }
    EventSetTimer(1);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    for (int i = 0; i < TOTAL_SYMBOLS; i++)
    {
        ReleaseBBHandle(i);
        ReleaseMAHandle(i);
    }
    targetManager.Deinit();
    EventKillTimer();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
    targetManager.ShowTargetOnChart();
    targetManager.CheckAndCloseAllOrders();
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
    if (id == CHARTEVENT_OBJECT_CLICK && sparam == BUTTON_NAME) // Jika tombol diklik
    {
        targetManager.OnChartEvent(id, lparam, dparam, sparam);
    }

    static bool isUpdating = false;

    if (id == CHARTEVENT_CHART_CHANGE && !isUpdating)
    {
        if (Period() != TimeFrame)
        {
            isUpdating = true;

            // Bersihkan resources dulu
            OnDeinit(0);

            // Update chart
            ChartSetSymbolPeriod(0, Symbol(), TimeFrame);

            // Inisialisasi ulang
            OnInit();

            isUpdating = false;
            Print("Chart updated to new timeframe: ", EnumToString(TimeFrame));
        }
    }
}

bool Validate(int i, string symbol, string &error_msg)
{
    // Validasi posisi yang sudah ada
    if (Position.Select(symbol))
    {
        // Cek magic number
        if (Position.Magic() == iMagicNumber)
        {
            error_msg = StringFormat("Posisi Order Terbuka Symbol : %s dengan Magic Number : %d",
                                     symbol, iMagicNumber);
            return false;
        }
    }
    if (UseTimeFilter && !IsValidTradingTime())
    {
        error_msg = StringFormat("Diluar Jam Trading (%02d:%02d - %02d:%02d)",
                                 StartHour, StartMinute, EndHour, EndMinute);
        return false;
    }

    if (!Symbol.Name(symbol))
    {
        error_msg = StringFormat("Failed to select symbol %s", symbol);
        return false;
    }
    // Refresh rates setelah set symbol
    if (!Symbol.RefreshRates())
    {
        error_msg = StringFormat("Failed to refresh rates for %s", symbol);
        return false;
    }
    if (Symbol.Spread() > maxspread) // Example max spread validation
    {
        error_msg = StringFormat("Spread Terlalu Tinggi : (%d) | Symbol : %s", Symbol.Spread(), symbol);
        return false;
    }

    datetime last_bar_time = iTime(symbol, PERIOD_M1, 0);

    // Cek selisih waktu
    if (TimeCurrent() - last_bar_time > 120)
    {
        error_msg = StringFormat("Last bar time too old for %s - last bar time: %s", symbol, last_bar_time);
        return false;
    }

    return true;
}
bool IsOrderInCurrentBar(string symbol)
{
    datetime current_bar_time = iTime(symbol, TimeFrameMax, 0);

    // Cek history order di bar ini
    if (HistorySelect(current_bar_time, TimeCurrent()))
    {
        for (int i = HistoryDealsTotal() - 1; i >= 0; i--)
        {
            ulong ticket = HistoryDealGetTicket(i);
            if (ticket <= 0)
                continue;

            if (HistoryDealGetString(ticket, DEAL_SYMBOL) == symbol)
            {
                datetime dealTime = (datetime)HistoryDealGetInteger(ticket, DEAL_TIME);
                if (dealTime >= current_bar_time)
                    return true;
            }
        }
    }

    return false;
}
bool IsValidTradingTime()
{
    if (!UseTimeFilter)
        return true;

    MqlDateTime dt;
    TimeCurrent(dt);

    int currentTime = dt.hour * 60 + dt.min;
    int startTime = StartHour * 60 + StartMinute;
    int endTime = EndHour * 60 + EndMinute;

    return (currentTime >= startTime && currentTime < endTime);
}
void OnTick()
{

    for (int i = 0; i < TOTAL_SYMBOLS; i++)
    {
        //=================== Cek signal ===================
        Symbol.Name(g_SymbolName[i]);
        double spread = Symbol.Spread() * Symbol.Point();
        int digits = Symbol.Digits();
        string signal = OnSignal(i, spread);
        // Print("Signal : ", signal, " | Symbol : ", g_SymbolName[i], " | Price : ", NormalizeDouble(price_now[0], digits), "Upper : | ", NormalizeDouble(upper_band[0], digits), " Lower :| ", NormalizeDouble(lower_band[0], digits));
        if (signal == "")
            continue;
        //=================== Cek Validasi ===================
        string error_msg = "";
        if (!Validate(i, g_SymbolName[i], error_msg))
        {
            if (Debug)
                Print(error_msg);
            continue;
        }
        // =================== Cek Max Order ===================

        if (MaxOrder) // jika input max order true
        {
            if (IsOrderInCurrentBar(g_SymbolName[i])) // jika ada order di bar ini
            {
                error_msg = StringFormat("Sudah ada order di bar ini %s | Timeframe : %s", g_SymbolName[i], TimeFrameMax);
                if (Debug)
                    Print(error_msg);
                continue;
            }
        }

        // ====================== setting komentar ======================
        string comment;
        if (iComment == "")
            comment = EnumToString(TimeFrame);
        else
            comment = iComment;
        // ====================== Setting SL ==============================
        double minStops = Symbol.StopsLevel() * Symbol.Point();
        double sl_buy = Symbol.Bid() - (iStopLoss * Symbol.Point());  // SL dibawah harga Bid untuk BUY
        double sl_sell = Symbol.Ask() + (iStopLoss * Symbol.Point()); // SL diatas harga Ask untuk SELL                                                                 // Untuk BUY
        if ((Symbol.Bid() - sl_buy) < minStops)
            sl_buy = Symbol.Bid() - minStops;
        if ((sl_sell - Symbol.Ask()) < minStops)
            sl_sell = Symbol.Ask() + minStops;
        //===================== Order Buy ==============================
        if (signal == "BUY")
        {
            if (!Trade.Buy(iLotSize, g_SymbolName[i], Symbol.Bid(), sl_buy, 0, comment))
            {
                Print("Error BUY order: ", GetLastError());
                continue;
            }
            Print("Buy Order #", Trade.ResultOrder(), " ", g_SymbolName[i], " [", TimeToString(TimeLocal(), TIME_MINUTES),
                  "] Harga:", price_now[0], " Lower Band : ", lower_band[0]);
            continue;
        }
        //===================== Order Sell ==============================
        if (signal == "SELL")
        {
            if (!Trade.Sell(iLotSize, g_SymbolName[i], Symbol.Ask(), sl_sell, 0, comment))
            {
                Print("Error SELL order: ", GetLastError());
                continue;
            }
            Print("Sell Order #", Trade.ResultOrder(), " ", g_SymbolName[i], " [", TimeToString(TimeLocal(), TIME_MINUTES),
                  "] Harga:", price_now[0], " Upper Band : ", upper_band[0]);
            continue;
        }
    }
}

string Strategy1(double spread, string &signal)
{
    if (price_now[0] < upper_band[0] + spread && price_now[0] > lower_band[0] - spread)
        return signal;
    if (price_now[0] + spread > upper_band[0] &&
        price_now[1] > upper_band[1] &&
        price_now[2] < upper_band[2])
        return signal = "SELL";
    if (price_now[0] - spread < lower_band[0] &&
        price_now[1] < lower_band[1] &&
        price_now[2] > lower_band[2])
        return signal = "BUY";
    return signal;
}
string Strategy2(double spread, string &signal)
{
    if (price_now[0] < upper_band[0] && price_now[0] > lower_band[0])
        return signal;
    if (price_now[0] > upper_band[0] &&
        price_now[1] > upper_band[1] &&
        price_now[2] < upper_band[2])
        return signal = "BUY";
    if (price_now[0] < lower_band[0] &&
        price_now[1] < lower_band[1] &&
        price_now[2] > lower_band[2])
        return signal = "SELL";
    return signal;
}
string Strategy3(double spread, string &signal)
{
    //================== Strategy Main ===================
    if (price_now[0] <= upper_band[0] + spread && price_now[0] >= lower_band[0] - spread)
        return signal;
    if (price_now[0] > ma_values[0])
    {
        if (price_now[0] - spread < lower_band[0] &&
            price_now[1] < lower_band[1] &&
            price_now[2] > lower_band[2])
        {
            return signal = "BUY";
        }
        return signal;
    }
    if (price_now[0] < ma_values[0])
    {
        if (price_now[0] + spread > upper_band[0] &&
            price_now[1] > upper_band[1] &&
            price_now[2] < upper_band[2])
        {
            return signal = "SELL";
        }
        return signal;
    }
    return signal;
}

string OnSignal(int i, double spread)
{
    string signal = "";
    //=================== Strategy 1 ===================
    if (Strategy == STRATEGY_1)
    {
        if (g_HandleBB[i] == INVALID_HANDLE)
        {
            Print("Invalid handle for ", g_HandleBB[i], " Symbol : ", g_SymbolName[i]);
            CreateBBHandle(i);
            return signal;
        }
        if (!CopyBB(i))
            return signal;
        if (!CopyClosing(i))
            return signal;
        signal = Strategy1(spread, signal);
        return signal;
    }
    //=================== Strategy 2 ===================
    if (Strategy == STRATEGY_2)
    {
        if (g_HandleBB[i] == INVALID_HANDLE)
        {
            CreateBBHandle(i);
            return signal;
        }
        if (!CopyBB(i))
            return signal;
        if (!CopyClosing(i))
            return signal;
        signal = Strategy2(spread, signal);
        return signal;
    }
    //=================== Strategy 3 ===================
    if (Strategy == STRATEGY_3)
    {

        if (g_HandleMA[i] == INVALID_HANDLE)
        {
            CreateMAHandle(i);
            return signal;
        }
        if (g_HandleBB[i] == INVALID_HANDLE)
        {
            CreateBBHandle(i);
            return signal;
        }
        if (!CopyMA(i))
            return signal;
        if (!CopyBB(i))
            return signal;
        if (!CopyClosing(i))
            return signal;
        signal = Strategy3(spread, signal);
        return signal;
    }
    return signal;
}

bool CopyMA(int i)
{
    if (CopyBuffer(g_HandleMA[i], 0, 0, 1, ma_values) != 1)
    {
        Print("Error copying data for ", g_SymbolName[i], ": ", GetLastError());
        return false;
    }
    return true;
}
bool CopyBB(int i)
{

    if (CopyBuffer(g_HandleBB[i], 1, 0, 3, upper_band) != 3 ||
        CopyBuffer(g_HandleBB[i], 2, 0, 3, lower_band) != 3)
    {
        Print("Error copying data for ", g_SymbolName[i], ": ", GetLastError());
        return false;
    }
    return true;
}

bool CopyClosing(int i)
{
    if (CopyClose(g_SymbolName[i], TimeFrame, 0, 3, price_now) != 3)
    {
        Print("Error copying data Close Price for ", g_SymbolName[i], ": ", GetLastError());
        return false;
    }
    return true;
}

void CreateMAHandle(int i)
{
    g_HandleMA[i] = iMA(g_SymbolName[i], PERIOD_D1, 14, 0, MODE_SMA, PRICE_CLOSE);
    if (g_HandleMA[i] == INVALID_HANDLE)
    {
        Print("Failed to create MA handle for ", g_SymbolName[i]);
        for (int count = 0; count < 5; count++)
        {
            g_HandleMA[i] = iMA(g_SymbolName[i], PERIOD_M15, 14, 0, MODE_SMA, PRICE_CLOSE);
            if (g_HandleMA[i] != INVALID_HANDLE)
                break;
        }
    }
}

void CreateBBHandle(int i)
{
    g_HandleBB[i] = iBands(g_SymbolName[i], PERIOD_M15, 14, 0, 2.0, PRICE_CLOSE);
    if (g_HandleBB[i] == INVALID_HANDLE) // jika handle invalid
    {
        Print("Failed to create BB handle for ", g_SymbolName[i]);
        for (int count = 0; count < 5; count++)
        {
            g_HandleBB[i] = iBands(g_SymbolName[i], PERIOD_M15, 14, 0, 2.0, PRICE_CLOSE);
            if (g_HandleBB[i] != INVALID_HANDLE)
                break;
        }
    }
}
void ReleaseMAHandle(int i)
{
    if (g_HandleMA[i] != INVALID_HANDLE)
    {
        IndicatorRelease(g_HandleMA[i]);
        g_HandleMA[i] = INVALID_HANDLE;
    }
    Print(g_HandleMA[i], " Handle MA Released");
}
void ReleaseBBHandle(int i)
{
    if (g_HandleBB[i] != INVALID_HANDLE) // jika handle tidak invalid
    {
        IndicatorRelease(g_HandleBB[i]);
        g_HandleBB[i] = INVALID_HANDLE;
    }
    Print(g_HandleBB[i], " Handle BB Released");
}
