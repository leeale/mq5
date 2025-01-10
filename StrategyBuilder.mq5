
#property copyright "Copyright 2024, Ali Usman"
#property version "1.00"
#property strict
#include "StrategyBuilder/Input.mqh"

struct symbolInfo
{
    string symbol;
    int finalsignal;
    int handle[];
    int signal[];
    bool isActive[];
    bool isBuy[];
    bool isSell[];
    ENUM_TIMEFRAMES timeframe[];
    int signal_type[];
};
symbolInfo symbolArray[];
// variable Global
int totalHandles;
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

int OnInit()
{
    CreateCloseButton();
    CreateCloseButtonSymbol();
    if (m_targetProfit > 0)
    {
        m_savedBalance = 0;
        m_isBalanceLoaded = false;
        LoadBalance();
        ShowTargetOnChart();
    }

    CalcSymbol();
    totalHandles = 11;

    for (int i = 0; i < totalSymbols; i++)
    {
        ArrayResize(symbolArray[i].handle, totalHandles);
        ArrayResize(symbolArray[i].signal, totalHandles);
        ArrayResize(symbolArray[i].isActive, totalHandles);
        ArrayResize(symbolArray[i].isBuy, totalHandles);
        ArrayResize(symbolArray[i].isSell, totalHandles);
        ArrayResize(symbolArray[i].timeframe, totalHandles);
        ArrayResize(symbolArray[i].signal_type, totalHandles);

        // Inisialisasi nilai default
        for (int j = 0; j < totalHandles; j++)
        {
            //  symbolArray[i].handle[j] = INVALID_HANDLE;
            symbolArray[i].signal[j] = 0;
            symbolArray[i].isActive[j] = false;
            symbolArray[i].isBuy[j] = false;
            symbolArray[i].isSell[j] = false;
        }
        CalcHandle(i);
    }

    EventSetTimer(5);

    return (INIT_SUCCEEDED);
}
void OnTick()
{
    TargetOnChart();
}
void OnTimer()
{

    for (int n = 0; n < totalSymbols; n++)
    {
        string symbol = symbolArray[n].symbol;
        string message = "";
        int filter_result = FilterCondition(symbol, message);
        if (filter_result != FILTER_PASS)
        {
            if (debug == ON)
                Print(message);
            continue;
        }
        CalcSignal(n);
    }
    UpdateFinalSignal();
    // GetDataSymbol();
    OpenPosition();
    HiddenTP_SL();
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
    DeleteButtonAndLabels();
    EventKillTimer();
}

enum ENUM_FILTER_RESULT
{
    FILTER_PASS,        // Lolos filter
    FILTER_POWER_OFF,   // Power off
    FILTER_HIGH_SPREAD, // Spread terlalu tinggi
    FILTER_WRONG_TIME,  // Diluar jam trading
    FILTER_HOLIDAY      // Hari libur
};

ENUM_FILTER_RESULT FilterCondition(string symbol, string &message)
{

    if (power == OFF)
    {
        message = StringFormat("Filter: %s power off", symbol);
        return FILTER_POWER_OFF;
    }

    // Filter jam trading
    datetime time = TimeCurrent();
    MqlDateTime dt;
    TimeToStruct(time, dt);
    // Cek jam trading
    if ((dt.hour < jam_start || dt.hour >= jam_end) && (jam_start != 0 && jam_end != 0))
    {
        message = StringFormat("Filter: %s diluar jam trading (%d:%d)",
                               symbol, dt.hour, dt.min);
        return FILTER_WRONG_TIME;
    }

    // Cek hari yang tidak boleh trading
    if (no_day_trading1 != Disable || no_day_trading2 != Disable)
    {
        if (dt.day_of_week == no_day_trading1 || dt.day_of_week == no_day_trading2)
        {
            message = StringFormat("Filter: %s tidak trading di hari %s",
                                   symbol,
                                   EnumToString((ENUM_DAY_INDO)dt.day_of_week));
            return FILTER_WRONG_TIME;
        }
    }

    // Filter spread
    int spread = (int)SymbolInfoInteger(symbol, SYMBOL_SPREAD);
    if (spread > max_spread)
    {
        message = StringFormat("Filter: %s spread terlalu tinggi (%d)", symbol, spread);
        if (max_spread != 0)
            return FILTER_HIGH_SPREAD;
    }

    message = StringFormat("Filter: %s passed all conditions", symbol);
    return FILTER_PASS;
}

void CalcSymbol()
{
    string symboldata[];
    if (multi_symbol == ENUM_SYMBOL_TYPE::MULTI_SYMBOL)
        totalSymbols = SymbolsTotal(true);
    else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM)
    {

        if (multi_symbol_custom == "")
        {
            string symbols = "EURUSD,GBPUSD,USDJPY";
            StringSplit(symbols, ',', symboldata);
            totalSymbols = ArraySize(symboldata);
        }
        else
        {
            StringSplit(multi_symbol_custom, ',', symboldata);
            totalSymbols = ArraySize(symboldata);
        }
    }
    else
        totalSymbols = 1;

    ArrayResize(symbolArray, totalSymbols);
    for (int i = 0; i < totalSymbols; i++)
    {
        if (multi_symbol == ENUM_SYMBOL_TYPE::MULTI_SYMBOL)
            symbolArray[i].symbol = SymbolName(i, true);
        else if (multi_symbol == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM)
            symbolArray[i].symbol = symboldata[i];
        else
            symbolArray[i].symbol = _Symbol;
    }
}
void CalcHandle(int i)
{
    for (int j = 0; j < totalHandles; j++)
    {
        //  Print("symbol: ", symbolArray[i].symbol, " handle: ", symbolArray[i].handle[j], " Active MA1: ", ma1_active, " Active MA2: ", ma2_active);
        // if (symbolArray[i].handle[j] == INVALID_HANDLE)
        // {
        if (j <= 5)
            IndikatorMa(i, j);
        else
            IndikatorBB(i, j);
        //}
    }
}

