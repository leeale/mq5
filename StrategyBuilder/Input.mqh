#include "Enum.mqh"

input string _ll = "========== (0# SETTING GENERAL) =========="; // ​
input ENUM_ON_OFF debug = ON;                                    // Debuging
input ENUM_ON_OFF power = ON;                                    // Power EA
input double lot = 0.01;                                         // Lot Size
input ENUM_STRATEGY_COMBINATION combi_signal = AND;              // Signal Combination

input int max_spread = 0;            // Max Spread (0 = No Max Spread)
input int jam_start = 0;             // Jam Start (0 = No Jam Start)
input int jam_end = 0;               // Jam End (0 = No Jam End)
input ENUM_DAY_INDO no_day_trading1; // No Day Trading 1
input ENUM_DAY_INDO no_day_trading2; // No Day Trading 2

input string _ll2 = "========== (0# SETTING SYMBOL) =========="; // ​
input ENUM_SYMBOL_TYPE multi_symbol = MULTI_SYMBOL;              // Symbol Type
input string multi_symbol_custom = "EURUSD,GBPUSD,USDJPY";       // Custom Symbol (ex: EURUSD,GBPUSD,USDJPY)

input string ma1 = "========== (MA) 1# indikator MA =========="; // ​
input ENUM_ON_OFF ma1_active = OFF;                              // Active Averaging
input ENUM_SIGNAL_TYPE ma1_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Strategy Type
input ENUM_ACTIVE_DISABLE ma1_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE ma1_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES ma1_timeframe = PERIOD_M5;                 // Timeframe
input int ma1_periode = 14;                                      // Periode MA1
input int ma1_shift = 0;                                         // Shift MA
input ENUM_MA_METHOD ma1_method = MODE_SMA;                      // Method MA
input ENUM_APPLIED_PRICE ma1_price = PRICE_CLOSE;                // Price MA

// ====================== INDIKATOR MA ======================
input string ma2 = "========== (MA) 2# indikator MA =========="; // ​
input ENUM_ON_OFF ma2_active = OFF;                              // Active Averaging
input ENUM_SIGNAL_TYPE ma2_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Strategy Type
input ENUM_ACTIVE_DISABLE ma2_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE ma2_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES ma2_timeframe = PERIOD_M15;                // Timeframe
input int ma2_periode = 14;                                      // Periode MA
input int ma2_shift = 0;                                         // Shift MA
input ENUM_MA_METHOD ma2_method = MODE_SMA;                      // Method MA
input ENUM_APPLIED_PRICE ma2_price = PRICE_CLOSE;                // Price MA
input string ma3 = "========== (MA) 3# indikator MA =========="; // ​
input ENUM_ON_OFF ma3_active = OFF;                              // Active Averaging
input ENUM_SIGNAL_TYPE ma3_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Strategy Type
input ENUM_ACTIVE_DISABLE ma3_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE ma3_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES ma3_timeframe = PERIOD_H1;                 // Timeframe
input int ma3_periode = 14;                                      // Periode MA
input int ma3_shift = 0;                                         // Shift MA
input ENUM_MA_METHOD ma3_method = MODE_SMA;                      // Method MA
input ENUM_APPLIED_PRICE ma3_price = PRICE_CLOSE;                // Price MA
input string ma4 = "========== (MA) 4# indikator MA =========="; // ​
input ENUM_ON_OFF ma4_active = OFF;                              // Active Averaging
input ENUM_SIGNAL_TYPE ma4_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Strategy Type
input ENUM_ACTIVE_DISABLE ma4_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE ma4_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES ma4_timeframe = PERIOD_H4;                 // Timeframe
input int ma4_periode = 14;                                      // Periode MA
input int ma4_shift = 0;                                         // Shift MA
input ENUM_MA_METHOD ma4_method = MODE_SMA;                      // Method MA
input ENUM_APPLIED_PRICE ma4_price = PRICE_CLOSE;                // Price MA
input string ma5 = "========== (MA) 5# indikator MA =========="; // ​
input ENUM_ON_OFF ma5_active = OFF;                              // Active Averaging
input ENUM_SIGNAL_TYPE ma5_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Strategy Type
input ENUM_ACTIVE_DISABLE ma5_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE ma5_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES ma5_timeframe = PERIOD_D1;                 // Timeframe
input int ma5_periode = 14;                                      // Periode MA
input int ma5_shift = 0;                                         // Shift MA
input ENUM_MA_METHOD ma5_method = MODE_SMA;                      // Method MA
input ENUM_APPLIED_PRICE ma5_price = PRICE_CLOSE;                // Price MA
input string _6 = "========== (MA) 6# indikator MA ==========";  // ​
input ENUM_ON_OFF ma6_active = OFF;                              // Active Averaging
input ENUM_SIGNAL_TYPE ma6_type = ENUM_SIGNAL_TYPE::UP_DOWN;     // Strategy Type
input ENUM_ACTIVE_DISABLE ma6_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE ma6_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES ma6_timeframe = PERIOD_D1;                 // Timeframe
input int ma6_periode = 14;                                      // Periode MA
input int ma6_shift = 0;                                         // Shift MA
input ENUM_MA_METHOD ma6_method = MODE_SMA;                      // Method MA
input ENUM_APPLIED_PRICE ma6_price = PRICE_CLOSE;                // Price MA

//============================== INDIKATOR BB ================================

