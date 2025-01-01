#property copyright "Copyright 2024, Author Name"
#property link "Link"
#property version "1.00"
#property strict

//+------------------------------------------------------------------+
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include <Files/File.mqh>

CPositionInfo position;
CTrade trade;

double g_savedBalance = 0;
bool g_isBalanceLoaded = false;

int target_profit = 10;
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{

    EventSetTimer(1); //

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    ObjectDelete(0, "TargetLabel");
    ChartRedraw(0);
    EventKillTimer();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{

    double savedBalance = BalancedFile();

    ShowTargetOnChart();

    CheckAndCloseAllOrders();
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
void CloseAllOrders()
{
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (position.SelectByIndex(i))
        {
            if (!trade.PositionClose(position.Ticket()))
                Print("Error closing position: ", GetLastError());
            else
                Print("Position closed: ", position.Symbol());
        }
    }

    // Close pending orders if any
    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        ulong ticket = OrderGetTicket(i);
        if (ticket > 0)
        {
            trade.OrderDelete(ticket);
        }
    }
}
//+------------------------------------------------------------------+
double BalancedFile()
{
    if (!g_isBalanceLoaded)
    {
        string filename = "balance_history.txt";
        if (FileIsExist(filename))
        {
            int handle = FileOpen(filename, FILE_READ | FILE_TXT | FILE_ANSI);
            string content = FileReadString(handle);
            g_savedBalance = StringToDouble(content);
            FileClose(handle);
        }
        else
        {
            double currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);
            int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
            FileWriteString(handle, DoubleToString(currentBalance, 2));
            FileClose(handle);
            g_savedBalance = currentBalance;
        }
        g_isBalanceLoaded = true;
    }
    return g_savedBalance;
}

void CheckAndCloseAllOrders()
{
    double currentEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double targetBalance = g_savedBalance + target_profit;

    if (currentEquity >= targetBalance)
    {
        Print("Target reached! Initial balance: ", g_savedBalance,
              " Target: ", targetBalance,
              " Current equity: ", currentEquity);

        CloseAllOrders();

        // Reset saved balance ke balance saat ini
        double newBalance = AccountInfoDouble(ACCOUNT_BALANCE);
        string filename = "balance_history.txt";
        int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
        if (handle != INVALID_HANDLE)
        {
            FileWriteString(handle, DoubleToString(newBalance, 2));
            FileClose(handle);
            g_savedBalance = newBalance;
            Print("New balance saved: ", newBalance);
        }
    }
}
void ShowTargetOnChart()
{
    double currentEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double targetBalance = g_savedBalance + target_profit;
    double remainingToTarget = targetBalance - currentEquity;

    // Label untuk Target
    if (ObjectFind(0, "TargetLabel1") < 0)
        ObjectCreate(0, "TargetLabel1", OBJ_LABEL, 0, 0, 0);

    ObjectSetInteger(0, "TargetLabel1", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_YDISTANCE, 40);
    ObjectSetString(0, "TargetLabel1", OBJPROP_TEXT,
                    "Target: $" + DoubleToString(targetBalance, 2));
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_COLOR, clrWhite);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_FONTSIZE, 10);

    // Label untuk Remaining
    if (ObjectFind(0, "TargetLabel2") < 0)
        ObjectCreate(0, "TargetLabel2", OBJ_LABEL, 0, 0, 0);

    ObjectSetInteger(0, "TargetLabel2", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_YDISTANCE, 60); // Posisi lebih bawah
    ObjectSetString(0, "TargetLabel2", OBJPROP_TEXT,
                    "Remaining: $" + DoubleToString(remainingToTarget, 2));
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_COLOR, remainingToTarget > 0 ? clrRed : clrLime);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_FONTSIZE, 10);

    ChartRedraw(0);
}