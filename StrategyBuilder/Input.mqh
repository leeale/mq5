

#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include "Enum.mqh"

#define BUTTON_NAME "closeall"
#define BUTTON_NAME1 "closeallsymbol"
double m_savedBalance;
bool m_isBalanceLoaded;

input string _ll = "========== ( SETTING GENERAL) =========="; // ​
input ENUM_ON_OFF debug = OFF;                                 // Debuging
input ENUM_ON_OFF power = ON;                                  // Power EA
input ENUM_STRATEGY_COMBINATION combi_signal = AND;            // Signal Combination
input int m_targetProfit = 10;                                 // Close All Profit, Dari Balance Terakhir (File Balance)
input int m_balancedManual = 0;                                // Set Balanced Manual Harus direset ke 0 Setelah Input
input int InpStopLoss = 0;                                     // Hidden Stop Loss (in points, 0=off)
input int InpTakeProfit = 0;                                   // Hidden Take Profit (in points, 0=off)

input string _ll2 = "========== ( SETTING SYMBOL) ==========";          // ​
input ENUM_SYMBOL_TYPE multi_symbol = ENUM_SYMBOL_TYPE::SYMBOL_CURRENT; // Symbol Type
input string multi_symbol_custom = "EURUSD,GBPUSD,USDJPY";              // Custom Symbol (ex: EURUSD,GBPUSD,USDJPY)

input string _Lll = "========== ( SETTING OPEN ORDER) ==========";            // ​
input ENUM_TRADING_DIRECTION trading_direction = ENUM_TRADING_DIRECTION::ALL; // Mode Order
input ENUM_LOT_TYPE lot_type = ENUM_LOT_TYPE::LOT_FIXED;                      // Mode Lot Option
input double lot = 0.01;                                                      // Mode Lot Fixed
input int lot_balance = 500;                                                  // Mode Lot Balance (Balance / Lot)
input double risk_percent = 1.0;                                              // Mode Lot Risk Percentage (Percentage Calc Stoploss)
input double max_lot = 0.1;                                                   // Max Lot
input int Stoploss = 100;                                                     // Stop Loss (Point)
input int Takeprofit = 0;                                                     // Take Profit (Point)
input int magic_number = 123456;                                              // Magic Number
input string komment = "Strategy Builder";                                    // Comment

input string _lll = "======= (MAX ORDER / LIMIT ORDER / GRID) ======="; // ​
input ENUM_ONE_ORDER_TYPE one_order_type = ONE_ORDER_PER_SYMBOL;        // Mode Grid dan Limit
input ENUM_GRID_DIRECTION grid_direction_setting = GRID_AUTO_FOLLOW;    // Mode Grid Option
input ENUM_ON_OFF mode_grid_timeframe = OFF;                            // Mode Grid Timeframe
input ENUM_TIMEFRAMES one_order_timeframe = PERIOD_M1;                  // Mode Timeframe & Mode Grid , (Mode Grid Bisa On Off)
input int min_distance_points = 0;                                      // Min Jarak Order (Mode Custom dan Mode Pertimeframe)
input int max_order = 0;                                                // Max Order Per Symbol (Mode Custom)
input int max_order_total = 0;                                          // Max Order Total (Mode Custom)
input int grid_min = 200;                                               // Grid Min Jarak Order Dengan Order Sebelumnya (Profit / Loss Point)
input int max_grid = 5;                                                 // Grid Max Open Order
input ENUM_LOT_MODE grid_lot_mode = GRID_DISABLE;                       // Grid Mode Lot
input double fixed_lot = 0.01;                                          // Grid Fixed Lot
input double grid_add_value = 0.01;                                     // Grid Add Lot
input double martingale_multiplier = 2.0;                               // Grid Multiplier Lot
input double grid_max_lot = 0.1;                                        // Grid Max Lot
input string grid_lot_custom = "0,01,0.02,0.03";                        // Grid Lot Custom (ex: 0,01,0.02,0.03)
input string _sdf = "========== ( SETTING FILTER) ==========";          // ​
input int max_spread = 35;                                              // Max Spread (0 = No Max Spread)
input int jam_start = 2;                                                // Jam Start (0 = No Jam Start)
input int jam_end = 22;                                                 // Jam End (0 = No Jam End)
input ENUM_DAY_INDO no_day_trading1 = Disable;                          // No Day Trading 1
input ENUM_DAY_INDO no_day_trading2 = Disable;                          // No Day Trading 2

