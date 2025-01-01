
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

#include <Trade/Trade.mqh>

input double Lots = 0.01;
input bool Debug = true;
int Timer = 5;

int g_BBHandle = 0;
string g_Symbol = _Symbol;
double g_HargaClose = 0;
double upperBand[], middleBand[], lowerBand[];
int g_Digits = 5;
string g_Signal;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    // definisikan g_BBHandle
    g_Symbol = _Symbol;

    g_BBHandle = iBands(g_Symbol, 0, 20, 0, 2, PRICE_CLOSE);
    if (g_BBHandle == INVALID_HANDLE)
    {
        Print("Failed to create iBands indicator");
        return (INIT_FAILED);
    }
    EventSetTimer(Timer);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    EventKillTimer();
    if (g_BBHandle != INVALID_HANDLE)
        IndicatorRelease(g_BBHandle);
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{

    g_Symbol = _Symbol;
    g_Signal = "Hold";
    double normalizedUpper = 0.0, normalizedMiddle = 0.0, normalizedLower = 0.0;
    double normalizedUpper2 = 0.0, normalizedMiddle2 = 0.0, normalizedLower2 = 0.0;
    double hargaClose2 = 0.0;
    long stopLevel = SymbolInfoInteger(g_Symbol, SYMBOL_TRADE_STOPS_LEVEL);
    double point = SymbolInfoDouble(g_Symbol, SYMBOL_POINT);
    double minStopLoss = stopLevel * point;
    double spread = SymbolInfoInteger(g_Symbol, SYMBOL_SPREAD) * point;

    // Set ukuran array sesuai kebutuhan
    ArraySetAsSeries(upperBand, true);
    ArraySetAsSeries(middleBand, true);
    ArraySetAsSeries(lowerBand, true);

    // Copy 2 candle terakhir
    if (CopyBuffer(g_BBHandle, 1, 0, 2, upperBand) <= 0 ||
        CopyBuffer(g_BBHandle, 0, 0, 2, middleBand) <= 0 ||
        CopyBuffer(g_BBHandle, 2, 0, 2, lowerBand) <= 0)
    {
        Print("Error copying buffer data: ", GetLastError());
        return;
    }

    // Pastikan data valid
    if (ArraySize(upperBand) < 2 || ArraySize(middleBand) < 2 || ArraySize(lowerBand) < 2)
    {
        Print("Not enough data");
        return;
    }

    g_Digits = (int)SymbolInfoInteger(g_Symbol, SYMBOL_DIGITS);

    // dapatkan harga close
    g_HargaClose = NormalizeDouble(SymbolInfoDouble(g_Symbol, SYMBOL_BID), g_Digits);
    hargaClose2 = NormalizeDouble(iClose(g_Symbol, 0, 1), g_Digits);

    // Normalisasi nilai
    if (
        upperBand[0] != 0 &&
        middleBand[0] != 0 &&
        lowerBand[0] != 0)
    {
        normalizedUpper = NormalizeDouble(upperBand[0], g_Digits);
        normalizedMiddle = NormalizeDouble(middleBand[0], g_Digits);
        normalizedLower = NormalizeDouble(lowerBand[0], g_Digits);

        normalizedUpper2 = NormalizeDouble(upperBand[1], g_Digits);
        normalizedMiddle2 = NormalizeDouble(middleBand[1], g_Digits);
        normalizedLower2 = NormalizeDouble(lowerBand[1], g_Digits);

        if (
            g_HargaClose > normalizedUpper &&
            hargaClose2 > normalizedUpper2)
        {
            g_Signal = "Sell"; // Jual
        }
        else if (
            g_HargaClose < normalizedLower &&
            hargaClose2 < normalizedLower2)
        {
            g_Signal = "Buy"; // Beli
        }

        // Format print yang lebih rapi
        if (Debug)
        {
            string message = StringFormat(
                "BB Values\n" +
                    "Upper Band: %G\n" +
                    "Middle Band: %G\n" +
                    "Lower Band: %G",
                normalizedUpper,
                normalizedMiddle,
                normalizedLower);
            Print(message);
            Print("Close Price: ", g_HargaClose);
            Print("Symbol: ", g_Symbol);
            Print("Digits: ", g_Digits);
            Print("Harga Close2: ", hargaClose2);
            Print("Upper Band2: ", normalizedUpper2);
            Print("Lower Band2: ", normalizedLower2);

            if (g_Signal != "Hold")
                Print("Signal: ", g_Signal);
        }
    }
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
}
//+------------------------------------------------------------------+