
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
    //  int signal_type_BB[];
};
symbolInfo symbolArray[];
// variable Global
int totalHandles;
int totalSymbols;
bool active;

int OnInit()
{
    active = (power == ON);
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
void OnTimer()
{
    if (!active)
        return;
    for (int n = 0; n < totalSymbols; n++)
    {
        string symbol = symbolArray[n].symbol;
        // CalcHandle(n);
        CalcSignal(n);
        // Print(Debug);
        if (debug == 0)
        {
            /* code */

            // debug
            for (int j = 0; j < totalHandles; j++)
            {
                if (symbolArray[n].handle[j] != INVALID_HANDLE)
                {
                    if (symbolArray[n].signal[j] != 0)
                        Print("Symbol: ", symbol, " Handle: ", symbolArray[n].handle[j], " Signal: ", symbolArray[n].signal[j]);
                }
            }
        }
    }
    UpdateFinalSignal();
    // GetDataSymbol();
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

    EventKillTimer();
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
        if (symbolArray[i].signal_type[j] == 0)
        {
            if (p0 > i0 && p1 < i1)
                symbolArray[i].signal[j] = 1;
        }
        else if (symbolArray[i].signal_type[j] == 1)
        {
            if (p0 > i0)
                symbolArray[i].signal[j] = 1;
        }
    }

    // Cek Sell - hanya jika tidak ada buy signal
    if (symbolArray[i].isSell[j] && symbolArray[i].signal[j] == 0)
    {
        if (symbolArray[i].signal_type[j] == 0)
        {
            if (p0 < i0 && p1 > i1)
                symbolArray[i].signal[j] = -1;
        }
        else if (symbolArray[i].signal_type[j] == 1)
        {
            if (p0 < i0)
                symbolArray[i].signal[j] = -1;
        }
    }
}
void UpdateSignalBB(int i, int j, double &value1[], double &value2[])
{
    double upper0 = value1[0];
    double upper1 = value1[1];
    double lower0 = value2[0];
    double lower1 = value2[1];

    // Print("upper0: ", upper0);
    // Print("upper1: ", upper1);
    // Print("lower0: ", lower0);
    // Print("lower1: ", lower1);

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
                Print("Final Signal Update: ", symbolArray[i].symbol, " = 1 (BUY)");
            }
            else if (allSignalsSell && hasActiveSell)
            {
                symbolArray[i].finalsignal = -1;
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
            Print("Final Signal Update: ", symbolArray[i].symbol, " = 0 (No active handles)");
        }
    }
}
