
#property copyright "Copyright 2024, Ali Usman"
#property version "1.00"
#property strict
#include "StrategyBuilder/Input.mqh"
#include "StrategyBuilder/Fungsi.mqh"

struct symbolInfo
{
    string symbol;
    int signalBase;
    int finalsignal;
    int handle[];
    int signal[];
    bool isActive[];
    bool isBuy[];
    bool isSell[];
    ENUM_TIMEFRAMES timeframe[];
    int signal_type[]; // Hnya aktif di signal multi untuuk mmbandingkan signal dengan kondisi indikator
};
symbolInfo symbolArray[];
// variable Global
int totalHandles = 1;
int totalSymbols;
double lotGrid;

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    if (id == CHARTEVENT_OBJECT_CLICK && sparam == "closeall") // Jika tombol diklik
    {
        int result = MessageBox("Apakah anda yakin ingin menutup semua order?",
                                "Konfirmasi Close All",
                                MB_YESNO | MB_ICONQUESTION);

        if (result == IDYES)
        {
            CloseAllOrders();
        }
    }
    if (id == CHARTEVENT_OBJECT_CLICK && sparam == "closeallsymbol") // Jika tombol diklik
    {
        int result = MessageBox("Apakah anda yakin ingin menutup semua symbol ini?",
                                "Konfirmasi Close All",
                                MB_YESNO | MB_ICONQUESTION);

        if (result == IDYES)
        {
            CloseAllOrders(_Symbol);
        }
    }
}

void InitMain()
{

    EventSetTimer(5);
    CreateCloseButton();
    CreateCloseButtonSymbol();
    SetTargetBalance();
}

int OnInit()
{
    InitMain();
    InitSymbol();
    InitHandle();
    return (INIT_SUCCEEDED);
}
void OnTick()
{
    MainTargetOnChart();
    MainHiddenTPSL();
    MainAddFeature();
}
void OnTimer()
{
    bool isDebug = (debug == ON);
    string message = "";
    if (IncMainFilterGeneral(message) != FILTER_PASS)
    {
        if (isDebug)
            Print(message);
        return;
    }
    MainGetSetSignal();
    MainSignal();
    MainOrder();
    if (isDebug)
        IncGetDataSymbol();
}

void OnDeinit(const int reason)
{

    for (int i = 0; i < totalSymbols; i++)
    {
        for (int j = 0; j < totalHandles; j++)
        {
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                bool released = IndicatorRelease(symbolArray[i].handle[j]);
                if (released)
                    Print("Handle released: ", symbolArray[i].symbol, " handle[", j, "]=", symbolArray[i].handle[j]);
                symbolArray[i].handle[j] = INVALID_HANDLE;
            }
        }
    }
    ObjectsDeleteAll(0);
    EventKillTimer();
}

enum ENUM_FILTER_RESULT
{
    FILTER_PASS,        // Lolos filter
    FILTER_WRONG_TIME,  // Diluar jam trading
    FILTER_HOLIDAY,     // Hari libur
    FILTER_POWER_OFF,   // Power off
    FILTER_SIGNAL_MODE, // Signal mode disabled

};

ENUM_FILTER_RESULT IncMainFilterGeneral(string &message)
{

    if (power == OFF)
    {
        message = "Filter: power off / signal mode disabled";
        return FILTER_POWER_OFF;
    }
    if (signal_mode == ENUM_MODE_SIGNAL::DISABLE)
    {
        message = "Filter: signal mode disabled";
        return FILTER_SIGNAL_MODE;
    }

    if (setting_filter == OFF)
    {
        message = "Filter: disabled";
        return FILTER_PASS;
    }

    datetime time = TimeCurrent();
    MqlDateTime dt;
    TimeToStruct(time, dt);
    // Cek jam trading
    if ((dt.hour < jam_start || dt.hour >= jam_end) && (jam_start != 0 && jam_end != 0))
    {
        message = StringFormat("Filter: diluar jam trading (%d:%d)",
                               dt.hour, dt.min);
        return FILTER_WRONG_TIME;
    }

    // Cek hari yang tidak boleh trading
    if (no_day_trading1 != Disable || no_day_trading2 != Disable)
    {
        if (dt.day_of_week == no_day_trading1 || dt.day_of_week == no_day_trading2)
        {
            message = StringFormat("Filter: tidak trading di hari %s",

                                   EnumToString((ENUM_DAY_INDO)dt.day_of_week));
            return FILTER_HOLIDAY;
        }
    }

    message = ("Filter: passed all conditions");
    return FILTER_PASS;
}

