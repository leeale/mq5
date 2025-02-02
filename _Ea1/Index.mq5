
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

#include "Input.mqh"
#include "Class/SymbolHandler.mqh"
#include "Class/Handler_Indikator.mqh"
CSymbolHandler symbolHandler;
// Deklarasi global
C_Handler_Indikator *maHandler;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    symbolHandler.SetSymbolType();

    // Buat instance baru
    maHandler = new C_Handler_Indikator();

    // Initialize untuk 6 MA
    if (!maHandler.Initialize(6, 6))
    {
        Print("Failed to initialize MA handler");
        return INIT_FAILED;
    }
    if (!maHandler.CreateIndicatorsMA(Symbol()))
    {
        Print("Failed to create indicators");
        return INIT_FAILED;
    }

    // Set konfigurasi MA1
    maHandler.SetMAConfig(0, ma1_label, ma1_active, ma1_type, ma1_buy, ma1_sell,
                          ma1_timeframe, ma1_periode, ma1_shift, ma1_method, ma1_price);
    maHandler.SetMAConfig(1, ma2_label, ma2_active, ma2_type, ma2_buy, ma2_sell,
                          ma2_timeframe, ma2_periode, ma2_shift, ma2_method, ma2_price);
    maHandler.SetMAConfig(2, ma3_label, ma3_active, ma3_type, ma3_buy, ma3_sell,
                          ma3_timeframe, ma3_periode, ma3_shift, ma3_method, ma3_price);
    maHandler.SetMAConfig(3, ma4_label, ma4_active, ma4_type, ma4_buy, ma4_sell,
                          ma4_timeframe, ma4_periode, ma4_shift, ma4_method, ma4_price);
    maHandler.SetMAConfig(4, ma5_label, ma5_active, ma5_type, ma5_buy, ma5_sell,
                          ma5_timeframe, ma5_periode, ma5_shift, ma5_method, ma5_price);
    maHandler.SetMAConfig(5, ma6_label, ma6_active, ma6_type, ma6_buy, ma6_sell,
                          ma6_timeframe, ma6_periode, ma6_shift, ma6_method, ma6_price);

    // set konfigurasi BB1
    maHandler.SetBBConfig(0, bb1_label, bb1_active, bb1_type, bb1_buy, bb1_sell,
                          bb1_timeframe, bb1_periode, bb1_shift, bb1_deviation, bb1_price);
    maHandler.SetBBConfig(1, bb2_label, bb2_active, bb2_type, bb2_buy, bb2_sell,
                          bb2_timeframe, bb2_periode, bb2_shift, bb2_deviation, bb2_price);
    maHandler.SetBBConfig(2, bb3_label, bb3_active, bb3_type, bb3_buy, bb3_sell,
                          bb3_timeframe, bb3_periode, bb3_shift, bb3_deviation, bb3_price);
    maHandler.SetBBConfig(3, bb4_label, bb4_active, bb4_type, bb4_buy, bb4_sell,
                          bb4_timeframe, bb4_periode, bb4_shift, bb4_deviation, bb4_price);
    maHandler.SetBBConfig(4, bb5_label, bb5_active, bb5_type, bb5_buy, bb5_sell,
                          bb5_timeframe, bb5_periode, bb5_shift, bb5_deviation, bb5_price);
    maHandler.SetBBConfig(5, bb6_label, bb6_active, bb6_type, bb6_buy, bb6_sell,
                          bb6_timeframe, bb6_periode, bb6_shift, bb6_deviation, bb6_price);

    // Buat indikator untuk symbol tertentu
    maHandler.CreateIndicatorsMA("NZDJPY");
    maHandler.CreateIndicatorsBB("NZDJPY");

    // Create indicators

    EventSetTimer(1);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    if (maHandler != NULL)
    {
        delete maHandler;
        maHandler = NULL;
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
    SMAConfig maConfig;
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