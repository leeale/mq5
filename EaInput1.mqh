#ifndef EAINPUT1_MQH
#define EAINPUT1_MQH

#include "EaHelper.mqh"

#property strict
input bool debug = true;                                                                              // Debuging
input string ma1 = "========== (MA) 1# indikator MA ==========";                                      // ​
input ENUM_ON_OFF ma1_active = ON;                                                                    // Active Averaging
input ENUM_MA_SIGNAL_TYPE ma1_type = MA_SIGNAL_UP_DOWN_CURRENTPRICE;                                  // Strategy Type
input ENUM_ACTIVE_DISABLE ma1_buy = ACTIVE;                                                           // Buy Signal
input ENUM_ACTIVE_DISABLE ma1_sell = ACTIVE;                                                          // Sell Signal
input ENUM_TIMEFRAMES ma1_timeframe = PERIOD_CURRENT;                                                 // Timeframe
input ENUM_MA_SIGNAL_INDIKATOR1 ma1_signal_indikator1 = ENUM_MA_SIGNAL_INDIKATOR1::MA_MOVING_AVERAGE; // Signal Indikator1 (Fast)
input int ma1_periode1 = 14;                                                                          // Periode MA1
input int ma1_shift1 = 0;                                                                             // Shift MA1
input ENUM_APPLIED_PRICE ma1_price1 = PRICE_CLOSE;                                                    // Price MA1
input ENUM_MA_METHOD ma1_method1 = MODE_SMA;                                                          // Method MA1
input ENUM_MA_SIGNAL_INDIKATOR2 ma1_signal_indikator2 = ENUM_MA_SIGNAL_INDIKATOR2::MA_MOVING_AVERAGE; // Signal Indikator 2 (Slow)
input int ma1_periode2 = 70;                                                                          // Periode MA2
input int ma1_shift2 = 0;                                                                             // Shift MA2
input ENUM_APPLIED_PRICE ma1_price2 = PRICE_CLOSE;                                                    // Price MA2
input ENUM_MA_METHOD ma1_method2 = MODE_SMA;                                                          // Method MA2
// input string _3 = "";                                                                                 // ​

input string ma2 = "========== (MA) 2# indikator MA ==========";                                      // ​
input ENUM_ON_OFF ma2_active = OFF;                                                                   // Active Averaging
input ENUM_MA_SIGNAL_TYPE ma2_type = MA_SIGNAL_CROSS;                                                 // Strategy Type
input ENUM_ACTIVE_DISABLE ma2_buy = ACTIVE;                                                           // Buy Signal
input ENUM_ACTIVE_DISABLE ma2_sell = ACTIVE;                                                          // Sell Signal
input ENUM_TIMEFRAMES ma2_timeframe = PERIOD_CURRENT;                                                 // Timeframe
input ENUM_MA_SIGNAL_INDIKATOR1 ma2_signal_indikator1 = ENUM_MA_SIGNAL_INDIKATOR1::MA_MOVING_AVERAGE; // Signal Indikator1 (Fast)
input int ma2_periode1 = 14;                                                                          // Periode MA1
input int ma2_shift1 = 0;                                                                             // Shift MA1
input ENUM_APPLIED_PRICE ma2_price1 = PRICE_CLOSE;                                                    // Price MA1
input ENUM_MA_METHOD ma2_method1 = MODE_SMA;                                                          // Method MA1
input ENUM_MA_SIGNAL_INDIKATOR2 ma2_signal_indikator2 = ENUM_MA_SIGNAL_INDIKATOR2::MA_MOVING_AVERAGE; // Signal Indikator 2 (Slow)
input int ma2_periode2 = 70;                                                                          // Periode MA2
input int ma2_shift2 = 0;                                                                             // Shift MA2
input ENUM_APPLIED_PRICE ma2_price2 = PRICE_CLOSE;                                                    // Price MA2
input ENUM_MA_METHOD ma2_method2 = MODE_SMA;                                                          // Method MA2
// input string _33 = "";                                                                                // ​
input string bb1 = "========== (BB) 1# indikator BB =========="; // ​
input ENUM_ON_OFF bb1_active = OFF;                              // Active Bolinger Bands
input ENUM_MA_SIGNAL_TYPE bb1_type = MA_SIGNAL_CROSS;            // Strategy Type
input ENUM_ACTIVE_DISABLE bb1_buy = ACTIVE;                      // Buy Signal
input ENUM_ACTIVE_DISABLE bb1_sell = ACTIVE;                     // Sell Signal
input ENUM_TIMEFRAMES bb1_timeframe = PERIOD_CURRENT;            // Timeframe
input int bb1_periode1 = 20;                                     // Periode BB
input int bb1_shift1 = 0;                                        // Shift BB
input double bb1_deviation = 2.0;                                // Deviation BB
input ENUM_MA_METHOD bb1_method = MODE_SMA;                      // Method BB
input ENUM_APPLIED_PRICE bb1_price = PRICE_CLOSE;                // Price BB
input int bb_signal_bar = 0;                                     // Signal Bar (0 = Current Bar, 1 = Previous Bar dst)

input string _combi = "========== (STRATEGI/SIGNAL COMBINATION) =========="; // ​
input ENUM_STRATEGY_COMBINATION combi_signal = AND;                          // Signal Combination
input string _multiSymbol = "========== (MULTI SYMBOL) ==========";          // ​
input ENUM_SYMBOL_TYPE multi_symbol = MULTI_SYMBOL;                          // Multi Symbol By Market Watch
// input string multi_symbol_custom = "";                                       // Multi Symbol Custom EURUSD,GBPUSD,USDJPY

#endif // EAINPUT1_MQH