void InitSymbol()
{

    //  ArrayFree(symbolArray);

    string symboldata[];
    if (multi_symbol == ENUM_SYMBOL_TYPE::MULTI_SYMBOL)
        totalSymbols = SymbolsTotal(true);
    else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM)
    {
        if (multi_symbol_custom == "")
            string symbols = "EURUSD,GBPUSD,USDJPY";
        StringSplit(multi_symbol_custom, ',', symboldata);
        totalSymbols = ArraySize(symboldata);
    }
    else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM1)
    {
        if (multi_symbol_custom1 == "")
            string symbols = "EURUSD,GBPUSD,USDJPY";
        StringSplit(multi_symbol_custom1, ',', symboldata);
        totalSymbols = ArraySize(symboldata);
    }
    else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM2)
    {
        if (multi_symbol_custom2 == "")
            string symbols = "EURUSD,GBPUSD,USDJPY";
        StringSplit(multi_symbol_custom2, ',', symboldata);
        totalSymbols = ArraySize(symboldata);
    }
    else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM3)
    {
        if (multi_symbol_custom3 == "")
            string symbols = "EURUSD,GBPUSD,USDJPY";
        StringSplit(multi_symbol_custom3, ',', symboldata);
        totalSymbols = ArraySize(symboldata);
    }
    else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_BASE)
    {

        int t = SymbolsTotal(true); // Total simbol yang tersedia
        int total = 0;
        for (int i = 0; i < t; i++)
        {
            string symbol = SymbolName(i, true);
            if (IsCorrelatedSymbol(symbol, TradingBaseOnSymbol))
                total++;
        }
        totalSymbols = total;
    }
    else
        totalSymbols = 1;

    // Reset semua nilai signalBase ke 0 saat inisialisasi
    ArrayResize(symbolArray, totalSymbols);
    for (int i = 0; i < totalSymbols; i++)
    {
        symbolArray[i].signalBase = 0;
        symbolArray[i].finalsignal = 0;
    }
    if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_BASE)
    {
        int t = SymbolsTotal(true);
        int h = 0;
        for (int i = 0; i < t; i++)
        {
            string symbol = SymbolName(i, true);
            if (!IsCorrelatedSymbol(symbol, TradingBaseOnSymbol))
                continue;
            symbolArray[h].symbol = symbol;
            symbolArray[h].signalBase = GetSignalBase(symbol, TradingBaseOnSymbol);
            h++;
        }
    }
    else
    {
        for (int i = 0; i < totalSymbols; i++)
        {
            // // Reset signalBase ke 0 untuk tipe symbol lainnya
            // symbolArray[i].signalBase = 0; // Tambahkan ini
            if (multi_symbol == ENUM_SYMBOL_TYPE::MULTI_SYMBOL)
                symbolArray[i].symbol = SymbolName(i, true);
            else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM)
                symbolArray[i].symbol = symboldata[i];
            else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM1)
                symbolArray[i].symbol = symboldata[i];
            else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM2)
                symbolArray[i].symbol = symboldata[i];
            else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM3)
                symbolArray[i].symbol = symboldata[i];

            else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CURRENT)
                symbolArray[i].symbol = _Symbol;
        }
    }
}
void InitHandle()
{
    totalHandles = (signal_mode == MODE_SIGNAL_MANUAL) ? siganl_manual_total : 11;
    Print("totalHandles = ", totalHandles);
    for (int i = 0; i < totalSymbols; i++)
    {
        // inisialisasi
        ArrayResize(symbolArray[i].handle, totalHandles);
        ArrayResize(symbolArray[i].signal, totalHandles);
        ArrayResize(symbolArray[i].isActive, totalHandles);
        ArrayResize(symbolArray[i].isBuy, totalHandles);
        ArrayResize(symbolArray[i].isSell, totalHandles);
        ArrayResize(symbolArray[i].timeframe, totalHandles);
        ArrayResize(symbolArray[i].signal_type, totalHandles);

        for (int j = 0; j < totalHandles; j++)
        {
            // Inisialisasi
            if (signal_mode == MODE_SIGNAL_MULTI)
            {
                symbolArray[i].signal[j] = 0;
                symbolArray[i].isActive[j] = false;
                symbolArray[i].isBuy[j] = false;
                symbolArray[i].isSell[j] = false;
                symbolArray[i].timeframe[j] = 0;
                symbolArray[i].signal_type[j] = 0;

                if (j <= 5)
                    IncHandleMa(i, j);
                else
                    IncHandleBB(i, j);
            }
            else if (signal_mode == MODE_SIGNAL_MANUAL)
            {
                // Inisialisasi
                symbolArray[i].signal[j] = 0;
                symbolArray[i].isActive[j] = true;
                symbolArray[i].isBuy[j] = true;
                symbolArray[i].isSell[j] = true;
                symbolArray[i].timeframe[j] = 0;
                symbolArray[i].signal_type[j] = 0;
            }
        }
        if (signal_mode == MODE_SIGNAL_MULTI)
        {
            // Hapus handle yang tidak aktif
            for (int j = totalHandles - 1; j >= 0; j--) // Loop dari belakang
            {
                if (!symbolArray[i].isActive[j])
                {
                    // Release handle jika ada
                    if (symbolArray[i].handle[j] != INVALID_HANDLE)
                        IndicatorRelease(symbolArray[i].handle[j]);

                    // Hapus elemen dari semua array
                    ArrayRemove(symbolArray[i].handle, j, 1);
                    ArrayRemove(symbolArray[i].signal, j, 1);
                    ArrayRemove(symbolArray[i].isActive, j, 1);
                    ArrayRemove(symbolArray[i].isBuy, j, 1);
                    ArrayRemove(symbolArray[i].isSell, j, 1);
                    ArrayRemove(symbolArray[i].timeframe, j, 1);
                    ArrayRemove(symbolArray[i].signal_type, j, 1);
                }
            }

            // Update totalHandles untuk symbol ini
            totalHandles = ArraySize(symbolArray[i].handle);
            Print("Symbol ", symbolArray[i].symbol, " active handles: ", totalHandles);
        }
    }
    if (signal_mode == MODE_SIGNAL_MANUAL)
    {
        incHandleManual();
    }
}

void MainGetSetSignal()
{
    // reset all signal
    for (int s = 0; s < totalSymbols; s++)
    {
        symbolArray[s].finalsignal = 0;
        for (int h = 0; h < totalHandles; h++)
        {
            symbolArray[s].signal[h] = 0;
        }
    }

    if (signal_mode == ENUM_MODE_SIGNAL::DISABLE)
        return;
    if (signal_mode == MODE_SIGNAL_MANUAL)
    {
        IncGetSetSignalManual();
        return;
    }

    for (int i = 0; i < totalSymbols; i++)
    {
        string symbol = symbolArray[i].symbol;
        if ((int)SymbolInfoInteger(symbol, SYMBOL_SPREAD) > max_spread)
        {
            if (debug == ON)
                Print("Symbol " + symbol + " memiliki spread lebih besar dari maksimal spread yang diizinkan");
            continue;
        }

        for (int j = 0; j < totalHandles; j++)
        {
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                double value1[];
                double value2[];
                ArraySetAsSeries(value1, true);
                ArraySetAsSeries(value2, true);

                if (j <= 5)
                {
                    if (IncBufferMA(symbolArray[i].handle[j], 2, value1))
                    {
                        IncUpdateSignalMA(i, j, value1);
                    }
                }
                // Untuk BB (index 6-10)
                else if (j >= 6 && j <= 10)
                {
                    if (IncBufferBB(symbolArray[i].handle[j], 2, value1, value2))
                    {
                        IncUpdateSignalBB(i, j, value1, value2);
                    }
                }
            }
        }
    }
}
bool IncBufferBB(int handle, int t, double &value1[], double &value2[])
{
    int upper = CopyBuffer(handle, 1, 0, t, value1);
    int lower = CopyBuffer(handle, 2, 0, t, value2);
    if (upper == t && lower == t)
        return true;
    return false;
}
bool IncBufferMA(int handle, int t, double &value1[])
{
    int count = CopyBuffer(handle, 0, 0, t, value1);
    if (count == t)
        return true;
    return false;
}