input string ma1 = "========== (MA) 1# indikator MA =========="; // ​
input ENUM_ON_OFF ma1_active = OFF;                              // On Off Moving Averaging
input ENUM_SIGNAL_TYPE ma1_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Signal Type
input ENUM_ACTIVE_DISABLE ma1_buy = ACTIVE;                      // Signal Buy
input ENUM_ACTIVE_DISABLE ma1_sell = ACTIVE;                     // Signal Sell
input ENUM_TIMEFRAMES ma1_timeframe = PERIOD_M5;                 // Moving Average TimeFrame
input int ma1_periode = 14;                                      // Moving Average Period Line
input int ma1_shift = 0;                                         // Moving Average Shift
input ENUM_MA_METHOD ma1_method = MODE_SMA;                      // Moving Average Method
input ENUM_APPLIED_PRICE ma1_price = PRICE_CLOSE;                // Moving Average Applied Price

// ====================== INDIKATOR MA ======================
input string ma2 = "========== (MA) 2# indikator MA =========="; // ​
input ENUM_ON_OFF ma2_active = OFF;                              // On Off Moving Averaging
input ENUM_SIGNAL_TYPE ma2_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Signal Type
input ENUM_ACTIVE_DISABLE ma2_buy = ACTIVE;                      // Signal Buy
input ENUM_ACTIVE_DISABLE ma2_sell = ACTIVE;                     // Signal Sell
input ENUM_TIMEFRAMES ma2_timeframe = PERIOD_M15;                // Moving Average TimeFrame
input int ma2_periode = 14;                                      // Moving Average Period Line
input int ma2_shift = 0;                                         // Moving Average Shift
input ENUM_MA_METHOD ma2_method = MODE_SMA;                      // Moving Average Method
input ENUM_APPLIED_PRICE ma2_price = PRICE_CLOSE;                // Moving Average Applied Price
input string ma3 = "========== (MA) 3# indikator MA =========="; // ​
input ENUM_ON_OFF ma3_active = OFF;                              // On Off Moving Averaging
input ENUM_SIGNAL_TYPE ma3_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Signal Type
input ENUM_ACTIVE_DISABLE ma3_buy = ACTIVE;                      // Signal Buy
input ENUM_ACTIVE_DISABLE ma3_sell = ACTIVE;                     // Signal Sell
input ENUM_TIMEFRAMES ma3_timeframe = PERIOD_H1;                 // Moving Average TimeFrame
input int ma3_periode = 14;                                      // Moving Average Period Line
input int ma3_shift = 0;                                         // Moving Average Shift
input ENUM_MA_METHOD ma3_method = MODE_SMA;                      // Moving Average Method
input ENUM_APPLIED_PRICE ma3_price = PRICE_CLOSE;                // Moving Average Applied Price
input string ma4 = "========== (MA) 4# indikator MA =========="; // ​
input ENUM_ON_OFF ma4_active = OFF;                              // On Off Moving Averaging
input ENUM_SIGNAL_TYPE ma4_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Signal Type
input ENUM_ACTIVE_DISABLE ma4_buy = ACTIVE;                      // Signal Buy
input ENUM_ACTIVE_DISABLE ma4_sell = ACTIVE;                     // Signal Sell
input ENUM_TIMEFRAMES ma4_timeframe = PERIOD_H4;                 // Moving Average TimeFrame
input int ma4_periode = 14;                                      // Moving Average Period Line
input int ma4_shift = 0;                                         // Moving Average Shift
input ENUM_MA_METHOD ma4_method = MODE_SMA;                      // Moving Average Method
input ENUM_APPLIED_PRICE ma4_price = PRICE_CLOSE;                // Moving Average Applied Price
input string ma5 = "========== (MA) 5# indikator MA =========="; // ​
input ENUM_ON_OFF ma5_active = OFF;                              // On Off Moving Averaging
input ENUM_SIGNAL_TYPE ma5_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Signal Type
input ENUM_ACTIVE_DISABLE ma5_buy = ACTIVE;                      // Signal Buy
input ENUM_ACTIVE_DISABLE ma5_sell = ACTIVE;                     // Signal Sell
input ENUM_TIMEFRAMES ma5_timeframe = PERIOD_D1;                 // Moving Average TimeFrame
input int ma5_periode = 14;                                      // Moving Average Period Line
input int ma5_shift = 0;                                         // Moving Average Shift
input ENUM_MA_METHOD ma5_method = MODE_SMA;                      // Moving Average Method
input ENUM_APPLIED_PRICE ma5_price = PRICE_CLOSE;                // Moving Average Applied Price
input string _6 = "========== (MA) 6# indikator MA ==========";  // ​
input ENUM_ON_OFF ma6_active = OFF;                              // On Off Moving Averaging
input ENUM_SIGNAL_TYPE ma6_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Signal Type
input ENUM_ACTIVE_DISABLE ma6_buy = ACTIVE;                      // Signal Buy
input ENUM_ACTIVE_DISABLE ma6_sell = ACTIVE;                     // Signal Sell
input ENUM_TIMEFRAMES ma6_timeframe = PERIOD_D1;                 // Moving Average TimeFrame
input int ma6_periode = 14;                                      // Moving Average Period Line
input int ma6_shift = 0;                                         // Moving Average Shift
input ENUM_MA_METHOD ma6_method = MODE_SMA;                      // Moving Average Method
input ENUM_APPLIED_PRICE ma6_price = PRICE_CLOSE;                // Moving Average Applied Price

