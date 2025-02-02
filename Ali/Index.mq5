#property copyright "Copyright 2024, Ali Usman"
#property version "1.00"
#property strict
#include "Input.mqh"
#include "Class/SymbolManager.mqh"
bool InitSymbol()
{
    // g_symbolManager.Setinitialize();
    g_symbolManager.setTypeSymbol(i_symbolType);
    g_symbolManager.setTradingDirection(i_symbolDirection);
    g_symbolManager.SetCustomSymbols(i_symbolCustom);
    g_symbolManager.setBaseSymbols(i_symbolBase);
    g_symbolManager.setBaseDirection(i_symbolBaseDirection);
    if (!g_symbolManager.Initialize())
        return (false);
    return (true);
}
CSymbolManager g_symbolManager;
int OnInit()
{
    if (!InitSymbol())
        return (INIT_FAILED);

    EventSetTimer(1);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{

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
    // get symbol
    for (int i = 0; i < g_symbolManager.GetTotalSymbols(); i++)
    {
        string symbol = g_symbolManager.GetSymbol(i);
        Print(symbol);
    }
    Print("Total Symbol: ", g_symbolManager.GetTotalSymbols());
    Print("Type Symbol: ", g_symbolManager.GetTypeSymbol());
    Print("Trading Direction: ", g_symbolManager.GetTradingDirection());
    Print("Custom Symbols: ", g_symbolManager.GetCustomSymbols());
    Print("Base Symbol: ", g_symbolManager.GetBaseSymbol());
    Print("Base Direction: ", g_symbolManager.GetBaseDirection());
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