void IncUpdateSignalMA(int i, int j, double &value1[])
{
    double i0 = value1[0];
    double i1 = value1[1];

    double p0 = iClose(symbolArray[i].symbol, symbolArray[i].timeframe[j], 0);
    double p1 = iClose(symbolArray[i].symbol, symbolArray[i].timeframe[j], 1);

    // Inisialisasi signal
    symbolArray[i].signal[j] = 0; // Reset di awal

    // Cek Buy
    if (symbolArray[i].isBuy[j])
    {
        switch (symbolArray[i].signal_type[j])
        {
        case ENUM_SIGNAL_TYPE::CROSS: // Cross
            if (p0 > i0 && p1 < i1)
                symbolArray[i].signal[j] = 1;
            break;

        case ENUM_SIGNAL_TYPE::UP_DOWN: // Up Down
            if (p0 > i0)
                symbolArray[i].signal[j] = 1;
            break;

        case ENUM_SIGNAL_TYPE::UP_DOWN_REVERSE: // Up Down Reverse
            if (p0 < i0)
                symbolArray[i].signal[j] = 1;
            break;
        }
    }

    // Cek Sell - hanya jika tidak ada buy signal
    if (symbolArray[i].isSell[j] && symbolArray[i].signal[j] == 0)
    {
        switch (symbolArray[i].signal_type[j])
        {
        case ENUM_SIGNAL_TYPE::CROSS:
            if (p0 < i0 && p1 > i1)
                symbolArray[i].signal[j] = -1;
            break;

        case ENUM_SIGNAL_TYPE::UP_DOWN:
            if (p0 < i0)
                symbolArray[i].signal[j] = -1;
            break;

        case ENUM_SIGNAL_TYPE::UP_DOWN_REVERSE:
            if (p0 > i0)
                symbolArray[i].signal[j] = -1;
            break;
        }
    }
}
void IncUpdateSignalBB(int i, int j, double &value1[], double &value2[])
{
    double upper0 = value1[0];
    double upper1 = value1[1];
    double lower0 = value2[0];
    double lower1 = value2[1];

    double p0 = iClose(symbolArray[i].symbol, symbolArray[i].timeframe[j], 0);
    double p1 = iClose(symbolArray[i].symbol, symbolArray[i].timeframe[j], 1);

    // Inisialisasi signal
    symbolArray[i].signal[j] = 0; // Reset di awal
                                  // Cek Buy

    if (symbolArray[i].isBuy[j])
    {
        if (symbolArray[i].signal_type[j] == 0)
        {
            if (p0 > upper0 && p1 < upper1)
                symbolArray[i].signal[j] = 1;
        }
        else if (symbolArray[i].signal_type[j] == 1)
        {
            if (p0 > upper0)
                symbolArray[i].signal[j] = 1;
        }
        else if (symbolArray[i].signal_type[j] == 2)
        {
            if (p0 < lower0 && p1 > lower1)
                symbolArray[i].signal[j] = 1;
        }
        else if (symbolArray[i].signal_type[j] == 3)
        {
            if (p0 < lower0)
                symbolArray[i].signal[j] = 1;
        }
    }

    // Cek Sell - hanya jika tidak ada buy signal
    if (symbolArray[i].isSell[j] && symbolArray[i].signal[j] == 0)
    {
        if (symbolArray[i].signal_type[j] == 0)
        {
            if (p0 < lower0 && p1 > lower1)
                symbolArray[i].signal[j] = -1;
        }
        else if (symbolArray[i].signal_type[j] == 1)
        {
            if (p0 < lower0)
                symbolArray[i].signal[j] = -1;
        }
        else if (symbolArray[i].signal_type[j] == 2)
        {
            if (p0 > upper0 && p1 < upper1)
                symbolArray[i].signal[j] = -1;
        }
        else if (symbolArray[i].signal_type[j] == 3)
        {
            if (p0 > upper0)
                symbolArray[i].signal[j] = -1;
        }
    }
}

void MainSignal()
{
    bool signalcombination = (combi_signal == AND);
    for (int i = 0; i < totalSymbols; i++)
    {
        bool flagOrbuy = false;
        bool flagOrsell = false;
        bool allSignalsBuy = true;
        bool allSignalsSell = true;
        bool hasActiveHandle = false; // Flag untuk menandai ada handle aktif
        bool hasActiveBuy = false;    // Tambah flag untuk buy aktif
        bool hasActiveSell = false;   // Tambah flag untuk sell aktif
                                      // Cek semua handle dalam symbol
        for (int j = 0; j < totalHandles; j++)
        {
            // Hanya proses handle yang aktif
            if (symbolArray[i].isActive[j])
            {
                hasActiveHandle = true; // Set true jika ada handle aktif

                // Cek Buy Signal
                if (symbolArray[i].isBuy[j])
                {
                    hasActiveBuy = true;

                    // cek signl combination
                    if (signalcombination)
                    {
                        if (symbolArray[i].signal[j] != 1)
                        {
                            allSignalsBuy = false;
                        }
                    }
                    else
                    {

                        if (symbolArray[i].signal[j] == 1)
                        {
                            flagOrbuy = true;
                        }
                    }
                }

                // Cek Sell Signal
                if (symbolArray[i].isSell[j])
                {
                    hasActiveSell = true;

                    // cek signl combination
                    if (signalcombination)
                    {
                        if (symbolArray[i].signal[j] != -1)
                        {
                            allSignalsSell = false;
                        }
                    }
                    else
                    {
                        if (symbolArray[i].signal[j] == -1)
                        {
                            flagOrsell = true;
                        }
                    }
                }
            }
        }

        // Update final signal jika ada minimal 1 handle aktif
        if (hasActiveHandle)
        {
            if (signalcombination)
            {
                if (allSignalsBuy && hasActiveBuy)
                {
                    symbolArray[i].finalsignal = 1;
                    if (debug == ON)
                        Print("Final Signal Update: ", symbolArray[i].symbol, " = 1 (BUY)");
                }
                else if (allSignalsSell && hasActiveSell)
                {
                    symbolArray[i].finalsignal = -1;
                    if (debug == ON)
                        Print("Final Signal Update: ", symbolArray[i].symbol, " = -1 (SELL)");
                }
            }
            else
            {
                if (flagOrbuy && hasActiveBuy)
                    symbolArray[i].finalsignal = 1;
                else if (flagOrsell && hasActiveSell)
                    symbolArray[i].finalsignal = -1;
            }
        }
    }
}
void IncGetDataSymbol()
{
    for (int i = 0; i < totalSymbols; i++)
    {

        for (int j = 0; j < totalHandles; j++)
        {

            Print(
                "symbol: ", symbolArray[i].symbol,
                " handle: ", symbolArray[i].handle[j],
                " signal: ", symbolArray[i].signal[j],
                " isActive: ", symbolArray[i].isActive[j],
                " isBuy: ", symbolArray[i].isBuy[j],
                " isSell: ", symbolArray[i].isSell[j],
                " timeframe: ", symbolArray[i].timeframe[j],
                " signal_type: ", symbolArray[i].signal_type[j],
                "signal_base: ", symbolArray[i].signalBase);
        }
        Print("================================================");
        Print("finall signal: ", symbolArray[i].finalsignal);
        Print("================================================");
    }
}

