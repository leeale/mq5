#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict
#include "EaHelper.mqh"
#include "EaInput1.mqh"

// variable global
string g_Symbol;
int g_HandleMA1[2];
int g_signalMA1;

//

int OnInit()
{
    g_Symbol = Symbol();
    g_signalMA1 = 0;

    int handlema1total = ArraySize(g_HandleMA1);
    for (int i = 0; i < handlema1total; i++)
        g_HandleMA1[i] = INVALID_HANDLE;

    EventSetTimer(5);

    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    int handlema1total = ArraySize(g_HandleMA1);
    for (int i = 0; i < handlema1total; i++)
        ReleaseHandleMA(i);
    EventKillTimer();
}

void OnTick()
{
}

void OnTimer()
{
    if (IsIndikatorMa1(g_signalMA1))
    {
        if (g_signalMA1 == 1)
        {
            Print("Buy Signal");
        }
        else
        {
            Print("sell Signal");
        }
    }
}

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
}
bool IsFilterIndikator(ENUM_ON_OFF active, ENUM_ACTIVE_DISABLE buy, ENUM_ACTIVE_DISABLE sell)
{
    if (active != ON)
        return false;
    if (buy != ACTIVE && sell != ACTIVE)
        return false;
    return true;
}

// jika variable parameter true maka signal buy, jika false maka signal sell
bool IsIndikatorMa1(int &signal)
{
    bool filter1 = IsFilterIndikator(ma1_active, ma1_buy, ma1_sell);
    if (!filter1)
        return false;

    double currentPrice = 0;
    double CandlePrevieous = 0;
    currentPrice = iClose(g_Symbol, ma1_timeframe, 0);
    CandlePrevieous = iClose(g_Symbol, ma1_timeframe, 1);
    bool isHandleMA1 = false;
    bool isHandleMA2 = false;
    double PriceMa1[];
    ArraySetAsSeries(PriceMa1, true);
    double PriceMa2[];
    ArraySetAsSeries(PriceMa2, true);
    double price1 = 0;
    double price2 = 0;

    // jika sinyal adalah 0, periksa apakah indikator MA1 aktif
    if (ma1_signal_indikator1 == 0)
    {
        isHandleMA1 = IsHandle_MA(g_Symbol, ma1_timeframe, ma1_periode1, ma1_shift1, ma1_method1, ma1_price1, g_HandleMA1[0]);
        if (!isHandleMA1)
            return false;

        if (CopyBuffer(g_HandleMA1[0], 0, 0, 2, PriceMa1) != 2 || PriceMa1[0] == EMPTY_VALUE)
        {
            Print("Getdata ma");
            Print(PriceMa1[0]);
            return false;
        }
        price1 = (ma1_signal_indikator1 == 0) ? PriceMa1[0] : currentPrice;
    }
    if (ma2_signal_indikator2 == 0)
    {

        isHandleMA2 = IsHandle_MA(g_Symbol, ma1_timeframe, ma1_periode1, ma1_shift1, ma1_method1, ma1_price1, g_HandleMA1[1]);
        if (!isHandleMA2)
            return false;
        bool GetDataMa2 = CopyBuffer(g_HandleMA1[1], 0, 0, 2, PriceMa2);
        if (GetDataMa2 != 2 || PriceMa2[0] == EMPTY_VALUE)
            return false;
        price2 = (ma1_signal_indikator2 == 0) ? PriceMa2[0] : 0;
    }

    if (price1 == 0 || price2 == 0)
        return false;

    if (ma1_type == MA_SIGNAL_CROSS)
    {
        // Menggunakan data previous untuk mendeteksi crossing
        double ma1Current = PriceMa1[0];
        double ma1Previous = PriceMa1[1];
        double ma2Current = PriceMa2[0];
        double ma2Previous = PriceMa2[1];
        // Sinyal beli: MA1 melintasi di atas MA2
        if (ma1Previous < ma2Previous && ma1Current > ma2Current)
        {
            if (ma1_buy == ACTIVE)
            {
                signal = 1; // Buy signal
                return true;
            }
        }
        else if (ma1Previous > ma2Previous && ma1Current < ma2Current)
        {
            if (ma1_sell == ACTIVE)
            {
                signal = -1; // Sell signal
                return true;
            }
        }
    }
    else if (ma1_type == MA_SIGNAL_UP_DOWN)
    {
        double ma1value1 = PriceMa1[0];
        double ma1value2 = PriceMa1[1];
        if (ma1value1 > ma1value2)
        {
            if (ma1_buy == ACTIVE)
            {
                signal = 1; // Buy signal
                return true;
            }
        }
        else if (ma1value1 < ma1value2)
        {
            if (ma1_sell == ACTIVE)
            {
                signal = -1; // Sell signal
                return true;
            }
        }
    }
    signal = 0;
    return false;
}
