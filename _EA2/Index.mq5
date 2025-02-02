//+------------------------------------------------------------------+
//| file_name.mq4.mq4
//| Copyright 2017, Author Name
//| Link
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict
#include "Variable_Global.mqh"
#include "Symbol.mqh";
#include "Input.mqh";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    SetSymbolType();
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
    for (int i = 0; i < m_totalSymbols; i++)
    {
        string symbol = m_symbols[i];
        double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
        double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
        int spread = (int)SymbolInfoInteger(symbol, SYMBOL_SPREAD);
        double point_digits = SymbolInfoDouble(symbol, SYMBOL_POINT);
        Print("symbol: ", symbol);
        Print("ask: ", ask);
        Print("bid: ", bid);
        Print("point: ", point);
        Print("spread: ", spread);
        Print("point_digits: ", point_digits);
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