void MainOrder()
{

    bool flagsignal = false;
    // Jika ada signal Base jalankan ini dulu
    if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_BASE)
    {
        for (int i = 0; i < totalSymbols; i++)
        {
            if (symbolArray[i].finalsignal == 0)
                continue;
            if (symbolArray[i].finalsignal != symbolArray[i].signalBase)
                symbolArray[i].finalsignal = 0;
        }
    }
    trade.SetExpertMagicNumber(magic_number);

    for (int i = 0; i < totalSymbols; i++)
    {
        if (symbolArray[i].finalsignal == 0)
            continue;
        if (!IncFilterOrder(i))
            continue;

        string symbol = symbolArray[i].symbol;
        double ask, bid;

        if (!SymbolInfoDouble(symbol, SYMBOL_ASK, ask) || !SymbolInfoDouble(symbol, SYMBOL_BID, bid))
        {
            Print("Error getting price for ", symbol);
            continue;
        }

        double spread = ask - bid;
        int digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
        double min_sl = SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL) * point;
        double sl = 0, tp = 0;

        if (Stoploss > 0)
        {
            if (symbolArray[i].finalsignal == 1)
            {
                sl = ask - (Stoploss * point) - spread;
                if (ask - sl < min_sl)
                    sl = ask - min_sl - spread;
            }
            else
            {
                sl = bid + (Stoploss * point) + spread;
                if (sl - bid < min_sl)
                    sl = bid + min_sl + spread;
            }
        }

        if (Takeprofit > 0)
        {
            if (symbolArray[i].finalsignal == 1)
                tp = ask + (Takeprofit * point);
            else
                tp = bid - (Takeprofit * point);
        }

        double orderlot = IncCalcLot(symbol);
        Print(orderlot);
        bool order;
        bool hasPosition = false;
        for (int i = 0; i < PositionsTotal(); i++)
        {
            if (pos.SelectByIndex(i) && pos.Symbol() == symbol && pos.Magic() == magic_number)
            {
                hasPosition = true;
                break;
            }
        }
        if (hasPosition)
            orderlot = lotGrid;

        if (symbolArray[i].finalsignal == 1)
        {
            order = trade.Buy(orderlot, symbol, ask, sl, tp, komment);
            if (order)
            {
                if (debug == ON)
                    Print("Order Buy: ", symbol, " Time Lokal: ", TimeLocal(), " Magic Number: ", magic_number);
            }
            else
            {
                if (debug == ON)
                    Print("Error Order Buy: ", GetLastError());
            }
        }
        else
        {
            order = trade.Sell(orderlot, symbol, bid, sl, tp, komment);
            if (order)
            {
                if (debug == ON)
                    Print("Order Sell: ", symbol, " Time Lokal: ", TimeLocal(), " Magic Number: ", magic_number);
            }
            else
            {
                if (debug == ON)
                    Print("Error Order Sell: ", GetLastError());
            }
        }
    }
}

