#ifndef DATA_MQH
#define DATA_MQH
enum ENUM_CLOSE_ALL_TRIGGER
{
    CLOSE_SYMBOL_BUY_SELL, // Close All Symbol Order Current (Point / Dollar)
    CLOSE_ALL_SYMBOL_BUY,  // Close All Symbol Buy (Point / Dollar)
    CLOSE_ALL_SYMBOL_SELL, // Close All Symbol Sell (Point / Dollar)
    CLOSE_ALL_SYMBOL,      // Close All Symbol (Dollar)
    CLOSE_ALL,             // Close All Position (Dollar)
    CLOSE_ALL_BUY,         // Close All Position Buy (Dollar)
    CLOSE_ALL_SELL,        // Close All Position Sell (Dollar)
    DISABLE,               // Disable
};
// Enum untuk tipe trigger
enum ENUM_TRIGGER_TYPE
{
    TRIGGER_POINTS, // Close by Points Symbol Only
    TRIGGER_DOLLARS // Close by Dollars
};

enum ENUM_MODE_SIGNAL
{
    MODE_SIGNAL_MANUAL, // Mode Signal Manual
    // MODE_SIGNAL_AUTO,   // Mode Signal Auto
    MODE_SIGNAL_MULTI, // Mode Multi Indikator
    DISABLE,           // Disable
};

enum ENUM_SIGNAL_MANUAL_TYPE
{
    UP_DOWN,              // Up And Down
    UP_DOWN_REVERSE,      // Up And Down Reverse
    CROSS_FOLLOW,         // Cross Follow Trend
    CROSS_FOLLOW_REVERSE, // Cross Follow Trend Reverse

};

enum ENUM_INDICATOR_TYPE
{
    IND_BOLLINGER_BANDS, // Bollinger Bands
    IND_MOVING_AVERAGE,  // Moving Average
    IND_RSI,             // Relative Strength Index
};

enum ENUM_SIGNAL_AUTO
{
    SIGNAL_1, // Reversal BB + RSI
    SIGNAL_2, // MA Cross + RSI
    SIGNAL_3, // BB + MACD + RSI
    SIGNAL_4, // MA + Stochastic
    SIGNAL_5, // BB Squeeze + Momentum
    SIGNAL_6, // Triple MA Cross
    DISABLE,  // Disable
};

enum ENUM_DAY_INDO
{
    Minggu,
    Senin,
    Selasa,
    Rabu,
    Kamis,
    Jumat,
    Sabtu,
    Disable

};
enum ENUM_SYMBOL_BASE
{
    USD, // USD
    GBP, // GBP
    EUR, // EUR
    JPY, // JPY
    CAD, // CAD
    CHF, // CHF
    AUD, // AUD
    NZD  // NZD

};

enum ENUM_TRADING_DIRECTION
{
    BUY,       // Buy
    SELL,      // Sell
    ONE_SIDE,  // One Side
    BOOTH_SIDE // Booth Side
};
enum ENUM_BASE_DIRECTION
{
    BUY,     // Buy Base
    SELL,    // Sell Base
    ALL_BUY, // All Buy (ex: xxxUSD Or USDxxx = Buy)
    ALL_SELL // All Sell (ex: xxxGBP Or GBPxxx = Sell)
};

enum ENUM_LOT_TYPE
{
    LOT_FIXED,   // Lot Fixed
    LOT_BALANCE, // Lot Balance Accumulation
    LOT_EQUITY,  // Lot Equity Accumulation
    LOT_RISK     // Lot Risk Percent
};
enum ENUM_LOT_MODE
{
    GRID_LOT_FIXED,    // Grid Lot Fixed
    GRID_LOT_MULTIPLY, // Grid Lot Multiply
    GRID_LOT_ADD,      // Grid Lot Add
    GRID_LOT_CUSTOM,   // Grid Lot Custom
    GRID_DISABLE       // Disable
};

enum ENUM_GRID_DIRECTION
{
    GRID_BUY_ONLY,   // Buy Only
    GRID_SELL_ONLY,  // Sell Only
    GRID_AUTO_FOLLOW // Auto Follow First Position
};

enum ENUM_ONE_ORDER_TYPE
{
    ONE_ORDER_PER_SYMBOL,                        // One Order Per Symbol (Magic Number)
    ONE_ORDER_TOTAL_POSITION,                    // One Order Total Position (Magic Number)
    ONE_ORDER_PER_TIMEFRAME_SYMBOL_MAGIC_NUMBER, // One Order Per Timeframe Symbol (Magic Number)
    ORDER_MAX_CUSTOM,                            // Order Max Custom
    ORDER_MODE_GRID_PROFIT,                      // Order Mode Grid Profit
    ORDER_MODE_GRID_LOSS,                        // Order Mode Grid Loss

};
enum ENUM_SYMBOL_TYPE
{
    SYMBOL_ALL,     // All available symbols
    SYMBOL_BASE,    // Mode Base Symbol
    SYMBOL_CURRENT, // Current chart symbol
    SYMBOL_CUSTOM,  // Custom symbol list
};

// enum ENUM_SYMBOL_TYPE
// {
//     MULTI_SYMBOL,   // Multi Symbol Market Watch
//     SYMBOL_CURRENT, // Current Symbol
//     SYMBOL_BASE,    // Mode Base Symbol
//     SYMBOL_CUSTOM,  // Custom Symbol 1
//     SYMBOL_CUSTOM1, // Custom Symbol 2
//     SYMBOL_CUSTOM2, // Custom Symbol 3
//     SYMBOL_CUSTOM3  // Custom Symbol 4
// };
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
enum ENUM_STRATEGY_COMBINATION
{
    AND, // -- AND --
    OR   // -- OR --
};
// === ENUM MA ===

enum ENUM_SIGNAL_TYPE

{
    CROSS,          // Cross
    UP_DOWN,        // Up And Down
    UP_DOWN_REVERSE // Up And Down Reverse
};

enum ENUM_BB_SIGNAL_TYPE
{
    CROSS_UP_DOWN,         // Cross Up And Down Follow Trend
    UP_DOWN,               // Up And Down Follow Trend
    CROSS_UP_DOWN_REVERSE, // Cross Up And Down Reverse
    UP_DOWN_REVERSE        // Up And Down Reverse

};

enum ENUM_MA_SIGNAL_INDIKATOR1
{
    MA_MOVING_AVERAGE, // Moving Average
    MA_CURRENT_PRICE   // Current Price
};
enum ENUM_MA_SIGNAL_INDIKATOR2
{
    MA_MOVING_AVERAGE // Moving Average
};

// ================== ENUM BB ==================

#endif