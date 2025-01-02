#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict
#include "EaHelper.mqh"
#include "EaInput1.mqh"

int OnInit()
{

    EventSetTimer(60);

    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    EventKillTimer();
}

void OnTick()
{
}

void OnTimer()
{
}

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
}