//============================== INDIKATOR BB ================================

input string _bb_ = "========== (BB) 1# indikator BB ==========";                // ​
input ENUM_ON_OFF bb1_active = OFF;                                              // On Off Bolinger Bands
input ENUM_BB_SIGNAL_TYPE bb1_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Signal Type
input ENUM_ACTIVE_DISABLE bb1_buy = ACTIVE;                                      // Signal Buy
input ENUM_ACTIVE_DISABLE bb1_sell = ACTIVE;                                     // Signal Sell
input ENUM_TIMEFRAMES bb1_timeframe = PERIOD_M5;                                 // Bolinger Bands TimeFrame
input int bb1_periode = 20;                                                      // Bolinger Bands Periode Line
input double bb1_deviation = 2.0;                                                // Bolinger Bands Deviation
input int bb1_shift = 0;                                                         // Bolinger Bands Shift
input ENUM_MA_METHOD bb1_method = MODE_SMA;                                      // Bolinger Bands Method
input ENUM_APPLIED_PRICE bb1_price = PRICE_CLOSE;                                // Bolinger Bands Applied Price
input string _bb2_ = "========== (BB) 2# indikator BB ==========";               // ​
input ENUM_ON_OFF bb2_active = OFF;                                              // On Off Bolinger Bands
input ENUM_BB_SIGNAL_TYPE bb2_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Signal Type
input ENUM_ACTIVE_DISABLE bb2_buy = ACTIVE;                                      // Signal Buy
input ENUM_ACTIVE_DISABLE bb2_sell = ACTIVE;                                     // Signal Sell
input ENUM_TIMEFRAMES bb2_timeframe = PERIOD_M15;                                // Bolinger Bands TimeFrame
input int bb2_periode = 20;                                                      // Bolinger Bands Periode Line
input double bb2_deviation = 2.0;                                                // Bolinger Bands Deviation
input int bb2_shift = 0;                                                         // Bolinger Bands Shift
input ENUM_MA_METHOD bb2_method = MODE_SMA;                                      // Bolinger Bands Method
input ENUM_APPLIED_PRICE bb2_price = PRICE_CLOSE;                                // Bolinger Bands Applied Price
input string _bb3_ = "========== (BB) 3# indikator BB ==========";               // ​
input ENUM_ON_OFF bb3_active = OFF;                                              // On Off Bolinger Bands
input ENUM_BB_SIGNAL_TYPE bb3_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Signal Type
input ENUM_ACTIVE_DISABLE bb3_buy = ACTIVE;                                      // Signal Buy
input ENUM_ACTIVE_DISABLE bb3_sell = ACTIVE;                                     // Signal Sell
input ENUM_TIMEFRAMES bb3_timeframe = PERIOD_H1;                                 // Bolinger Bands TimeFrame
input int bb3_periode = 20;                                                      // Bolinger Bands Periode Line
input double bb3_deviation = 2.0;                                                // Bolinger Bands Deviation
input int bb3_shift = 0;                                                         // Bolinger Bands Shift
input ENUM_MA_METHOD bb3_method = MODE_SMA;                                      // Bolinger Bands Method
input ENUM_APPLIED_PRICE bb3_price = PRICE_CLOSE;                                // Bolinger Bands Applied Price
input string _bb4_ = "========== (BB) 4# indikator BB ==========";               // ​
input ENUM_ON_OFF bb4_active = OFF;                                              // On Off Bolinger Bands
input ENUM_BB_SIGNAL_TYPE bb4_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Signal Type
input ENUM_ACTIVE_DISABLE bb4_buy = ACTIVE;                                      // Signal Buy
input ENUM_ACTIVE_DISABLE bb4_sell = ACTIVE;                                     // Signal Sell
input ENUM_TIMEFRAMES bb4_timeframe = PERIOD_H4;                                 // Bolinger Bands TimeFrame
input int bb4_periode = 20;                                                      // Bolinger Bands Periode Line
input double bb4_deviation = 2.0;                                                // Bolinger Bands Deviation
input int bb4_shift = 0;                                                         // Bolinger Bands Shift
input ENUM_MA_METHOD bb4_method = MODE_SMA;                                      // Bolinger Bands Method
input ENUM_APPLIED_PRICE bb4_price = PRICE_CLOSE;                                // Bolinger Bands Applied Price
input string _bb5_ = "========== (BB) 5# indikator BB ==========";               // ​
input ENUM_ON_OFF bb5_active = OFF;                                              // On Off Bolinger Bands
input ENUM_BB_SIGNAL_TYPE bb5_type = CROSS_UP_DOWN_REVERSE;                      // Signal Type
input ENUM_ACTIVE_DISABLE bb5_buy = ACTIVE;                                      // Signal Buy
input ENUM_ACTIVE_DISABLE bb5_sell = ACTIVE;                                     // Signal Sell
input ENUM_TIMEFRAMES bb5_timeframe = PERIOD_D1;                                 // Bolinger Bands TimeFrame
input int bb5_periode = 20;                                                      // Bolinger Bands Periode Line
input double bb5_deviation = 2.0;                                                // Bolinger Bands Deviation
input int bb5_shift = 0;                                                         // Bolinger Bands Shift
input ENUM_MA_METHOD bb5_method = MODE_SMA;                                      // Bolinger Bands Method
input ENUM_APPLIED_PRICE bb5_price = PRICE_CLOSE;                                // Bolinger Bands Applied Price

