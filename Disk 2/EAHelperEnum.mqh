#property strict

/**
 * Enum untuk status On/Off
 */
enum ENUM_ON_OFF
{
    ON, // On
    OFF // Off
};

/**
 * Enum untuk status Active/Disable
 */
enum ENUM_ACTIVE_DISABLE
{
    ACTIVE, // Active
    DISABLE // Disable
};

/**
 * Enum untuk kombinasi strategi
 */
enum ENUM_STRATEGY_COMBINATION
{
    AND, // -- AND --
    OR   // -- OR --
};

/**
 * Enum untuk status Enable/Disable
 */
enum ENUM_ENABLE_DISABLE
{
    ENABLE, // Enable
    DISABLE // Disable
};

/**
 * Enum untuk arah trend
 */
enum ENUM_TREND_DIRECTION
{
    UP,   // Up Trend
    DOWN, // Down Trend
    RANGE // Sideways/Range
};

/**
 * Enum untuk tipe order
 */
enum ENUM_ORDER_TYPE_CUSTOM
{
    MARKET, // Market Order
    LIMIT,  // Limit Order
    STOP    // Stop Order
};

/**
 * Enum untuk status signal
 */
enum ENUM_SIGNAL_STATUS
{
    BUY,    // Buy Signal
    SELL,   // Sell Signal
    NEUTRAL // No Signal
};

/**
 * Enum untuk mode trading
 */
enum ENUM_TRADING_MODE
{
    AUTO,  // Automatic Trading
    MANUAL // Manual Trading
};

/**
 * Enum untuk status posisi
 */
enum ENUM_POSITION_STATUS
{
    OPEN,   // Position Open
    CLOSED, // Position Closed
    PENDING // Pending Order
};

/**
 * Enum untuk tipe indikator
 */
enum ENUM_INDICATOR_TYPE
{
    TREND,      // Trend Indicator
    OSCILLATOR, // Oscillator Indicator
    VOLUME      // Volume Indicator
};

/**
 * Enum untuk timeframe custom
 */
enum ENUM_CUSTOM_TIMEFRAME
{
    M1,  // 1 Minute
    M5,  // 5 Minutes
    M15, // 15 Minutes
    M30, // 30 Minutes
    H1,  // 1 Hour
    H4,  // 4 Hours
    D1   // 1 Day
};

/**
 * Enum untuk tipe akun
 */
enum ENUM_ACCOUNT_TYPE
{
    DEMO,   // Demo Account
    REAL,   // Real Account
    CONTEST // Contest Account
};

/**
 * Enum untuk status order
 */
enum ENUM_ORDER_STATUS
{
    OPENED,   // Order Opened
    CLOSED,   // Order Closed
    CANCELED, // Order Canceled
    EXPIRED   // Order Expired
};

/**
 * Enum untuk tipe eksekusi
 */
enum ENUM_EXECUTION_TYPE
{
    INSTANT, // Instant Execution
    REQUEST, // Request Execution
    MARKET   // Market Execution
};

/**
 * Enum untuk tipe margin
 */
enum ENUM_MARGIN_TYPE
{
    NETTING, // Netting Margin
    HEDGING  // Hedging Margin
};

/**
 * Enum untuk tipe stop
 */
enum ENUM_STOP_TYPE
{
    STOP_LOSS,  // Stop Loss
    TAKE_PROFIT // Take Profit
};

/**
 * Enum untuk tipe trailing
 */
enum ENUM_TRAILING_TYPE
{
    FIXED,     // Fixed Trailing
    PERCENTAGE // Percentage Trailing
};

/**
 * Enum untuk tipe risk management
 */
enum ENUM_RISK_TYPE
{
    FIXED_LOT,    // Fixed Lot Size
    PERCENT_RISK, // Percentage Risk
    MONEY_RISK    // Money Risk
};

/**
 * Enum untuk tipe money management
 */
enum ENUM_MONEY_MANAGEMENT
{
    MARTINGALE,      // Martingale
    ANTI_MARTINGALE, // Anti-Martingale
    FIXED_RATIO      // Fixed Ratio
};
