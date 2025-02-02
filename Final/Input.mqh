enum Symbol_Type
{
    SYMBOL_ALL,     // All available symbols
    SYMBOL_BASE,    // Mode Base Symbol
    SYMBOL_CURRENT, // Current chart symbol
    SYMBOL_CUSTOM,  // Custom symbol list
};
enum Symbol_Direction
{
    // Disable,    // Disable
    BOOTH_SIDE, // Booth Side
    ONE_SIDE,   // One Side
    BUY,        // Buy
    SELL,       // Sell
    DISABLE,    // Disable
};
enum Symbol_Base
{
    // Disable, // Disable
    USD, // USD
    GBP, // GBP
    EUR, // EUR
    JPY, // JPY
    CAD, // CAD
    CHF, // CHF
    AUD, // AUD
    NZD, // NZD
};
enum Symbol_Base_Direction
{
    // Disable, // Disable
    BUY,     // Buy Base
    SELL,    // Sell Base
    ALL_BUY, // All Buy (ex: xxxUSD Or USDxxx = Buy)
    ALL_SELL // All Sell (ex: xxxGBP Or GBPxxx = Sell)
};
//==================================================================
enum Indikator_Combination
{
    AND, // -- AND --
    OR   // -- OR --
};
enum Indikator_Type
{
    MODE_SIGNAL_MANUAL, // Mode Signal Manual
    MODE_SIGNAL_MULTI,  // Mode Multi Indikator
    // MODE_SIGNAL_AUTO,   // Mode Signal Auto
    DISABLE, // Disable
};
enum Indikator_Type_Manual
{
    IND_BOLLINGER_BANDS, // Bollinger Bands
    IND_MOVING_AVERAGE,  // Moving Average
    IND_RSI,             // Relative Strength Index
};
enum Indikator_Type_Manual_Signal
{
    UP_DOWN,              // Up And Down
    UP_DOWN_REVERSE,      // Up And Down Reverse
    CROSS_FOLLOW,         // Cross Follow Trend
    CROSS_FOLLOW_REVERSE, // Cross Follow Trend Reverse

};
enum ENUM_ON_OFF
{
    ON, // On
    OFF // Off
};
enum ENUM_ACTIVE_DISABLE

{
    ACTIVE, // Active
    DISABLE // Disable
};
enum ENUM_MA_SIGNAL_TYPE

{
    UP_DOWN,         // Up And Down
    UP_DOWN_REVERSE, // Up And Down Reverse
    CROSS_UP,        // Cross
    CROSS_DOWN,      // Cross Down
};
enum ENUM_BB_SIGNAL_TYPE

{
    UP_DOWN,         // Up And Down
    UP_DOWN_REVERSE, // Up And Down Reverse
    CROSS_UP,        // Cross
    CROSS_DOWN,      // Cross Down
};

enum ENUM_INDICATOR_TYPE
{
    IND_MA,    /*Moving Average*/
    IND_RSI,   /*Relative Strength Index*/
    IND_MACD,  /*MACD*/
    IND_STOCH, /*Stochastic*/
    IND_BB,    /*Bollinger Bands*/
    IND_ATR,   /*Average True Range*/
    IND_CUSTOM /*Custom indicator*/
};
//==================================================================
enum ENUM_SIGNAL_TYPE
{
    SIGNAL_BUY,  // Sinyal Beli
    SIGNAL_SELL, // Sinyal Jual
    SIGNAL_NONE  // Tidak Ada Sinyal
};

ENUM_TIMEFRAMES ConvertStringToTimeframe(string timeframeStr)
{
    if (timeframeStr == "M1")
        return PERIOD_M1;
    if (timeframeStr == "M5")
        return PERIOD_M5;
    if (timeframeStr == "M15")
        return PERIOD_M15;
    if (timeframeStr == "M30")
        return PERIOD_M30;
    if (timeframeStr == "H1")
        return PERIOD_H1;
    if (timeframeStr == "H4")
        return PERIOD_H4;
    if (timeframeStr == "D1")
        return PERIOD_D1;
    if (timeframeStr == "W1")
        return PERIOD_W1;
    if (timeframeStr == "MN1")
        return PERIOD_MN1;

    return PERIOD_CURRENT; // default return current timeframe if string not recognized
} // Bolingger Bands Applied Price