bool IncFilterOrder(int n)
{
    string symbol = symbolArray[n].symbol;

    if (trading_direction != ALL)
    {
        switch (trading_direction)
        {
        case ENUM_TRADING_DIRECTION::BUY:
            if (symbolArray[n].finalsignal != 1)
                return false;
            break;
        case ENUM_TRADING_DIRECTION::SELL:
            if (symbolArray[n].finalsignal != -1)
                return false;
            break;
        }
    }

    int total_positions = PositionsTotal();
    switch (one_order_type)
    {
    case ONE_ORDER_PER_SYMBOL:
    {
        for (int i = 0; i < total_positions; i++)
        {
            if (pos.SelectByIndex(i) && pos.Symbol() == symbol && pos.Magic() == magic_number)
                return false;
        }
        break;
    }
    case ONE_ORDER_TOTAL_POSITION:
    {
        for (int i = 0; i < total_positions; i++)
        {
            if (pos.SelectByIndex(i) && pos.Magic() == magic_number)
                return false;
        }
        break;
    }
    case ONE_ORDER_PER_TIMEFRAME_SYMBOL_MAGIC_NUMBER:
    {
        datetime bar_time = iTime(symbol, one_order_timeframe, 0);
        double current_price = SymbolInfoDouble(symbol, SYMBOL_BID);

        for (int i = 0; i < total_positions; i++)
        {
            if (pos.SelectByIndex(i) && pos.Symbol() == symbol && pos.Magic() == magic_number)
            {
                // Cek waktu
                if (pos.Time() >= bar_time)
                    return false;

                // Cek jarak minimal
                if (min_distance_points > 0)
                {
                    double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
                    double distance = MathAbs(current_price - pos.PriceOpen()) / point;
                    if (distance < min_distance_points)
                        return false;
                }
            }
        }
        break;
    }

    case ORDER_MAX_CUSTOM:
    {
        if (max_order > 0 || max_order_total > 0)
        {
            int symbol_positions = 0;
            int total_positions = 0;
            double current_price = SymbolInfoDouble(symbol, SYMBOL_BID);

            // Gunakan PositionsTotal() untuk loop
            for (int i = 0; i < PositionsTotal(); i++)
            {
                if (!pos.SelectByIndex(i) || pos.Magic() != magic_number)
                    continue;

                // Hitung total posisi dengan magic number yang sama
                total_positions++;

                // Cek symbol yang sama
                if (pos.Symbol() == symbol)
                {
                    symbol_positions++;

                    // Cek jarak minimal
                    if (min_distance_points > 0)
                    {
                        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
                        double distance = MathAbs(current_price - pos.PriceOpen()) / point;
                        if (distance < min_distance_points)
                        {
                            Print("Distance too close: ", distance, " points");
                            return false;
                        }
                    }
                }
            }

            // Cek max order per symbol
            if (max_order > 0 && symbol_positions >= max_order)
            {
                Print("Max orders per symbol reached: ", symbol_positions, "/", max_order);
                return false;
            }

            // Cek total max order
            if (max_order_total > 0 && total_positions >= max_order_total)
            {
                Print("Max total orders reached: ", total_positions, "/", max_order_total);
                return false;
            }
        }
    }
    break;
    case ORDER_MODE_GRID_LOSS:
    case ORDER_MODE_GRID_PROFIT:
    {
        // Validasi arah grid di awal
        if (grid_direction_setting == GRID_BUY_ONLY && symbolArray[n].finalsignal != 1)
        {
            if (debug == ON)
                Print("Signal tidak sesuai untuk GRID_BUY_ONLY");
            return false;
        }
        if (grid_direction_setting == GRID_SELL_ONLY && symbolArray[n].finalsignal != -1)
        {
            if (debug == ON)
                Print("Signal tidak sesuai untuk GRID_SELL_ONLY");
            return false;
        }
        double current_price = SymbolInfoDouble(symbol, SYMBOL_ASK);
        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
        double min_distance = (grid_min > 0) ? grid_min * point : 30 * point;
        double highest_price = 0;
        double lowest_price = 0;
        double last_price = 0;
        datetime latest_time = 0;
        int t = 0;

        // Cari harga tertinggi, terendah dan terakhir untuk symbol ini saja
        for (int i = 0; i < total_positions; i++)
        {
            if (!pos.SelectByIndex(i))
                continue;

            // Hanya proses untuk symbol yang sama
            if (pos.Symbol() != symbol || pos.Magic() != magic_number)
                continue;

            double pos_price = pos.PriceOpen();

            if (latest_time == 0 || pos.Time() > latest_time)
            {
                last_price = pos_price;
                latest_time = pos.Time();
            }

            if (highest_price == 0 || pos_price > highest_price)
                highest_price = pos_price;
            if (lowest_price == 0 || pos_price < lowest_price)
                lowest_price = pos_price;

            t++;
        }

        // Jika belum ada posisi untuk symbol ini, boleh order
        if (t == 0)
            return true;

        // Cek GRID_BUY_ONLY
        if (grid_direction_setting == GRID_BUY_ONLY)
        {
            if (last_price > 0)
            {
                if (one_order_type == ORDER_MODE_GRID_PROFIT)
                {
                    if (current_price <= highest_price)
                        return false;
                }
                else // Grid Loss
                {
                    if (current_price >= lowest_price)
                        return false;
                }
                if (MathAbs(current_price - last_price) < min_distance)
                {
                    if (debug == ON)
                        Print(MathAbs(current_price - last_price), " < ", min_distance);
                    return false;
                }
            }
        }

        // Cek GRID_SELL_ONLY
        else if (grid_direction_setting == GRID_SELL_ONLY)
        {
            if (last_price > 0)
            {
                if (one_order_type == ORDER_MODE_GRID_PROFIT)
                {
                    if (current_price >= lowest_price)
                        return false;
                }
                else // Grid Loss
                {
                    if (current_price <= highest_price)
                        return false;
                }
                if (MathAbs(current_price - last_price) < min_distance)
                    return false;
            }
        }

        // Cek GRID_AUTO_FOLLOW
        else if (grid_direction_setting == GRID_AUTO_FOLLOW)
        {
            ENUM_POSITION_TYPE first_position_type = WRONG_VALUE;
            datetime first_position_time = 0;

            // Cari posisi pertama untuk symbol ini
            for (int i = 0; i < total_positions; i++)
            {
                if (!pos.SelectByIndex(i) || pos.Symbol() != symbol)
                    continue;

                if (first_position_time == 0 || pos.Time() < first_position_time)
                {
                    first_position_time = pos.Time();
                    first_position_type = pos.PositionType();
                }
            }

            if (first_position_time > 0)
            {
                if (one_order_type == ORDER_MODE_GRID_PROFIT)
                {
                    if (first_position_type == POSITION_TYPE_BUY)
                    {
                        if (symbolArray[n].finalsignal != 1)
                            return false;
                        if (current_price <= highest_price)
                            return false;
                    }
                    else // SELL
                    {
                        if (symbolArray[n].finalsignal != -1)
                            return false;
                        if (current_price >= lowest_price)
                            return false;
                    }
                }
                else // Grid Loss
                {
                    if (first_position_type == POSITION_TYPE_BUY)
                    {
                        if (symbolArray[n].finalsignal != 1)
                            return false;
                        if (current_price >= lowest_price)
                            return false;
                    }
                    else // SELL
                    {
                        if (symbolArray[n].finalsignal != -1)
                            return false;
                        if (current_price <= highest_price)
                            return false;
                    }
                }

                // Cek jarak minimal
                if (MathAbs(current_price - last_price) < min_distance)
                {
                    if (debug == ON)
                        Print("Jarak minimal tidak terpenuhi: ", MathAbs(current_price - last_price), " < ", min_distance);
                    return false;
                }
            }
        }

        // Cek maksimum grid untuk symbol ini
        if (max_grid > 0 && t >= max_grid)
        {
            if (debug == ON)
                Print("Grid order: ", symbol, " sudah mencapai max grid (", max_grid, ")");
            return false;
        }

        if (mode_grid_timeframe == ON)
        {
            datetime bar_time = iTime(symbol, one_order_timeframe, 0);
            for (int i = 0; i < total_positions; i++)
            {
                if (pos.SelectByIndex(i) && pos.Symbol() == symbol && pos.Magic() == magic_number && pos.Time() >= bar_time)
                    return false;
            }
        }
        // Tambahan kalkulasi lot grid
        if (grid_lot_mode != GRID_DISABLE)
        {
            lotGrid = lot; // Set default ke lot dari input
            double lastLot = 0;
            int positionCount = 0;

            if (grid_lot_mode == GRID_LOT_MULTIPLY || grid_lot_mode == GRID_LOT_ADD || grid_lot_mode == GRID_LOT_CUSTOM)
            {
                for (int i = 0; i < total_positions; i++)
                {
                    if (pos.SelectByIndex(i) &&
                        pos.Symbol() == symbol &&
                        pos.Magic() == magic_number)
                    {
                        positionCount++;
                        lastLot = pos.Volume();
                    }
                }

                if (lastLot > 0)
                {
                    if (grid_lot_mode == GRID_LOT_MULTIPLY)
                    {
                        // Menggunakan lot input sebagai dasar
                        lotGrid = lot * MathPow(martingale_multiplier, positionCount);
                    }
                    else if (grid_lot_mode == GRID_LOT_ADD)
                    {
                        // Menggunakan lot input sebagai dasar
                        lotGrid = lot + (grid_add_value * positionCount);
                    }
                    else if (grid_lot_mode == GRID_LOT_CUSTOM)
                    {
                        string lots[];
                        int total_lots = StringSplit(grid_lot_custom, ',', lots);

                        // Konversi string ke array double
                        double custom_lots[];
                        ArrayResize(custom_lots, total_lots);

                        for (int i = 0; i < total_lots; i++)
                        {
                            custom_lots[i] = StringToDouble(lots[i]);
                        }

                        // Gunakan lot sesuai urutan grid
                        if (positionCount < total_lots)
                        {
                            lotGrid = custom_lots[positionCount];
                        }
                        else
                        {
                            // Jika melebihi jumlah lot yang didefinisikan, gunakan lot terakhir
                            lotGrid = custom_lots[total_lots - 1];
                        }
                    }
                }
            }
            else if (grid_lot_mode == GRID_LOT_FIXED)
            {
                lotGrid = fixed_lot;
            }
        }

        if (grid_max_lot > 0 && lotGrid > grid_max_lot)
            lotGrid = grid_max_lot;

        break;
    }
    }
    return true;
}

