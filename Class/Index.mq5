//+------------------------------------------------------------------+
//| file_name.mq4.mq4
//| Copyright 2017, Author Name
//| Link
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict
#include "MarketWatch.mqh"
#include "OrderInfo.mqh"
CMarketWatch marketWatch;
COrderInfo orderInfo;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    marketWatch.Initialize();
    EventSetTimer(60);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    marketWatch.Deinitialize();
    EventKillTimer();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    Print(PositionSelect("AUDUSD"));
    Print(PositionGetTicket(0));

    // if (orderInfo.Select(PositionGetTicket(0)))
    // {
    // 1. Mendapatkan informasi order berdasarkan ticket

    // }

    // orderInfo.UpdateTotals();
    // // GetInfoMarketWatch();
    // int order = orderInfo.TotalOrders();
    // Print("Order: ", order);
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

void GetInfoMarketWatch(string iSymbol = NULL)
{
    if (iSymbol == NULL)
        iSymbol = _Symbol;
    int total = marketWatch.GetTotalSymbols();
    for (int i = 0; i < total; i++)
    {
        string symbol = marketWatch.GetSymbol(i);
        if (symbol != iSymbol)
            continue;
        marketWatch.UpdateMarketData(i);
        GetPrintInfo(iSymbol);
    }
}

void GetPrintInfo(string symbol = NULL)
{
    Print("========================= start ===========================");
    Print("symbol = ", symbol, " bid = ", marketWatch.GetBid(symbol), " ask = ", marketWatch.GetAsk(symbol));
    // tampilkan stop level
    Print("symbol = ", symbol, " stop level = ", marketWatch.GetStopLevel(symbol));
    // tampilkan spread
    Print("symbol = ", symbol, " spread = ", marketWatch.GetSpread(symbol));
    // tampilkan min volume
    Print("symbol = ", symbol, " min volume = ", marketWatch.GetMinVolume(symbol));
    // Get stop level
    Print("symbol = ", symbol, " stop level = ", marketWatch.GetStopLevel(symbol));
    // get max volume
    Print("symbol = ", symbol, " max volume = ", marketWatch.GetMaxVolume(symbol));
    // tampilkan volume step
    Print("symbol = ", symbol, " volume step = ", marketWatch.GetVolumeStep(symbol));
    // percent change
    Print("symbol = ", symbol, " price change = ", marketWatch.GetPriceChange(symbol));
    // get last high
    Print("symbol = ", symbol, " last high = ", marketWatch.GetLastHigh(symbol));
    // get last low
    Print("symbol = ", symbol, " last low = ", marketWatch.GetLastLow(symbol));
    // get ask high
    Print("symbol = ", symbol, " ask high = ", marketWatch.GetAskHigh(symbol));
    // get ask low
    Print("symbol = ", symbol, " ask low = ", marketWatch.GetAskLow(symbol));
    // get bid high
    Print("symbol = ", symbol, " bid high = ", marketWatch.GetBidHigh(symbol));
    // get bid low
    Print("symbol = ", symbol, " bid low = ", marketWatch.GetBidLow(symbol));
    // get session open
    Print("symbol = ", symbol, " session open = ", marketWatch.GetSessionOpen(symbol));
    // get session close
    Print("symbol = ", symbol, " session close = ", marketWatch.GetSessionClose(symbol));
    Print("======================== end ============================");
}
//+------------------------------------------------------------------+