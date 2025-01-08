
// ================== ENUM GENERAL ==================
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
enum ENUM_GRID_DIRECTION
{
    GRID_ALL,        // Buy dan Sell
    GRID_BUY_ONLY,   // Buy Only
    GRID_SELL_ONLY,  // Sell Only
    GRID_AUTO_FOLLOW // Auto Follow First Position
};

enum ENUM_ONE_ORDER_TYPE
{
    ONE_ORDER_PER_SYMBOL,                         // One Order Per Symbol
    ONE_ORDER_TOTAL_POSITION,                     // One Order Total Position
    ONE_ORDER_MAGIC_NUMBER_SYMBOL,                // One Order Magic Number Symbol
    ONE_ORDER_MAGIC_NUMBER_SYMBOL_TOTAL_POSITION, // One Order Magic Number Total Position
    ONE_ORDER_PER_TIMEFRAME_SYMBOL_MAGIC_NUMBER,  // One Order Per Timeframe Symbol (Magic Number)
    ORDER_MAX_CUSTOM,                             // Order Max Custom
    ORDER_MODE_GRID_PROFIT,                       // Order Mode Grid Profit
    ORDER_MODE_GRID_LOSS,                         // Order Mode Grid Loss
    DISABLE                                       // Disable
};
enum ENUM_SYMBOL_TYPE
{
    MULTI_SYMBOL,   // Multi Symbol Market Watch
    SYMBOL_CURRENT, // Current Symbo
    SYMBOL_CUSTOM   // Custom Symbol
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
enum ENUM_STRATEGY_COMBINATION
{
    AND, // -- AND --
    OR   // -- OR --
};
// === ENUM MA ===

enum ENUM_SIGNAL_TYPE

{
    CROSS,   // Cross
    UP_DOWN, // Up And Down
    UP_DOWN_REVERSE
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