input bool i_isTest = false;                                                      // Test Mode
sinput string _l = "========== ( SETTING MODE SYMBOL) ==========";                // ​
input Symbol_Type i_symbolType = Symbol_Type::SYMBOL_ALL;                         // Symbol Type
input Symbol_Direction i_symbolDirection = Symbol_Direction::BOOTH_SIDE;          // Mode Direction
input string i_symbolCustom = "GBPUSD,GBPJPY,GBPCHF,GBPAUD,GBPNZD,GBPCAD,EURGBP"; // Custom Symbol 1
input Symbol_Base i_symbolBase = Symbol_Base::USD;                                // Mode Base Symbol
input Symbol_Base_Direction i_symbolBaseDirection = Symbol_Base_Direction::BUY;   // Base Direction (ex Buy, USDXXX Buy, XXXUSD Sell)

//+------------------------------------------------------------------+
sinput string _l2 = "========== ( SETTING MODE SIGNAL) ==========";               // ​
input Indikator_Combination i_combi_signal = AND;                                 // Signal Combination
input ENUM_ON_OFF i_signal_manual = ENUM_ON_OFF::OFF;                             // Signal Manual
input Indikator_Type_Manual i_signal_manual_type = IND_MOVING_AVERAGE;            // Signal Manual Type
input ENUM_MA_SIGNAL_TYPE i_signal_manual_type_MA = ENUM_MA_SIGNAL_TYPE::UP_DOWN; // Signal Manual Type (MA)
input ENUM_BB_SIGNAL_TYPE i_signal_manual_type_BB = ENUM_BB_SIGNAL_TYPE::UP_DOWN; // Signal Manual Type (BB)
input int i_siganl_manual_total = 3;                                              // Signal Manual Total
input int i_siganl_manual_shift = 0;                                              // Signal Manual Shift
input double i_signal_manual_deviation = 2.0;                                     // Signal Manual Deviation (BB)
input ENUM_MA_METHOD i_signal_manual_method = MODE_SMA;                           // Signal Manual Method (MA)
input ENUM_APPLIED_PRICE i_signal_manual_price = PRICE_CLOSE;                     // Signal Manual Price
input string i_signal_manual_period = "20";                                       // Signal Manual Period
input string i_signal_manual_timeframe = "M5,M15,H1";                             // Signal Manual TimeFrame
                                                                                  // ​
