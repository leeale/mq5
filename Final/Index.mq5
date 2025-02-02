
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict
#include "SymbolManager.mqh"
SymbolManager symbolManager(Symbol_Type::TYPE_FOREX, Symbol_Base::BASE_EURUSD, "EURUSD");

#include "Input.mqh"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    EventSetTimer(60);

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
int temp = 0;
void OnTick()
{
    // Ambil histori 3 bulan terakhir
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
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