void MainHiddenTPSL()
{
    if (InpStopLoss == 0 && InpTakeProfit == 0)
        return;

    trade.SetExpertMagicNumber(magic_number);
    for (int i = 0; i < PositionsTotal(); i++)
    {
        if (!pos.SelectByIndex(i))
            continue;

        if (pos.Magic() != magic_number)
            continue;

        string symbol = pos.Symbol();
        double entry_price = pos.PriceOpen();
        double current_price = pos.PriceCurrent();
        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
        double floating_points = 0;

        if (pos.PositionType() == POSITION_TYPE_BUY)
        {
            floating_points = (current_price - entry_price) / point;

            // Cek SL jika diaktifkan
            if (InpStopLoss > 0 && (int)floating_points <= -InpStopLoss)
            {
                if (trade.PositionClose(pos.Ticket()))
                {
                    if (debug == ON)
                        Print("Hidden SL: Close BUY position ", symbol,
                              " Loss: ", floating_points, " points");
                }
            }

            // Cek TP jika diaktifkan
            if (InpTakeProfit > 0 && (int)floating_points >= InpTakeProfit)
            {
                if (trade.PositionClose(pos.Ticket()))
                {
                    if (debug == ON)
                        Print("Hidden TP: Close BUY position ", symbol,
                              " Profit: ", floating_points, " points");
                }
            }
        }
        else if (pos.PositionType() == POSITION_TYPE_SELL)
        {
            floating_points = (entry_price - current_price) / point;

            // Cek SL jika diaktifkan
            if (InpStopLoss > 0 && floating_points <= -InpStopLoss)
            {
                if (trade.PositionClose(pos.Ticket()))
                {
                    if (debug == ON)
                        Print("Hidden SL: Close SELL position ", symbol,
                              " Loss: ", floating_points, " points");
                }
            }

            // Cek TP jika diaktifkan
            if (InpTakeProfit > 0 && floating_points >= InpTakeProfit)
            {
                if (trade.PositionClose(pos.Ticket()))
                {
                    if (debug == ON)
                        Print("Hidden TP: Close SELL position ", symbol,
                              " Profit: ", floating_points, " points");
                }
            }
        }
    }
}

void MainTargetOnChart()
{
    if (m_targetProfit > 0)
    {
        if (IsNewBar(PERIOD_M1))
        {
            ShowTargetOnChart();
            CheckAndCloseAllOrders();
        }
    }
}

double IncCalcLot(string symbol)
{
    double calculated_lot = lot;

    switch (lot_type)
    {
    case LOT_FIXED:
    {
        calculated_lot = lot;
    }
    break;

    case LOT_BALANCE:
    {
        double balance = AccountInfoDouble(ACCOUNT_BALANCE);
        calculated_lot = NormalizeDouble((balance / lot_balance) * lot, 2);
    }
    break;
    case LOT_EQUITY:
    {
        double equity = AccountInfoDouble(ACCOUNT_EQUITY);
        calculated_lot = NormalizeDouble((equity / lot_balance) * lot, 2);
    }
    break;

    case LOT_RISK:
    {
        if (Stoploss <= 0)
            return 0.01;

        double balance = AccountInfoDouble(ACCOUNT_BALANCE);
        double risk_amount = balance * (risk_percent / 100);
        double tick_value = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
        double total_loss = Stoploss * tick_value;
        calculated_lot = NormalizeDouble(risk_amount / total_loss, 2);
    }
    break;
    }

    // Validasi lot size
    if (max_lot > 0 && calculated_lot > max_lot)
    {
        Print("Warning: Calculated lot ", calculated_lot, " exceeds max lot ", max_lot);
        calculated_lot = max_lot;
    }

    if (calculated_lot < 0.01)
        calculated_lot = 0.01;

    Print("Final Lot Size: ", calculated_lot);
    return calculated_lot;
}

void MainAddFeature()
{
    if (IsNewBar(PERIOD_M5))
    {
        if (iBreakeven_dollar > 0)
        {
            for (int i = 0; i < totalSymbols; i++)
            {
                string symbol = symbolArray[i].symbol;
                SetBreakEven(symbol, iBreakeven_dollar, iBreakeven_point);
            }
        }
    }
}

void incHandleManual()
{
    Print("Manual Handle");
    string p = signal_manual_period;
    string t = signal_manual_timeframe;
    string sep = ",";
    ushort u_sep = StringGetCharacter(sep, 0);

    // Konvert data ke array
    string periode[];
    string tf[];
    // ArrayResize(periode, totalHandles);
    // ArrayResize(tf, totalHandles);
    StringSplit(p, u_sep, periode);
    StringSplit(t, u_sep, tf);

    // Periksa jumlah input
    int periodCount = ArraySize(periode);
    int tfCount = ArraySize(tf);

    // Jika jumlah input tidak sama dengan totalHandles
    if (periodCount != totalHandles || tfCount != totalHandles)
    {
        if (debug == ON)
            Print("Input tidak sesuai. Menyesuaikan array...");
        // Mengisi array dengan pola yang diinginkan
        FillArrayWithLastValue(periode, periode, totalHandles);
        FillArrayWithLastValue(tf, tf, totalHandles);
    }

    for (int i = 0; i < totalHandles; i++)
    {
        Print(" Timeframe: ", tf[i], " Period: ", periode[i]);
    }
    for (int i = 0; i < totalSymbols; i++)
    {

        for (int j = 0; j < totalHandles; j++)
        {
            symbolArray[i].timeframe[j] = StringToTimeframe(tf[j]);
            Print("Symbol: ", symbolArray[i].symbol, " Timeframe: ", tf[j]);

            switch (signal_manual)
            {
            case ENUM_INDICATOR_TYPE::IND_MOVING_AVERAGE:
                symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                               StringToTimeframe(tf[j]),
                                               (int)periode[j],
                                               0,
                                               ENUM_MA_METHOD::MODE_SMA,
                                               ENUM_APPLIED_PRICE::PRICE_CLOSE);
                break;
            case ENUM_INDICATOR_TYPE::IND_BOLLINGER_BANDS:
                symbolArray[i].handle[j] = iBands(symbolArray[i].symbol,
                                                  StringToTimeframe(tf[j]),
                                                  (int)periode[j],
                                                  0,
                                                  2.0,
                                                  ENUM_APPLIED_PRICE::PRICE_CLOSE);
                break;
            case ENUM_INDICATOR_TYPE::IND_RSI:
                symbolArray[i].handle[j] = iRSI(symbolArray[i].symbol,
                                                StringToTimeframe(tf[j]),
                                                (int)periode[j],
                                                ENUM_APPLIED_PRICE::PRICE_CLOSE);
                break;
            }
        }
    }
}

