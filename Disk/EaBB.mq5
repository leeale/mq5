#property strict
// #include <Trade/AccountInfo.mqh>
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/SymbolInfo.mqh>
#include "../TargetManager.mqh"

// #define BUTTON_NAME "closeall"

input bool debug = true;  // Debuging
input int stoploss = 100; // Stop Loss

CTrade trade;
CPositionInfo position;
CSymbolInfo symbolInfo;
CTargetManager targetManager;

int g_TotalSymbols = SymbolsTotal(true);
string g_SymbolName[];
int g_HandleBB[];

// Tangani event pada tombol
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    if (id == CHARTEVENT_OBJECT_CLICK && sparam == BUTTON_NAME) // Jika tombol diklik
    {
        targetManager.OnChartEvent(id, lparam, dparam, sparam);
    }
}

// Fungsi untuk membersihkan objek saat EA dihentikan

// Nama dan ID untuk button

int OnInit()
{
    Print("Init EA");
    trade.SetExpertMagicNumber(123456);
    targetManager.Init();
    if (g_TotalSymbols != 28)
        return (INIT_FAILED);
    ArrayResize(g_HandleBB, g_TotalSymbols);
    ArrayResize(g_SymbolName, g_TotalSymbols);

    for (int i = 0; i < g_TotalSymbols; i++)
    {
        g_SymbolName[i] = SymbolName(i, true);
        g_HandleBB[i] = iBands(g_SymbolName[i], PERIOD_M15, 20, 0, 2, PRICE_CLOSE);
        if (g_HandleBB[i] == INVALID_HANDLE)
        {
            Print("Error: Can't create band for %s", g_SymbolName[i]);
            return (INIT_FAILED);
        }
    }

    EventSetTimer(1); //

    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    for (int i = 0; i < g_TotalSymbols; i++)
    {
        if (g_HandleBB[i] != INVALID_HANDLE)
            IndicatorRelease(g_HandleBB[i]);
    }
    Print("Deinit EA");
    targetManager.Deinit();
    //  ObjectDelete(0, BUTTON_NAME); // Hapus tombol dari chart
}
enum VALIDATE_RESULT
{
    VALID = 0,
    SYMBOL_ERROR = 1,
    TRADE_MODE_ERROR = 2,
    SPREAD_ERROR = 3,
    TIME_ERROR = 4
};

static datetime g_lastDayCheck = 0;
static datetime g_lastHourCheck = 0;