//=============== FUNGSI PEMBANTU === ==============

bool IsPositionBySymbol(string symbol)
{
    bool hasPosition = false;
    CPositionInfo pos;
    for (int i = 0; i < PositionsTotal(); i++)
    {
        if (pos.SelectByIndex(i))
        {
            if (pos.Symbol() == symbol)
            {
                hasPosition = true;
                break;
            }
        }
    }
    return hasPosition;
}
bool IsNewBar(ENUM_TIMEFRAMES timeframe)
{
    static datetime last_time = 0;
    datetime current_time = iTime(NULL, timeframe, 0); //
    if (current_time != last_time)
    {
        last_time = current_time;
        return true;
    }
    return false;
}

void CloseAllOrders(string symbol = NULL)
{
    CPositionInfo position;
    CTrade trade;
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (position.SelectByIndex(i))
        {
            if (symbol == NULL)
            {
                if (!trade.PositionClose(position.Ticket()))
                    Print("Error closing position: ", GetLastError());
                else
                    Print("Position closed: ", position.Symbol());
            }
            else
            {
                if (position.Symbol() == symbol)
                {
                    if (!trade.PositionClose(position.Ticket()))
                        Print("Error closing position: ", GetLastError());
                    else
                        Print("Position closed: ", position.Symbol());
                }
            }
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

void CreateCloseButton()
{
    if (ObjectFind(0, "closeall") >= 0)
        ObjectDelete(0, "closeall");

    if (!ObjectCreate(0, "closeall", OBJ_BUTTON, 0, 0, 0))
    {
        Print("Failed to create button: ", GetLastError());
        return;
    }

    ObjectSetInteger(0, "closeall", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "closeall", OBJPROP_XDISTANCE, 20);
    ObjectSetInteger(0, "closeall", OBJPROP_YDISTANCE, 30);
    ObjectSetInteger(0, "closeall", OBJPROP_XSIZE, 100);
    ObjectSetInteger(0, "closeall", OBJPROP_YSIZE, 30);
    ObjectSetString(0, "closeall", OBJPROP_TEXT, "Close All");
    ObjectSetInteger(0, "closeall", OBJPROP_COLOR, clrBlack);
    ObjectSetInteger(0, "closeall", OBJPROP_BORDER_COLOR, clrBlack);
    ObjectSetInteger(0, "closeall", OBJPROP_BGCOLOR, clrWhite);
    ObjectSetInteger(0, "closeall", OBJPROP_SELECTABLE, false);
}
void CreateCloseButtonSymbol()
{
    if (ObjectFind(0, "closeallsymbol") >= 0)
        ObjectDelete(0, "closeallsymbol");

    if (!ObjectCreate(0, "closeallsymbol", OBJ_BUTTON, 0, 0, 0))
    {
        Print("Failed to create button: ", GetLastError());
        return;
    }

    ObjectSetInteger(0, "closeallsymbol", OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_XDISTANCE, 130);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_YDISTANCE, 30);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_XSIZE, 130);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_YSIZE, 30);
    ObjectSetString(0, "closeallsymbol", OBJPROP_TEXT, "Close All Symbol");
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_COLOR, clrWhite);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_BORDER_COLOR, clrBlack);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_BGCOLOR, clrRed);
    ObjectSetInteger(0, "closeallsymbol", OBJPROP_SELECTABLE, false);
}

void ShowTargetOnChart()
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

void CheckAndCloseAllOrders()
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
double LoadBalance()
{
    if (!m_isBalanceLoaded)
    {
        string filename = "balance_history.txt";
        if (m_balancedManual > 0)
        {
            // Jika balance diset manual, gunakan nilai tersebut
            m_savedBalance = m_balancedManual;

            m_savedBalance = m_balancedManual;
            int handle = FileOpen(filename, FILE_WRITE | FILE_TXT | FILE_ANSI);
            if (handle != INVALID_HANDLE)
            {
                FileWriteString(handle, DoubleToString(m_balancedManual, 2));
                FileClose(handle);
            }
        }
        else
        {
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
        }
        m_isBalanceLoaded = true;
    }
    return m_savedBalance;
}
