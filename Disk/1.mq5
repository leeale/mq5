
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

enum ENUM_STRATEGY
{
    STRATEGY_1 = 1, // strategy 1
    STRATEGY_2 = 2, // strategy 2
    STRATEGY_3 = 3  // strategy 3
};
input ENUM_STRATEGY Strategy = STRATEGY_1; // Strategy

int g_HandleMA[10];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    ArrayInitialize(g_HandleMA, INVALID_HANDLE);
    EventSetTimer(5);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    for (int i = 0; i < 10; i++)
    {
        /* code */
        if (g_HandleMA[i] != INVALID_HANDLE)
        {
            IndicatorRelease(g_HandleMA[i]);
        }
        Print(g_HandleMA[i], " Handle Released");
        Print(g_HandleMA[i]);
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
    if (Strategy == 1)
    {
        for (int i = 0; i < 10; i++)
        {

            if (g_HandleMA[i] == INVALID_HANDLE)
            {
                CreateMAHandle(i);
            }
            else
            {
                RelseaseMAHandle(i);
            }
        }
    }
    else if (Strategy == 2)
    {
        Print("Strategy 2");
    }
    else if (Strategy == 3)
    {
        Print("Strategy 3");
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

void CreateMAHandle(int i)
{

    g_HandleMA[i] = iMA(NULL, 0, 14, 0, MODE_SMA, PRICE_CLOSE);
    Print(i, " MA Handle Created :", g_HandleMA[i]);
    Sleep(1000);
}

void RelseaseMAHandle(int i)
{

    if (g_HandleMA[i] != INVALID_HANDLE)
    {
        IndicatorRelease(g_HandleMA[i]);
        g_HandleMA[i] = INVALID_HANDLE;
    }
    Print(g_HandleMA[i], " Handle Released");
}

//+------------------------------------------------------------------+