VALIDATE_RESULT ValidateSymbol(const string symbol, string &errorMsg)
{
    string currentTime = TimeToString(TimeLocal(), TIME_MINUTES);

    // Cek hari trading sehari sekali
    if (TimeCurrent() - g_lastDayCheck > 3600)
    {
        MqlDateTime dt;
        TimeToStruct(TimeCurrent(), dt);
        g_lastDayCheck = TimeCurrent();

        // Validasi hari di dalam if
        if (dt.day_of_week == 0 || dt.day_of_week == 6) // Senin-Jumat
        {
            errorMsg = StringFormat("Error: Hari ini tidak ada trading %s [%s]",
                                    symbol, currentTime);
            return TIME_ERROR;
        }
    }

    // Cek jam trading setiap jam
    if (TimeCurrent() - g_lastHourCheck > 3600) // 3600 = 1 jam
    {
        MqlDateTime dt;
        TimeToStruct(TimeCurrent(), dt);
        g_lastHourCheck = TimeCurrent();

        // Validasi jam di dalam if
        if (dt.hour < 2 || dt.hour >= 22) // 07:00 - 16:00
        {
            errorMsg = StringFormat("Error: Diluar jam trading %s [%s]",
                                    symbol, currentTime);
            return TIME_ERROR;
        }
    }
    // Cek history order terakhir
    datetime lastOrderTime = 0;
    HistorySelect(0, TimeCurrent());

    for (int i = HistoryDealsTotal() - 1; i >= 0; i--)
    {
        ulong ticket = HistoryDealGetTicket(i);
        if (ticket > 0 && symbol == HistoryDealGetString(ticket, DEAL_SYMBOL))
        {
            datetime dealTime = (datetime)HistoryDealGetInteger(ticket, DEAL_TIME);
            if (dealTime > lastOrderTime)
                lastOrderTime = dealTime;
        }
    }
    int detik = 300;
    // Jika ada order dalam 1 jam terakhir
    if (lastOrderTime > 0 && (TimeCurrent() - lastOrderTime) < detik)
    {
        int menit = detik / 60;
        errorMsg = StringFormat("Error: Harus menunggu %d menit untuk %s. Last order (Waktu Server): [%s]",
                                menit, symbol, TimeToString(lastOrderTime, TIME_MINUTES));
        return TIME_ERROR;
    }

    // Validasi lainnya menggunakan currentTime yang sudah disimpan
    if (!SymbolSelect(symbol, true))
    {
        errorMsg = StringFormat("Error: Gagal memilih simbol %s [%s]", symbol, currentTime);
        return SYMBOL_ERROR;
    }

    if (!SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE))
    {
        errorMsg = StringFormat("Error: Trading tidak diizinkan untuk %s [%s]",
                                symbol, currentTime);
        return TRADE_MODE_ERROR;
    }

    int spread = (int)SymbolInfoInteger(symbol, SYMBOL_SPREAD);
    if (spread > 30)
    {
        errorMsg = StringFormat("Warning: Spread terlalu tinggi %s (%d) [%s]",
                                symbol, spread, currentTime);
        return SPREAD_ERROR;
    }

    return VALID;
}
static datetime g_lastUpdate = 0;
static datetime g_lastcekprint = 0;
void OnTick()
{

    if (TimeCurrent() - g_lastUpdate < 5)
    {

        return; // Keluar jika belum 5 detik
    }
    g_lastUpdate = TimeCurrent();

    int total = g_TotalSymbols;
    for (int i = 0; i < total; i++)
    {
        string symbol = g_SymbolName[i];
        string errorMsg = "";

        if (ValidateSymbol(symbol, errorMsg) != VALID)
        {
            if (TimeCurrent() - g_lastcekprint > 60)
            {
                if (debug)
                    Print(errorMsg);
                g_lastcekprint = TimeCurrent();
            }
            continue;
        }
        SignalOrder(symbol, g_HandleBB[i]);
    }
}
void CloseAllOrders()
{
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (position.SelectByIndex(i))
        {
            if (!trade.PositionClose(position.Ticket()))
                Print("Error closing position: ", GetLastError());
            else
                Print("Position closed: ", position.Symbol());
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

void SignalOrder(string symbol, int bbHandle)
{
    if (!symbolInfo.Name(symbol))
    {
        Print("Error setting symbol name");
        return;
    }
    if (!symbolInfo.RefreshRates())
    {
        Print("Error refreshing rates for ", symbol);
        return;
    }
    datetime last_bar_time = iTime(symbol, PERIOD_M1, 0);

    // Cek selisih waktu
    if (TimeCurrent() - last_bar_time > 120)
    {
        Print("Warning: Data gap detected - ", TimeCurrent() - last_bar_time, " seconds", symbol);
        Print("Last bar time: ", last_bar_time);
        Print("Current time: ", TimeCurrent());
        // Mencoba refresh data
        int attempts = 3;
        while (attempts > 0)
        {
            if (symbolInfo.RefreshRates())
            {
                // Cek lagi setelah refresh
                datetime new_bar_time = iTime(symbol, PERIOD_M1, 0);
                if (TimeCurrent() - new_bar_time <= 120)
                {
                    Print("Data successfully updated | ", symbol);
                    return;
                }
            }
            Sleep(100);
            attempts--;
        }

        // Jika masih gagal setelah 3x percobaan
        Print("Failed to get latest data after 3 attempts");
        return;
    }

    double hargaPenutupan = 0;
    double upperBand = 0, lowerBand = 0;
    double close_array[];
    ArraySetAsSeries(close_array, true);
    ArrayResize(close_array, 1);

    int copied = 0;
    copied = CopyClose(symbol, PERIOD_M1, 0, 1, close_array);
    if (copied <= 0)
    {
        Print("Error copying close price for ", symbol);
        return;
    }
    // Print("SYMBOL: ", symbol, " | CLOSE: ", close_array[0]);

    if (MathIsValidNumber(close_array[0]))
    {
        hargaPenutupan = close_array[0];
    }

    // Check existing position
    if (position.Select(symbol))
        return;

    // Langsung gunakan bbHandle yang sudah ada
    if (bbHandle == INVALID_HANDLE)
    {
        Print("BB handle invalid for ", symbol);
        return;
    }

    // Copy data
    double upper_band[], lower_band[];
    ArraySetAsSeries(upper_band, true);
    ArraySetAsSeries(lower_band, true);
    ArrayResize(upper_band, 3);
    ArrayResize(lower_band, 3);

    if (CopyBuffer(bbHandle, 1, 0, 3, upper_band) != 3 ||
        CopyBuffer(bbHandle, 2, 0, 3, lower_band) != 3)
    {
        Print("Error copying data for ", symbol, ": ", GetLastError());
        return;
    }
    if (upper_band[0] == EMPTY_VALUE || lower_band[0] == EMPTY_VALUE ||
        !MathIsValidNumber(upper_band[0]) || !MathIsValidNumber(lower_band[0]))
    {
        Print("Invalid BB data for ", symbol);
        return;
    }

    // 5. Normalize values
    long stopLevel = SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL);
    double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
    double minStopLoss = stopLevel * point;
    double spread = SymbolInfoInteger(symbol, SYMBOL_SPREAD) * point;
    int digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    upperBand = NormalizeDouble(upper_band[0], digits);
    lowerBand = NormalizeDouble(lower_band[0], digits);
    upperBand = upperBand + 20 * point;
    lowerBand = lowerBand - 20 * point;

    // Print("Upper Band: ", upperBand, " Lower Band: ", lowerBand, " Close: ", hargaPenutupan, "symbol: ", symbol, "Digits: ", digits);
    //  6. Check signals
    string signal = "";
    if (hargaPenutupan < lowerBand && hargaPenutupan < lower_band[1] && hargaPenutupan < lower_band[2])
        signal = "Beli";
    else if (hargaPenutupan > upperBand && hargaPenutupan > upper_band[1] && hargaPenutupan > upper_band[2])
        signal = "Jual";
    // Dapatkan stopLoss level minimum

    // 7. Execute orders
    double volume = 0.01;
    // Print("Signal: ", signal, " Symbol: ", symbol, " Harga Penutupan: ", hargaPenutupan, " Upper Band: ", upperBand, " Lower Band: ", lowerBand);
    if (signal == "Beli")
    {
        double stopLoss = NormalizeDouble(hargaPenutupan - spread - (stoploss * point), digits); // NormalizeDouble(hargaPenutupan - (100 * point), digits);
        if (MathAbs(hargaPenutupan - stopLoss) < minStopLoss)
        {
            stopLoss = NormalizeDouble(hargaPenutupan - minStopLoss, digits);
        }
        if (!trade.Buy(volume, symbol, 0.0, stopLoss, 0, "Buy Signal")) // Menggunakan variable volume
        {
            Print("Error Buy Order: ", trade.ResultRetcodeDescription(),
                  " Lower Band : ", lowerBand, " Harga Ask Real :", SymbolInfoDouble(symbol, SYMBOL_ASK), " SL : ", stopLoss);

            return;
        }
        Print("Buy Order #", trade.ResultOrder(), " ", symbol, " [", TimeToString(TimeLocal(), TIME_MINUTES),
              "] Harga Bid:", hargaPenutupan, " Lower Band : ", lowerBand);
    }
    else if (signal == "Jual")
    {
        double stopLoss = NormalizeDouble(hargaPenutupan + spread + (stoploss * point), digits);
        if (MathAbs(stopLoss - hargaPenutupan) < minStopLoss)
        {
            stopLoss = NormalizeDouble(hargaPenutupan + minStopLoss, digits);
            Print("StopLoss disesuaikan ke level minimum untuk ", symbol);
        }
        if (!trade.Sell(volume, symbol, 0.0, stopLoss, 0, "Sell Signal")) // Menggunakan variable volume
        {
            Print("Error Sell Order: ", trade.ResultRetcodeDescription(),
                  " Upper Band : ", upperBand, " Harga Bid Real : ", SymbolInfoDouble(symbol, SYMBOL_BID), " SL : ", stopLoss);

            return;
        }
        Print("Sell Order #", trade.ResultOrder(), " ", symbol, " [", TimeToString(TimeLocal(), TIME_MINUTES),
              "] Upper Band:", upperBand, " Harga Ask:", hargaPenutupan);
    }
}

void OnTimer()
{
    targetManager.ShowTargetOnChart();
    targetManager.CheckAndCloseAllOrders();
}
// Variabel global untuk menyimpan timeframe terakhir