input group "MA Indicator #1" input string ma1_label = "MA #1";                   // MA1 Label
input ENUM_ON_OFF ma1_active = OFF;                                               // On Off Moving Averaging
input ENUM_MA_SIGNAL_TYPE ma1_type = ENUM_MA_SIGNAL_TYPE::UP_DOWN;                // signal Type
input ENUM_TIMEFRAMES ma1_timeframe = PERIOD_M5;                                  // Moving Average TimeFrame
input int ma1_periode = 14;                                                       // Moving Average Period
input int ma1_shift = 0;                                                          // Moving Average Shift
input ENUM_MA_METHOD ma1_method = MODE_SMA;                                       // Moving Average Method
input ENUM_APPLIED_PRICE ma1_price = PRICE_CLOSE;                                 // Moving Average Applied Price
input group "MA Indicator #2" input string ma2_label = "MA #2";                   // MA2 Label
input ENUM_ON_OFF ma2_active = OFF;                                               // On Off Moving Averaging
input ENUM_MA_SIGNAL_TYPE ma2_type = ENUM_MA_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES ma2_timeframe = PERIOD_M15;                                 // Moving Average TimeFrame
input int ma2_periode = 14;                                                       // Moving Average Period Line
input int ma2_shift = 0;                                                          // Moving Average Shift
input ENUM_MA_METHOD ma2_method = MODE_SMA;                                       // Moving Average Method
input ENUM_APPLIED_PRICE ma2_price = PRICE_CLOSE;                                 // Moving Average Applied Price ​
input group "MA Indicator #3" input string ma3_label = "MA #3";                   // MA3 Label
input ENUM_ON_OFF ma3_active = OFF;                                               // On Off Moving Averaging
input ENUM_MA_SIGNAL_TYPE ma3_type = ENUM_MA_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES ma3_timeframe = PERIOD_H1;                                  // Moving Average TimeFrame
input int ma3_periode = 14;                                                       // Moving Average Period Line
input int ma3_shift = 0;                                                          // Moving Average Shift
input ENUM_MA_METHOD ma3_method = MODE_SMA;                                       // Moving Average Method
input ENUM_APPLIED_PRICE ma3_price = PRICE_CLOSE;                                 // Moving Average Applied Price
input group "MA Indicator #4" input string ma4_label = "MA #4";                   // MA4 Label
input ENUM_ON_OFF ma4_active = OFF;                                               // On Off Moving Averaging
input ENUM_MA_SIGNAL_TYPE ma4_type = ENUM_MA_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES ma4_timeframe = PERIOD_H4;                                  // Moving Average TimeFrame
input int ma4_periode = 14;                                                       // Moving Average Period Line
input int ma4_shift = 0;                                                          // Moving Average Shift
input ENUM_MA_METHOD ma4_method = MODE_SMA;                                       // Moving Average Method
input ENUM_APPLIED_PRICE ma4_price = PRICE_CLOSE;                                 // Moving Average Applied Price ​
input group "MA Indicator #5" input string ma5_label = "MA #5";                   // MA5 Label
input ENUM_ON_OFF ma5_active = OFF;                                               // On Off Moving Averaging
input ENUM_MA_SIGNAL_TYPE ma5_type = ENUM_MA_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES ma5_timeframe = PERIOD_D1;                                  // Moving Average TimeFrame
input int ma5_periode = 14;                                                       // Moving Average Period Line
input int ma5_shift = 0;                                                          // Moving Average Shift
input ENUM_MA_METHOD ma5_method = MODE_SMA;                                       // Moving Average Method
input ENUM_APPLIED_PRICE ma5_price = PRICE_CLOSE;                                 // Moving Average Applied Price
input group "MA Indicator #6" input string ma6_label = "MA #6";                   // MA6 Label
input ENUM_ON_OFF ma6_active = OFF;                                               // On Off Moving Averaging
input ENUM_MA_SIGNAL_TYPE ma6_type = ENUM_MA_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES ma6_timeframe = PERIOD_D1;                                  // Moving Average TimeFrame
input int ma6_periode = 14;                                                       // Moving Average Period Line
input int ma6_shift = 0;                                                          // Moving Average Shift
input ENUM_MA_METHOD ma6_method = MODE_SMA;                                       // Moving Average Method
input ENUM_APPLIED_PRICE ma6_price = PRICE_CLOSE;                                 // Moving Average Applied Price
                                                                                  // ​
