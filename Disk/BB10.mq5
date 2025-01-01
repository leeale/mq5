
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

int g_TotalSymbols = SymbolsTotal(true);
string g_SymbolName[];
int g_HandleBB[];

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{

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
        PrintFormat("Band created for %s", g_SymbolName[i]);
        PrintFormat("Band handle: %d", g_HandleBB[i]);
    }

    EventSetTimer(20);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    for (int i = 0; i < g_TotalSymbols; i++)
    {
        if (g_HandleBB[i] != INVALID_HANDLE)
            IndicatorRelease(g_HandleBB[i]);
    }

    EventKillTimer();
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
    for (int i = 0; i < g_TotalSymbols; i++)
    {
        double UpperBand[], LowerBand[];
        ArraySetAsSeries(UpperBand, true);
        ArraySetAsSeries(LowerBand, true);
        ArrayResize(UpperBand, 1);
        ArrayResize(LowerBand, 1);

        if (CopyBuffer(g_HandleBB[i], UPPER_BAND, 0, 1, UpperBand) == 1 &&
            CopyBuffer(g_HandleBB[i], LOWER_BAND, 0, 1, LowerBand) == 1)
        {
            PrintFormat("%s: UpperBand: %f, LowerBand: %f",
                        g_SymbolName[i], UpperBand[0], LowerBand[0]);
        }
        else
        {
            PrintFormat("Error copying data for %s", g_SymbolName[i], GetLastError());
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