void IncHandleMa(int i, int j)
{
    switch (j)
    {
    case 0: // MA1
        symbolArray[i].isBuy[j] = (ma1_buy == ACTIVE);
        symbolArray[i].isSell[j] = (ma1_sell == ACTIVE);
        if (ma1_active == ON)
        {
            symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                           ma1_timeframe,
                                           ma1_periode,
                                           ma1_shift,
                                           ma1_method,
                                           ma1_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = ma1_timeframe;
                symbolArray[i].signal_type[j] = ma1_type;
                if (debug == ON)
                    Print("handle MA 1: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 1: // MA2
        symbolArray[i].isBuy[j] = (ma2_buy == ACTIVE);
        symbolArray[i].isSell[j] = (ma2_sell == ACTIVE);
        if (ma2_active == ON)
        {
            symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                           ma2_timeframe,
                                           ma2_periode,
                                           ma2_shift,
                                           ma2_method,
                                           ma2_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = ma2_timeframe;
                symbolArray[i].signal_type[j] = ma2_type;
                if (debug == ON)
                    Print("handle MA 2: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 2: // MA3
        symbolArray[i].isBuy[j] = (ma3_buy == ACTIVE);
        symbolArray[i].isSell[j] = (ma3_sell == ACTIVE);
        if (ma3_active == ON)
        {
            symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                           ma3_timeframe,
                                           ma3_periode,
                                           ma3_shift,
                                           ma3_method,
                                           ma3_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = ma3_timeframe;
                symbolArray[i].signal_type[j] = ma3_type;
                if (debug == ON)
                    Print("handle MA 3: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 3: // MA4
        symbolArray[i].isBuy[j] = (ma4_buy == ACTIVE);
        symbolArray[i].isSell[j] = (ma4_sell == ACTIVE);
        if (ma4_active == ON)
        {
            symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                           ma4_timeframe,
                                           ma4_periode,
                                           ma4_shift,
                                           ma4_method,
                                           ma4_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = ma4_timeframe;
                symbolArray[i].signal_type[j] = ma4_type;
                if (debug == ON)
                    Print("handle MA 4: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 4: // MA5
        symbolArray[i].isBuy[j] = (ma5_buy == ACTIVE);
        symbolArray[i].isSell[j] = (ma5_sell == ACTIVE);
        if (ma5_active == ON)
        {
            symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                           ma5_timeframe,
                                           ma5_periode,
                                           ma5_shift,
                                           ma5_method,
                                           ma5_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = ma5_timeframe;
                symbolArray[i].signal_type[j] = ma5_type;
                if (debug == ON)
                    Print("handle MA 5: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 5: // MA6
        symbolArray[i].isBuy[j] = (ma6_buy == ACTIVE);
        symbolArray[i].isSell[j] = (ma6_sell == ACTIVE);
        if (ma6_active == ON)
        {
            symbolArray[i].handle[j] = iMA(symbolArray[i].symbol,
                                           ma6_timeframe,
                                           ma6_periode,
                                           ma6_shift,
                                           ma6_method,
                                           ma6_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = ma6_timeframe;
                symbolArray[i].signal_type[j] = ma6_type;
                if (debug == ON)
                    Print("handle MA 6: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;
    }
}
void IncHandleBB(int i, int j)
{
    int bbIndex = j - 6; // Konversi j ke index BB (0-4)

    switch (bbIndex)
    {
    case 0: // BB1
        symbolArray[i].isBuy[j] = (bb1_buy == ACTIVE);
        symbolArray[i].isSell[j] = (bb1_sell == ACTIVE);
        if (bb1_active == ON)
        {
            symbolArray[i].handle[j] = iBands(symbolArray[i].symbol,
                                              bb1_timeframe,
                                              bb1_periode,
                                              bb1_shift,
                                              bb1_deviation,
                                              bb1_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = bb1_timeframe;
                symbolArray[i].signal_type[j] = bb1_type;
                if (debug == ON)
                    Print("handle BB 1: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 1: // BB2
        symbolArray[i].isBuy[j] = (bb2_buy == ACTIVE);
        symbolArray[i].isSell[j] = (bb2_sell == ACTIVE);
        if (bb2_active == ON)
        {
            symbolArray[i].handle[j] = iBands(symbolArray[i].symbol,
                                              bb2_timeframe,
                                              bb2_periode,
                                              bb2_shift,
                                              bb2_deviation,
                                              bb2_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = bb2_timeframe;
                symbolArray[i].signal_type[j] = bb2_type;
                if (debug == ON)
                    Print("handle BB 2: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 2: // BB3
        symbolArray[i].isBuy[j] = (bb3_buy == ACTIVE);
        symbolArray[i].isSell[j] = (bb3_sell == ACTIVE);
        if (bb3_active == ON)
        {
            symbolArray[i].handle[j] = iBands(symbolArray[i].symbol,
                                              bb3_timeframe,
                                              bb3_periode,
                                              bb3_shift,
                                              bb3_deviation,
                                              bb3_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = bb3_timeframe;
                symbolArray[i].signal_type[j] = bb3_type;
                if (debug == ON)
                    Print("handle BB 3: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 3: // BB4
        symbolArray[i].isBuy[j] = (bb4_buy == ACTIVE);
        symbolArray[i].isSell[j] = (bb4_sell == ACTIVE);
        if (bb4_active == ON)
        {
            symbolArray[i].handle[j] = iBands(symbolArray[i].symbol,
                                              bb4_timeframe,
                                              bb4_periode,
                                              bb4_shift,
                                              bb4_deviation,
                                              bb4_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = bb4_timeframe;
                symbolArray[i].signal_type[j] = bb4_type;
                if (debug == ON)
                    Print("handle BB 4: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;

    case 4: // BB5
        symbolArray[i].isBuy[j] = (bb5_buy == ACTIVE);
        symbolArray[i].isSell[j] = (bb5_sell == ACTIVE);
        if (bb5_active == ON)
        {
            symbolArray[i].handle[j] = iBands(symbolArray[i].symbol,
                                              bb5_timeframe,
                                              bb5_periode,
                                              bb5_shift,
                                              bb5_deviation,
                                              bb5_price);
            if (symbolArray[i].handle[j] != INVALID_HANDLE)
            {
                symbolArray[i].isActive[j] = true;
                symbolArray[i].timeframe[j] = bb5_timeframe;
                symbolArray[i].signal_type[j] = bb5_type;
                if (debug == ON)
                    Print("handle BB 5: " + symbolArray[i].symbol + " berhasil dibuat");
            }
        }
        break;
    }
}

void IncGetSetSignalManual()
{
    const int dataPoints = 3;                    // current and previous bars
    int totalSize = totalSymbols * totalHandles; // Hitung total size yang dibutuhkan

    switch (signal_manual)
    {
    case ENUM_INDICATOR_TYPE::IND_MOVING_AVERAGE:
    case ENUM_INDICATOR_TYPE::IND_RSI:
    {
        // Deklarasi array
        double tempBufferIndicator[];
        double tempBufferClose[];

        // Resize arrays
        ArrayResize(tempBufferIndicator, dataPoints);
        ArrayResize(tempBufferClose, dataPoints);

        // Set temporary buffers sebagai time series
        ArraySetAsSeries(tempBufferIndicator, true);
        ArraySetAsSeries(tempBufferClose, true);

        // Loop untuk setiap simbol dan handle
        for (int s = 0; s < totalSymbols; s++)
        {
            string symbol = symbolArray[s].symbol;
            if ((int)SymbolInfoInteger(symbol, SYMBOL_SPREAD) > max_spread)
            {
                if (debug == ON)
                    Print("Symbol " + symbol + " memiliki spread lebih besar dari maksimal spread yang diizinkan MODE MANUAL");
                continue;
            }
            for (int h = 0; h < totalHandles; h++)
            {
                int arrayIndex = (s * totalHandles) + h;
                if (CopyBuffer(symbolArray[s].handle[h], 0, 0, dataPoints, tempBufferIndicator) > 0)
                {
                    if (CopyClose(symbolArray[s].symbol, symbolArray[s].timeframe[h], 0, dataPoints, tempBufferClose) > 0)
                    {
                        bool upCurr = false;
                        bool upPrev = false;
                        // bool upPrev2 = false;
                        bool downCurr = false;
                        bool downPrev = false;
                        if (signal_manual == IND_MOVING_AVERAGE) // MA
                        {
                            upCurr = tempBufferClose[0] > tempBufferIndicator[0];
                            upPrev = tempBufferClose[1] > tempBufferIndicator[1];
                            // upPrev2 = tempBufferClose[2] > tempBufferIndicator[2];
                        }
                        else // RSI
                        {
                            upCurr = tempBufferIndicator[0] > 70;
                            upPrev = tempBufferIndicator[1] > 70;
                            downCurr = tempBufferIndicator[0] > 30;
                            downPrev = tempBufferIndicator[1] > 30;
                        }

                        // Proses sinyal berdasarkan tipe
                        switch (signal_manual_type)
                        {
                        case ENUM_SIGNAL_MANUAL_TYPE::UP_DOWN:
                            if (signal_manual == IND_MOVING_AVERAGE) // MA
                                symbolArray[s].signal[h] = (upCurr) ? 1 : -1;
                            else // RSI
                                symbolArray[s].signal[h] = (upCurr) ? 1 : (!downCurr) ? -1
                                                                                      : 0;
                            break;
                        case ENUM_SIGNAL_MANUAL_TYPE::UP_DOWN_REVERSE:
                            if (signal_manual == IND_MOVING_AVERAGE) // MA
                                symbolArray[s].signal[h] = (upCurr) ? -1 : 1;
                            else // RSI
                                symbolArray[s].signal[h] = (upCurr) ? -1 : (!downCurr) ? 1
                                                                                       : 0;
                            break;
                        case ENUM_SIGNAL_MANUAL_TYPE::CROSS_FOLLOW:  //  down up = buy
                            if (signal_manual == IND_MOVING_AVERAGE) // MA

                                symbolArray[s].signal[h] = (upCurr && !upPrev) ? 1 : (!upCurr && upPrev) ? -1
                                                                                                         : 0;
                            else // RSI
                                symbolArray[s].signal[h] = (upCurr && !upPrev) ? 1 : (!downCurr && downPrev) ? -1
                                                                                                             : 0;
                            break;
                        case ENUM_SIGNAL_MANUAL_TYPE::CROSS_FOLLOW_REVERSE: //  up down = buy
                            if (signal_manual == IND_MOVING_AVERAGE)        // MA
                                symbolArray[s]
                                    .signal[h] = (!upCurr && upPrev) ? 1 : (upCurr && !upPrev) ? -1
                                                                                               : 0;
                            else // RSI
                                symbolArray[s]
                                    .signal[h] = (downCurr && !downPrev) ? 1 : (!upCurr && upPrev) ? -1
                                                                                                   : 0;
                            break;
                        }
                    }
                }
            }
        }
        break;
    }
    case ENUM_INDICATOR_TYPE::IND_BOLLINGER_BANDS:
    {
        double tempUpper[], tempLower[];
        double tempBufferClose[];

        ArrayResize(tempUpper, dataPoints);
        ArrayResize(tempLower, dataPoints);
        ArrayResize(tempBufferClose, dataPoints);

        ArraySetAsSeries(tempUpper, true);
        ArraySetAsSeries(tempLower, true);
        ArraySetAsSeries(tempBufferClose, true);

        for (int s = 0; s < totalSymbols; s++)
        {
            string symbol = symbolArray[s].symbol;
            bool isSpread = (int)SymbolInfoInteger(symbol, SYMBOL_SPREAD) > max_spread;
            if (isSpread)
            {
                if (debug == ON)
                    Print("Symbol " + symbol + " memiliki spread lebih besar dari maksimal spread yang diizinkan MODE MANUAL");
                continue;
            }
            for (int h = 0; h < totalHandles; h++)
            {
                int arrayIndex = (s * totalHandles) + h;
                if (
                    CopyBuffer(symbolArray[s].handle[h], 1, 0, dataPoints, tempUpper) > 0 &&
                    CopyBuffer(symbolArray[s].handle[h], 2, 0, dataPoints, tempLower) > 0)
                {
                    if (CopyClose(symbolArray[s].symbol, symbolArray[s].timeframe[h], 0, dataPoints, tempBufferClose) > 0)
                    {
                        bool prevCloseAboveUpper = tempBufferClose[1] > tempUpper[1];
                        bool currCloseAboveUpper = tempBufferClose[0] > tempUpper[0];
                        bool prevCloseAboveLower = tempBufferClose[1] > tempLower[1];
                        bool currCloseAboveLower = tempBufferClose[0] > tempLower[0];

                        switch (signal_manual_type)
                        {
                        case ENUM_SIGNAL_MANUAL_TYPE::UP_DOWN:
                            symbolArray[s].signal[h] = (currCloseAboveUpper)    ? 1
                                                       : (!currCloseAboveLower) ? -1
                                                                                : 0;
                            break;
                        case ENUM_SIGNAL_MANUAL_TYPE::UP_DOWN_REVERSE:
                            symbolArray[s].signal[h] = (currCloseAboveUpper)    ? -1
                                                       : (!currCloseAboveLower) ? 1
                                                                                : 0;
                            break;
                        case ENUM_SIGNAL_MANUAL_TYPE::CROSS_FOLLOW:
                        {

                            symbolArray[s].signal[h] = (currCloseAboveUpper && !prevCloseAboveUpper)   ? 1
                                                       : (!currCloseAboveLower && prevCloseAboveLower) ? -1
                                                                                                       : 0;
                            break;
                        }
                        case ENUM_SIGNAL_MANUAL_TYPE::CROSS_FOLLOW_REVERSE:
                        {
                            symbolArray[s].signal[h] = (currCloseAboveUpper && !prevCloseAboveUpper)   ? -1
                                                       : (!currCloseAboveLower && prevCloseAboveLower) ? 1
                                                                                                       : 0;
                            break;
                        }
                        }
                    }
                }
            }
        }
    }
    break;
    }
}