input string _bb_ = "========== (BB) 1# indikator BB ==========";                // ​
input ENUM_ON_OFF bb1_active = OFF;                                              // Active Bollinger Bands
input ENUM_BB_SIGNAL_TYPE bb1_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Strategy Type
input ENUM_ACTIVE_DISABLE bb1_buy = ACTIVE;                                      // Buy Signal
input ENUM_ACTIVE_DISABLE bb1_sell = ACTIVE;                                     // Sell Signal
input ENUM_TIMEFRAMES bb1_timeframe = PERIOD_M5;                                 // Timeframe
input int bb1_periode = 20;                                                      // Periode BB
input double bb1_deviation = 2.0;                                                // Deviation BB
input int bb1_shift = 0;                                                         // Shift BB
input ENUM_MA_METHOD bb1_method = MODE_SMA;                                      // Method BB
input ENUM_APPLIED_PRICE bb1_price = PRICE_CLOSE;                                // Price BB
input string _bb2_ = "========== (BB) 2# indikator BB ==========";               // ​
input ENUM_ON_OFF bb2_active = OFF;                                              // Active Bollinger Bands
input ENUM_BB_SIGNAL_TYPE bb2_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Strategy Type
input ENUM_ACTIVE_DISABLE bb2_buy = ACTIVE;                                      // Buy Signal
input ENUM_ACTIVE_DISABLE bb2_sell = ACTIVE;                                     // Sell Signal
input ENUM_TIMEFRAMES bb2_timeframe = PERIOD_M15;                                // Timeframe
input int bb2_periode = 20;                                                      // Periode BB
input double bb2_deviation = 2.0;                                                // Deviation BB
input int bb2_shift = 0;                                                         // Shift BB
input ENUM_MA_METHOD bb2_method = MODE_SMA;                                      // Method BB
input ENUM_APPLIED_PRICE bb2_price = PRICE_CLOSE;                                // Price BB
input string _bb3_ = "========== (BB) 3# indikator BB ==========";               // ​
input ENUM_ON_OFF bb3_active = OFF;                                              // Active Bollinger Bands
input ENUM_BB_SIGNAL_TYPE bb3_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Strategy Type
input ENUM_ACTIVE_DISABLE bb3_buy = ACTIVE;                                      // Buy Signal
input ENUM_ACTIVE_DISABLE bb3_sell = ACTIVE;                                     // Sell Signal
input ENUM_TIMEFRAMES bb3_timeframe = PERIOD_H1;                                 // Timeframe
input int bb3_periode = 20;                                                      // Periode BB
input double bb3_deviation = 2.0;                                                // Deviation BB
input int bb3_shift = 0;                                                         // Shift BB
input ENUM_MA_METHOD bb3_method = MODE_SMA;                                      // Method BB
input ENUM_APPLIED_PRICE bb3_price = PRICE_CLOSE;                                // Price BB
input string _bb4_ = "========== (BB) 4# indikator BB ==========";               // ​
input ENUM_ON_OFF bb4_active = OFF;                                              // Active Bollinger Bands
input ENUM_BB_SIGNAL_TYPE bb4_type = ENUM_BB_SIGNAL_TYPE::CROSS_UP_DOWN_REVERSE; // Strategy Type
input ENUM_ACTIVE_DISABLE bb4_buy = ACTIVE;                                      // Buy Signal
input ENUM_ACTIVE_DISABLE bb4_sell = ACTIVE;                                     // Sell Signal
input ENUM_TIMEFRAMES bb4_timeframe = PERIOD_H4;                                 // Timeframe
input int bb4_periode = 20;                                                      // Periode BB
input double bb4_deviation = 2.0;                                                // Deviation BB
input int bb4_shift = 0;                                                         // Shift BB
input ENUM_MA_METHOD bb4_method = MODE_SMA;                                      // Method BB
input ENUM_APPLIED_PRICE bb4_price = PRICE_CLOSE;                                // Price BB
input string _bb5_ = "========== (BB) 5# indikator BB ==========";               // ​
input ENUM_ON_OFF bb5_active = OFF;                                              // Active Bollinger Bands
input ENUM_BB_SIGNAL_TYPE bb5_type = CROSS_UP_DOWN_REVERSE;                      // Strategy Type
input ENUM_ACTIVE_DISABLE bb5_buy = ACTIVE;                                      // Buy Signal
input ENUM_ACTIVE_DISABLE bb5_sell = ACTIVE;                                     // Sell Signal
input ENUM_TIMEFRAMES bb5_timeframe = PERIOD_D1;                                 // Timeframe
input int bb5_periode = 20;                                                      // Periode BB
input double bb5_deviation = 2.0;                                                // Deviation BB
input int bb5_shift = 0;                                                         // Shift BB
input ENUM_MA_METHOD bb5_method = MODE_SMA;                                      // Method BB
input ENUM_APPLIED_PRICE bb5_price = PRICE_CLOSE;                                // Price BB

//============================== hELPER FUNCTION ================================
int Digit(string symbol)
{
    return (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
}
double Point(string symbol)
{
    return SymbolInfoDouble(symbol, SYMBOL_POINT);
}
double Ask(string symbol)
{
    return SymbolInfoDouble(symbol, SYMBOL_ASK);
}
double Bid(string symbol)
{
    return SymbolInfoDouble(symbol, SYMBOL_BID);
}
double Noramldouble(double value, string symbol)
{
    return NormalizeDouble(value, Digit(symbol));
}
double SlBuy(string symbol, int sl)
{
    return Ask(symbol) - sl * Point(symbol);
}
double SlSell(string symbol, int sl)
{
    return Bid(symbol) + sl * Point(symbol);
}
int Spread(string symbol)
{
    return (int)SymbolInfoInteger(symbol, SYMBOL_SPREAD);
}
double SpreadPoint(string symbol)
{
    return Spread(symbol) * Point(symbol);
}