void IndikatorMa(int i, int j)
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
void IndikatorBB(int i, int j)
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
void CalcSignal(int i)
{
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
                if (BufferMA(symbolArray[i].handle[j], 2, value1))
                {
                    UpdateSignalMA(i, j, value1);
                }
            }
            // Untuk BB (index 6-10)
            else if (j >= 6 && j <= 10)
            {
                if (BufferBB(symbolArray[i].handle[j], 2, value1, value2))
                {
                    UpdateSignalBB(i, j, value1, value2);
                }
            }
        }
    }
}
bool BufferBB(int handle, int t, double &value1[], double &value2[])
{
    int upper = CopyBuffer(handle, 1, 0, t, value1);
    int lower = CopyBuffer(handle, 2, 0, t, value2);
    if (upper == t && lower == t)
        return true;
    return false;
}
bool BufferMA(int handle, int t, double &value1[])
{
    int count = CopyBuffer(handle, 0, 0, t, value1);
    if (count == t)
        return true;
    return false;
}

void UpdateSignalMA(int i, int j, double &value1[])
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
void UpdateSignalBB(int i, int j, double &value1[], double &value2[])
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

void UpdateFinalSignal()
{
    bool signalcombination = (combi_signal == AND);
    for (int i = 0; i < totalSymbols; i++)
    {
        symbolArray[i].finalsignal = 0;
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
                        allSignalsBuy = false;
                        if (symbolArray[i].signal[j] == 1)
                        {
                            allSignalsBuy = true;
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
                        allSignalsSell = false;
                        if (symbolArray[i].signal[j] == -1)
                        {
                            allSignalsSell = true;
                        }
                    }
                }
            }
        }

        // Update final signal jika ada minimal 1 handle aktif
        if (hasActiveHandle)
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
            else
            {
                symbolArray[i].finalsignal = 0;
            }
        }
        else
        {
            symbolArray[i].finalsignal = 0;
            if (debug == ON)
                Print("Final Signal Update: ", symbolArray[i].symbol, " = 0 (No active handles)");
        }
    }
}
void GetDataSymbol()
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
                "timeframe: ", symbolArray[i].timeframe[j],
                "signal_type: ", symbolArray[i].signal_type[j]);
        }
        Print("================================================");
        Print("finall signal: ", symbolArray[i].finalsignal);
        Print("================================================");
    }
}

void OpenPosition()
{
    CTrade trade;
    CPositionInfo pos;
    trade.SetExpertMagicNumber(magic_number);

    for (int i = 0; i < totalSymbols; i++)
    {
        if (symbolArray[i].finalsignal == 0)
            continue;

        if (!FilterOrder(i))
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

        bool order;
        double orderlot = lot;
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
        else
            orderlot = lot;

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

bool FilterOrder(int n)
{
    CPositionInfo pos;
    string symbol = symbolArray[n].symbol;
    int total_positions = PositionsTotal();

    if (total_positions == 0) // Kondisi 1: belum ada order sama sekali
        return true;

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
        for (int i = 0; i < total_positions; i++)
        {
            if (pos.SelectByIndex(i) && pos.Symbol() == symbol && pos.Magic() == magic_number && pos.Time() >= bar_time)
                return false;
        }
        break;
    }

    case ORDER_MAX_CUSTOM:
    {
        if (max_order > 0 || max_order_total > 0)
        {
            int symbol_positions = 0;
            int total_positions = 0;
            for (int i = 0; i < total_positions; i++)
            {
                if (pos.SelectByIndex(i) && pos.Symbol() == symbol)
                    symbol_positions++;
                total_positions++;
            }
            if (max_order > 0 && symbol_positions >= max_order)
            {
                return false;
            }
            if (max_order_total > 0 && total_positions >= max_order_total)
            {
                return false;
            }
        }
        break;
    }
    case ORDER_MODE_GRID_LOSS:
    case ORDER_MODE_GRID_PROFIT:
    {
        double current_price = SymbolInfoDouble(symbol, SYMBOL_ASK);
        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
        double min_distance = grid_min * point;
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
            if (pos.Symbol() != symbol)
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
            if (symbolArray[n].finalsignal != 1)
                return false;
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
            if (symbolArray[n].finalsignal != -1)
                return false;
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
        if (t >= max_grid)
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

            if (grid_lot_mode == GRID_LOT_MULTIPLY || grid_lot_mode == GRID_LOT_ADD)
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
                }
            }
            else if (grid_lot_mode == GRID_LOT_FIXED)
            {
                lotGrid = fixed_lot;
            }
        }
    }
    }
    return true;
}

void HiddenTP_SL()
{
    if (InpStopLoss == 0 && InpTakeProfit == 0)
        return;

    CTrade trade;
    trade.SetExpertMagicNumber(magic_number);
    CPositionInfo pos;

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

void TargetOnChart()
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

string Helper;
