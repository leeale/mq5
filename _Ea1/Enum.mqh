//+------------------------- Symbol Handle -----------------------------------------+
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
}