input group "BB Indicator #1" input string bb1_label = "BB #1";                   // BB1 Label
input ENUM_ON_OFF bb1_active = OFF;                                               // On Off Bolingger Bands
input ENUM_BB_SIGNAL_TYPE bb1_type = ENUM_BB_SIGNAL_TYPE::UP_DOWN;                // signal Type
input ENUM_TIMEFRAMES bb1_timeframe = PERIOD_M5;                                  // Bolingger Bands TimeFrame
input int bb1_periode = 14;                                                       // Bolingger Bands Period
input int bb1_shift = 0;                                                          // Bolingger Bands Shift
input double bb1_deviation = 2.0;                                                 // Bolingger Bands Deviation
input ENUM_APPLIED_PRICE bb1_price = PRICE_CLOSE;                                 // Bolingger Bands Applied Price
input group "BB Indicator #2" input string bb2_label = "BB #2";                   // BB2 Label
input ENUM_ON_OFF bb2_active = OFF;                                               // On Off Bolingger Bands
input ENUM_BB_SIGNAL_TYPE bb2_type = ENUM_BB_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES bb2_timeframe = PERIOD_M15;                                 // Bolingger Bands TimeFrame
input int bb2_periode = 14;                                                       // Bolingger Bands Period Line
input int bb2_shift = 0;                                                          // Bolingger Bands Shift
input double bb2_deviation = 2.0;                                                 // Bolingger Bands Deviation
input ENUM_APPLIED_PRICE bb2_price = PRICE_CLOSE;                                 // Bolingger Bands Applied Price
input group "BB Indicator #3" input string bb3_label = "BB #3";                   // BB3 Label
input ENUM_ON_OFF bb3_active = OFF;                                               // On Off Bolingger Bands
input ENUM_BB_SIGNAL_TYPE bb3_type = ENUM_BB_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES bb3_timeframe = PERIOD_H1;                                  // Bolingger Bands TimeFrame
input int bb3_periode = 14;                                                       // Bolingger Bands Period Line
input int bb3_shift = 0;                                                          // Bolingger Bands Shift
input double bb3_deviation = 2.0;                                                 // Bolingger Bands Deviation
input ENUM_APPLIED_PRICE bb3_price = PRICE_CLOSE;                                 // Bolingger Bands Applied Price ​
input group "BB Indicator #4" input string bb4_label = "BB #4";                   // BB4 Label
input ENUM_ON_OFF bb4_active = OFF;                                               // On Off Bolingger Bands
input ENUM_BB_SIGNAL_TYPE bb4_type = ENUM_BB_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES bb4_timeframe = PERIOD_H4;                                  // Bolingger Bands TimeFrame
input int bb4_periode = 14;                                                       // Bolingger Bands Period Line
input int bb4_shift = 0;                                                          // Bolingger Bands Shift
input double bb4_deviation = 2.0;                                                 // Bolingger Bands Deviation
input ENUM_APPLIED_PRICE bb4_price = PRICE_CLOSE;                                 // Bolingger Bands Applied Price
input group "BB Indicator #5" input string bb5_label = "BB #5";                   // BB5 Label
input ENUM_ON_OFF bb5_active = OFF;                                               // On Off Bolingger Bands
input ENUM_BB_SIGNAL_TYPE bb5_type = ENUM_BB_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES bb5_timeframe = PERIOD_D1;                                  // Bolingger Bands TimeFrame
input int bb5_periode = 14;                                                       // Bolingger Bands Period Line
input int bb5_shift = 0;                                                          // Bolingger Bands Shift
input double bb5_deviation = 2.0;                                                 // Bolingger Bands Deviation
input ENUM_APPLIED_PRICE bb5_price = PRICE_CLOSE;                                 // Bolingger Bands Applied Price
input group "BB Indicator #6" input string bb6_label = "BB #6";                   // BB6 Label
input ENUM_ON_OFF bb6_active = OFF;                                               // On Off Bolingger Bands
input ENUM_BB_SIGNAL_TYPE bb6_type = ENUM_BB_SIGNAL_TYPE::UP_DOWN;                // Signal Type
input ENUM_TIMEFRAMES bb6_timeframe = PERIOD_D1;                                  // Bolingger Bands TimeFrame
input int bb6_periode = 14;                                                       // Bolingger Bands Period Line
input int bb6_shift = 0;                                                          // Bolingger Bands Shift
input double bb6_deviation = 2.0;                                                 // Bolingger Bands Deviation
input ENUM_APPLIED_PRICE bb6_price = PRICE_CLOSE;

//+------------------------- Symbol Handle -----------------------------------------+
