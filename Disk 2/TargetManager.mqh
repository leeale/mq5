//+------------------------------------------------------------------+
//|                                                 TargetManager.mqh   |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Author Name"
#property link "Link"
#property version "1.00"

#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include <Files/File.mqh>

#define BUTTON_NAME "closeall"

class CTargetManager
{
private:
    CPositionInfo m_position;
    CTrade m_trade;

    double m_savedBalance;
    bool m_isBalanceLoaded;
    int m_targetProfit;

public:
    CTargetManager()
    {
        m_savedBalance = 0;
        m_isBalanceLoaded = false;
        m_targetProfit = 10;
    }

    void Init()
    {
        LoadBalance();
        ShowTargetOnChart();
        CreateCloseButton();
    }

    void Deinit()
    {
        ObjectDelete(0, "TargetLabel1");
        ObjectDelete(0, "TargetLabel2");
        ObjectDelete(0, BUTTON_NAME);
        ChartRedraw(0);
    }

    double GetSavedBalance() { return m_savedBalance; }
    void SetTargetProfit(int target) { m_targetProfit = target; }

    void CheckAndCloseAllOrders();
    void ShowTargetOnChart();
    void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
    {
        if (id == CHARTEVENT_OBJECT_CLICK && sparam == BUTTON_NAME)
        {
            CloseAllOrders();
        }
    }

private:
    double LoadBalance();
    void CloseAllOrders();
    void CreateCloseButton()
    {
        if (ObjectFind(0, BUTTON_NAME) >= 0)
            ObjectDelete(0, BUTTON_NAME);

        if (!ObjectCreate(0, BUTTON_NAME, OBJ_BUTTON, 0, 0, 0))
        {
            Print("Failed to create button: ", GetLastError());
            return;
        }

        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_XDISTANCE, 20);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_YDISTANCE, 30);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_XSIZE, 100);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_YSIZE, 30);
        ObjectSetString(0, BUTTON_NAME, OBJPROP_TEXT, "Close All");
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_COLOR, clrBlack);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_BORDER_COLOR, clrBlack);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_BGCOLOR, clrWhite);
        ObjectSetInteger(0, BUTTON_NAME, OBJPROP_SELECTABLE, false);
    }
};

//+------------------------------------------------------------------+
double CTargetManager::LoadBalance(void)
{
    if (!m_isBalanceLoaded)
    {
        string filename = "balance_history.txt";
        if (FileIsExist(filename))
        {
            int handle = FileOpen(filename, FILE_READ | FILE_TXT | FILE_ANSI);
            string content = FileReadString(handle);
            m_savedBalance = StringToDouble(content);
            FileClose(handle);
        }
        else
        {
            double currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);
            int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
            FileWriteString(handle, DoubleToString(currentBalance, 2));
            FileClose(handle);
            m_savedBalance = currentBalance;
        }
        m_isBalanceLoaded = true;
    }
    return m_savedBalance;
}

//+------------------------------------------------------------------+
void CTargetManager::CloseAllOrders()
{
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (m_position.SelectByIndex(i))
        {
            if (!m_trade.PositionClose(m_position.Ticket()))
                Print("Error closing position: ", GetLastError());
            else
                Print("Position closed: ", m_position.Symbol());
        }
    }

    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        ulong ticket = OrderGetTicket(i);
        if (ticket > 0)
        {
            m_trade.OrderDelete(ticket);
        }
    }
}

//+------------------------------------------------------------------+
void CTargetManager::CheckAndCloseAllOrders()
{
    double currentEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double targetBalance = m_savedBalance + m_targetProfit;

    if (currentEquity >= targetBalance)
    {
        Print("Target reached! Initial balance: ", m_savedBalance,
              " Target: ", targetBalance,
              " Current equity: ", currentEquity);

        CloseAllOrders();

        double newBalance = AccountInfoDouble(ACCOUNT_BALANCE);
        string filename = "balance_history.txt";
        int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
        if (handle != INVALID_HANDLE)
        {
            FileWriteString(handle, DoubleToString(newBalance, 2));
            FileClose(handle);
            m_savedBalance = newBalance;
            Print("New balance saved: ", newBalance);
        }
    }
}

//+------------------------------------------------------------------+
void CTargetManager::ShowTargetOnChart()
{
    double currentEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double targetBalance = m_savedBalance + m_targetProfit;
    double remainingToTarget = currentEquity - targetBalance + m_targetProfit;

    if (ObjectFind(0, "TargetLabel1") < 0)
        ObjectCreate(0, "TargetLabel1", OBJ_LABEL, 0, 0, 0);

    ObjectSetInteger(0, "TargetLabel1", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_YDISTANCE, 80);
    ObjectSetString(0, "TargetLabel1", OBJPROP_TEXT,
                    "Target: $" + DoubleToString(targetBalance, 2));
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_COLOR, clrWhite);
    ObjectSetInteger(0, "TargetLabel1", OBJPROP_FONTSIZE, 10);

    if (ObjectFind(0, "TargetLabel2") < 0)
        ObjectCreate(0, "TargetLabel2", OBJ_LABEL, 0, 0, 0);

    ObjectSetInteger(0, "TargetLabel2", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_YDISTANCE, 95);
    ObjectSetString(0, "TargetLabel2", OBJPROP_TEXT,
                    "Remaining: $" + DoubleToString(remainingToTarget, 2));
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_COLOR, remainingToTarget > 0 ? clrLime : clrRed);
    ObjectSetInteger(0, "TargetLabel2", OBJPROP_FONTSIZE, 10);

    ChartRedraw(0);
}