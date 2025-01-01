#ifndef Example_mqh
#define Example_mqh

#include "Example1.mqh"

enum ENUM_CALENDAR_EVENT_FREQUENCY
{
    CALENDAR_FREQUENCY_NONE,    // Release frequency is not set
    CALENDAR_FREQUENCY_WEEK,    // Released once a week
    CALENDAR_FREQUENCY_MONTH,   // Released once a month
    CALENDAR_FREQUENCY_QUARTER, // Released once a quarter
    CALENDAR_FREQUENCY_YEAR,    // Released once a year
    CALENDAR_FREQUENCY_DAY      // Released once a day
};

enum ENUM_CALENDAR_EVENT_TYPE
{
    CALENDAR_TYPE_EVENT,     // Event (meeting, speech, etc.)
    CALENDAR_TYPE_INDICATOR, // Indicator
    CALENDAR_TYPE_HOLIDAY    // Holiday
};

enum ENUM_CALENDAR_EVENT_SECTOR
{
    CALENDAR_SECTOR_NONE,       // Sector is not set
    CALENDAR_SECTOR_MARKET,     // Market, exchange
    CALENDAR_SECTOR_GDP,        // Gross Domestic Product (GDP)
    CALENDAR_SECTOR_JOBS,       // Labor market
    CALENDAR_SECTOR_PRICES,     // Prices
    CALENDAR_SECTOR_MONEY,      // Money
    CALENDAR_SECTOR_TRADE,      // Trading
    CALENDAR_SECTOR_GOVERNMENT, // Government
    CALENDAR_SECTOR_BUSINESS,   // Business
    CALENDAR_SECTOR_CONSUMER,   // Consumption
    CALENDAR_SECTOR_HOUSING,    // Housing
    CALENDAR_SECTOR_TAXES,      // Taxes
    CALENDAR_SECTOR_HOLIDAYS    // Holidays
};

enum ENUM_CALENDAR_EVENT_IMPORTANCE
{
    CALENDAR_IMPORTANCE_NONE,     // Importance is not set
    CALENDAR_IMPORTANCE_LOW,      // Low importance
    CALENDAR_IMPORTANCE_MODERATE, // Medium importance
    CALENDAR_IMPORTANCE_HIGH      // High importance
};

enum ENUM_CALENDAR_EVENT_UNIT
{
    CALENDAR_UNIT_NONE,      // Measurement unit is not set
    CALENDAR_UNIT_PERCENT,   // Percentage
    CALENDAR_UNIT_CURRENCY,  // National currency
    CALENDAR_UNIT_HOUR,      // Hours
    CALENDAR_UNIT_JOB,       // Jobs
    CALENDAR_UNIT_RIG,       // Drilling rigs
    CALENDAR_UNIT_USD,       // USD
    CALENDAR_UNIT_PEOPLE,    // People
    CALENDAR_UNIT_MORTGAGE,  // Mortgage loans
    CALENDAR_UNIT_VOTE,      // Votes
    CALENDAR_UNIT_BARREL,    // Barrels
    CALENDAR_UNIT_CUBICFEET, // Cubic feet
    CALENDAR_UNIT_POSITION,  // Non-commercial net positions
    CALENDAR_UNIT_BUILDING   // Buildings
};

enum ENUM_CALENDAR_EVENT_MULTIPLIER
{
    CALENDAR_MULTIPLIER_NONE,      // Multiplier is not set
    CALENDAR_MULTIPLIER_THOUSANDS, // Thousands
    CALENDAR_MULTIPLIER_MILLIONS,  // Millions
    CALENDAR_MULTIPLIER_BILLIONS,  // Billions
    CALENDAR_MULTIPLIER_TRILLIONS  // Trillions
};

enum ENUM_CALENDAR_EVENT_IMPACT
{
    CALENDAR_IMPACT_NA,       // Impact is not set
    CALENDAR_IMPACT_POSITIVE, // Positive impact
    CALENDAR_IMPACT_NEGATIVE  // Negative impact
};

enum ENUM_CALENDAR_EVENT_TIMEMODE
{
    CALENDAR_TIMEMODE_DATETIME, // Source publishes an exact time of an event
    CALENDAR_TIMEMODE_DATE,     // Event takes all day
    CALENDAR_TIMEMODE_NOTIME,   // Source publishes no time of an event
    CALENDAR_TIMEMODE_TENTATIVE // Source publishes a day of an event rather than its exact time. The time is specified upon the occurrence of the event.
};

enum ENUM_CHART_POSITION
{
    CHART_BEGIN,       // Chart beginning (the oldest prices)
    CHART_CURRENT_POS, // Current position
    CHART_END          // Chart end (the latest prices)
};

enum ENUM_ACCOUNT_INFO_INTEGER
{
    ACCOUNT_LOGIN,           // Account number
    ACCOUNT_TRADE_MODE,      // Account trade mode
    ACCOUNT_LEVERAGE,        // Account leverage
    ACCOUNT_LIMIT_ORDERS,    // Maximum allowed number of active pending orders
    ACCOUNT_MARGIN_SO_MODE,  // Mode for setting the minimal allowed margin
    ACCOUNT_TRADE_ALLOWED,   // Allowed trade for the current account
    ACCOUNT_TRADE_EXPERT,    // Allowed trade for an Expert Advisor
    ACCOUNT_MARGIN_MODE,     // Margin calculation mode
    ACCOUNT_CURRENCY_DIGITS, // The number of decimal places in the account currency, which are required for an accurate display of trading results
    ACCOUNT_FIFO_CLOSE       // An indication showing that positions can only be closed by FIFO rule. If the property value is set to true, then each symbol positions will be closed in the same order, in which they are opened, starting with the oldest one. In case of an attempt to close positions in a different order, the trader will receive an appropriate error.
};

enum ENUM_ACCOUNT_INFO_DOUBLE
{
    ACCOUNT_BALANCE,            // Account balance in the deposit currency
    ACCOUNT_CREDIT,             // Account credit in the deposit currency
    ACCOUNT_PROFIT,             // Current profit of an account in the deposit currency
    ACCOUNT_EQUITY,             // Account equity in the deposit currency
    ACCOUNT_MARGIN,             // Account margin used in the deposit currency
    ACCOUNT_MARGIN_FREE,        // Free margin of an account in the deposit currency
    ACCOUNT_MARGIN_LEVEL,       // Account margin level in percents
    ACCOUNT_MARGIN_SO_CALL,     // Margin call level. Depending on the set ACCOUNT_MARGIN_SO_MODE is expressed in percents or in the deposit currency
    ACCOUNT_MARGIN_SO_SO,       // Margin stop out level. Depending on the set ACCOUNT_MARGIN_SO_MODE is expressed in percents or in the deposit currency
    ACCOUNT_MARGIN_INITIAL,     // Initial margin. The amount reserved on an account to cover the margin of all pending orders
    ACCOUNT_MARGIN_MAINTENANCE, // Maintenance margin. The minimum equity reserved on an account to cover the minimum amount of all open positions
    ACCOUNT_ASSETS,             // The current assets of an account
    ACCOUNT_LIABILITIES,        // The current liabilities on an account
    ACCOUNT_COMMISSION_BLOCKED  // The current blocked commission amount on an account
};

enum ENUM_ACCOUNT_INFO_STRING
{
    ACCOUNT_NAME,     // Client name
    ACCOUNT_SERVER,   // Trade server name
    ACCOUNT_CURRENCY, // Account currency
    ACCOUNT_COMPANY   // Name of a company that serves the account
};

enum ENUM_ACCOUNT_TRADE_MODE
{
    ACCOUNT_TRADE_MODE_DEMO,    // Demo account
    ACCOUNT_TRADE_MODE_CONTEST, // Contest account
    ACCOUNT_TRADE_MODE_REAL     // Real account
};

enum ENUM_ACCOUNT_STOPOUT_MODE
{
    ACCOUNT_STOPOUT_MODE_PERCENT, // Account stop out mode in percents
    ACCOUNT_STOPOUT_MODE_MONEY    // Account stop out mode in money
};

enum ENUM_ACCOUNT_MARGIN_MODE
{
    ACCOUNT_MARGIN_MODE_RETAIL_NETTING, // Used for the OTC markets to interpret positions in the "netting" mode (only one position can exist for one symbol). The margin is calculated based on the symbol type (SYMBOL_TRADE_CALC_MODE).
    ACCOUNT_MARGIN_MODE_EXCHANGE,       // Used for the exchange markets. Margin is calculated based on the discounts specified in symbol settings. Discounts are set by the broker, but not less than the values set by the exchange.
    ACCOUNT_MARGIN_MODE_RETAIL_HEDGING  // Used for the exchange markets where individual positions are possible (hedging, multiple positions can exist for one symbol). The margin is calculated based on the symbol type (SYMBOL_TRADE_CALC_MODE) taking into account the hedged margin (SYMBOL_MARGIN_HEDGED).
};

enum ENUM_TIMEFRAMES
{
    PERIOD_CURRENT, // Current timeframe
    PERIOD_M1,      // 1 minute
    PERIOD_M2,      // 2 minutes
    PERIOD_M3,      // 3 minutes
    PERIOD_M4,      // 4 minutes
    PERIOD_M5,      // 5 minutes
    PERIOD_M6,      // 6 minutes
    PERIOD_M10,     // 10 minutes
    PERIOD_M12,     // 12 minutes
    PERIOD_M15,     // 15 minutes
    PERIOD_M20,     // 20 minutes
    PERIOD_M30,     // 30 minutes
    PERIOD_H1,      // 1 hour
    PERIOD_H2,      // 2 hours
    PERIOD_H3,      // 3 hours
    PERIOD_H4,      // 4 hours
    PERIOD_H6,      // 6 hours
    PERIOD_H8,      // 8 hours
    PERIOD_H12,     // 12 hours
    PERIOD_D1,      // 1 day
    PERIOD_W1,      // 1 week
    PERIOD_MN1      // 1 month
};

enum ENUM_POINTER_TYPE
{
    POINTER_INVALID,  // Incorrect pointer
    POINTER_DYNAMIC,  // Pointer of the object created by the new() operator
    POINTER_AUTOMATIC // Pointer of any objects created automatically (not using new())
};

enum ENUM_OBJECT_PROPERTY_INTEGER
{
    OBJPROP_COLOR,       // Color
    OBJPROP_STYLE,       // Style
    OBJPROP_WIDTH,       // Line thickness
    OBJPROP_BACK,        // Object in the background
    OBJPROP_ZORDER,      // Priority of a graphical object for receiving events of clicking on a chart (CHARTEVENT_CLICK). The default zero value is set when creating an object; the priority can be increased if necessary. When objects are placed one atop another, only one of them with the highest priority will receive the CHARTEVENT_CLICK event.
    OBJPROP_FILL,        // Fill an object with color (for OBJ_RECTANGLE, OBJ_TRIANGLE, OBJ_ELLIPSE, OBJ_CHANNEL, OBJ_STDDEVCHANNEL, OBJ_REGRESSION)
    OBJPROP_HIDDEN,      // Prohibit showing of the name of a graphical object in the list of objects from the terminal menu "Charts" - "Objects" - "List of objects". The true value allows to hide an object from the list. By default, true is set to the objects that display calendar events, trading history and to the objects created from MQL5 programs. To see such graphical objects and access their properties, click on the "All" button in the "List of objects" window.
    OBJPROP_SELECTED,    // Object is selected
    OBJPROP_READONLY,    // Ability to edit text in the Edit object
    OBJPROP_TYPE,        // Object type
    OBJPROP_TIME,        // Time coordinate
    OBJPROP_SELECTABLE,  // Object availability
    OBJPROP_CREATETIME,  // Time of object creation
    OBJPROP_LEVELS,      // Number of levels
    OBJPROP_LEVELCOLOR,  // Color of the line-level
    OBJPROP_LEVELSTYLE,  // Style of the line-level
    OBJPROP_LEVELWIDTH,  // Thickness of the line-level
    OBJPROP_ALIGN,       // Horizontal text alignment in the "Edit" object (OBJ_EDIT)
    OBJPROP_FONTSIZE,    // Font size
    OBJPROP_RAY_LEFT,    // Ray goes to the left
    OBJPROP_RAY_RIGHT,   // Ray goes to the right
    OBJPROP_RAY,         // A vertical line goes through all the windows of a chart
    OBJPROP_ELLIPSE,     // Showing the full ellipse of the Fibonacci Arc object (OBJ_FIBOARC)
    OBJPROP_ARROWCODE,   // Arrow code for the Arrow object
    OBJPROP_TIMEFRAMES,  // Visibility of an object at timeframes
    OBJPROP_ANCHOR,      // Location of the anchor point of a graphical object
    OBJPROP_XDISTANCE,   // The distance in pixels along the X axis from the binding corner (see note)
    OBJPROP_YDISTANCE,   // The distance in pixels along the Y axis from the binding corner (see note)
    OBJPROP_DIRECTION,   // Trend of the Gann object
    OBJPROP_DEGREE,      // Level of the Elliott Wave Marking
    OBJPROP_DRAWLINES,   // Displaying lines for marking the Elliott Wave
    OBJPROP_STATE,       // Button state (pressed / depressed)
    OBJPROP_CHART_ID,    // ID of the "Chart" object (OBJ_CHART). It allows working with the properties of this object like with a normal chart using the functions described in Chart Operations, but there some exceptions.
    OBJPROP_XSIZE,       // The object's width along the X axis in pixels. Specified for  OBJ_LABEL (read only), OBJ_BUTTON, OBJ_CHART, OBJ_BITMAP, OBJ_BITMAP_LABEL, OBJ_EDIT, OBJ_RECTANGLE_LABEL objects.
    OBJPROP_YSIZE,       // The object's height along the Y axis in pixels. Specified for  OBJ_LABEL (read only), OBJ_BUTTON, OBJ_CHART, OBJ_BITMAP, OBJ_BITMAP_LABEL, OBJ_EDIT, OBJ_RECTANGLE_LABEL objects.
    OBJPROP_XOFFSET,     // The X coordinate of the upper left corner of the rectangular visible area in the graphical objects "Bitmap Label" and "Bitmap" (OBJ_BITMAP_LABEL and OBJ_BITMAP). The value is set in pixels relative to the upper left corner of the original image.
    OBJPROP_YOFFSET,     // The Y coordinate of the upper left corner of the rectangular visible area in the graphical objects "Bitmap Label" and "Bitmap" (OBJ_BITMAP_LABEL and OBJ_BITMAP). The value is set in pixels relative to the upper left corner of the original image.
    OBJPROP_PERIOD,      // Timeframe for the Chart object
    OBJPROP_DATE_SCALE,  // Displaying the time scale for the Chart object
    OBJPROP_PRICE_SCALE, // Displaying the price scale for the Chart object
    OBJPROP_CHART_SCALE, // The scale for the Chart object
    OBJPROP_BGCOLOR,     // The background color for  OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
    OBJPROP_CORNER,      // The corner of the chart to link a graphical object
    OBJPROP_BORDER_TYPE, // Border type for the "Rectangle label" object
    OBJPROP_BORDER_COLOR // Border color for the OBJ_EDIT and OBJ_BUTTON objects
};

enum ENUM_OBJECT_PROPERTY_DOUBLE
{
    OBJPROP_PRICE,      // Price coordinate
    OBJPROP_LEVELVALUE, // Level value
    OBJPROP_SCALE,      // Scale (properties of Gann objects and Fibonacci Arcs)
    OBJPROP_ANGLE,      // Angle.  For the objects with no angle specified, created from a program, the value is equal to EMPTY_VALUE
    OBJPROP_DEVIATION   // Deviation for the Standard Deviation Channel
};

enum ENUM_OBJECT_PROPERTY_STRING
{
    OBJPROP_NAME,      // Object name
    OBJPROP_TEXT,      // Description of the object (the text contained in the object)
    OBJPROP_TOOLTIP,   // The text of a tooltip. If the property is not set, then the tooltip generated automatically by the terminal is shown. A tooltip can be disabled by setting the "\n" (line feed) value to it
    OBJPROP_LEVELTEXT, // Level description
    OBJPROP_FONT,      // Font
    OBJPROP_BMPFILE,   // The name of BMP-file for Bitmap Label. See also Resources
    OBJPROP_SYMBOL     // Symbol for the Chart object
};

enum ENUM_BORDER_TYPE
{
    BORDER_FLAT,   // Flat form
    BORDER_RAISED, // Prominent form
    BORDER_SUNKEN  // Concave form
};

enum ENUM_ALIGN_MODE
{
    ALIGN_LEFT,   // Left alignment
    ALIGN_CENTER, // Centered (only for the Edit object)
    ALIGN_RIGHT   // Right alignment
};

enum ENUM_OPENCL_PROPERTY_INTEGER
{
    CL_DEVICE_COUNT,               // The number of devices with OpenCL support. This property does not require specification of the first parameter, i.e. you can pass a zero value for the handle parameter.
    CL_DEVICE_TYPE,                // Type of device
    CL_DEVICE_VENDOR_ID,           // Unique vendor identifier
    CL_DEVICE_MAX_COMPUTE_UNITS,   // Number of parallel calculated tasks in OpenCL device. One working group solves one computational task. The lowest value is 1
    CL_DEVICE_MAX_CLOCK_FREQUENCY, // Highest set frequency of the device in MHz.
    CL_DEVICE_GLOBAL_MEM_SIZE,     // Size of the global memory of the device in bytes
    CL_DEVICE_LOCAL_MEM_SIZE,      // Size of the processed data (scene) local memory in bytes
    CL_BUFFER_SIZE,                // Actual size of the OpenCL buffer in bytes
    CL_DEVICE_MAX_WORK_GROUP_SIZE, // The total number of the local working groups available for an OpenCL device.
    CL_KERNEL_WORK_GROUP_SIZE,     // The total number of the local working groups available for an OpenCL program.
    CL_KERNEL_LOCAL_MEM_SIZE,      // Size of the local memory (in bytes) used by an OpenCL program for solving all parallel tasks in a group. Use CL_DEVICE_LOCAL_MEM_SIZE to receive the maximum available value
    CL_KERNEL_PRIVATE_MEM_SIZE     // The minimum size of the private memory (in bytes) used by each task in the OpenCL program kernel.
};

enum ENUM_CL_DEVICE_TYPE
{
    CL_DEVICE_ACCELERATOR, // Dedicated OpenCL accelerators (for example, the IBM CELL Blade). These devices communicate with the host processor using a peripheral interconnect such as PCIe.
    CL_DEVICE_CPU,         // An OpenCL device that is the host processor. The host processor runs the OpenCL implementations and is a single or multi-core CPU.
    CL_DEVICE_GPU,         // An OpenCL device that is a GPU.
    CL_DEVICE_DEFAULT,     // The default OpenCL device in the system. The default device cannot be a CL_DEVICE_TYPE_CUSTOM device.
    CL_DEVICE_CUSTOM       // Dedicated accelerators that do not support programs written in OpenCL C.
};

enum ENUM_OPENCL_HANDLE_TYPE
{
    OPENCL_INVALID, // Incorrect handle
    OPENCL_CONTEXT, // A handle of the OpenCL context
    OPENCL_PROGRAM, // A handle of the OpenCL program
    OPENCL_KERNEL,  // A handle of the OpenCL kernel
    OPENCL_BUFFER   // A handle of the OpenCL buffer
};

enum ENUM_CRYPT_METHOD
{
    CRYPT_BASE64,      // BASE64
    CRYPT_AES128,      // AES encryption with 128 bit key (16 bytes)
    CRYPT_AES256,      // AES encryption with 256 bit key (32 bytes)
    CRYPT_DES,         // DES encryption with 56 bit key (7 bytes)
    CRYPT_HASH_SHA1,   // SHA1 HASH calculation
    CRYPT_HASH_SHA256, // SHA256 HASH calculation
    CRYPT_HASH_MD5,    // MD5 HASH calculation
    CRYPT_ARCH_ZIP     // ZIP archives
};

enum ENUM_SYMBOL_INFO_INTEGER
{
    SYMBOL_SECTOR,                // The sector of the economy to which the asset belongs
    SYMBOL_INDUSTRY,              // The industry or the economy branch to which the symbol belongs
    SYMBOL_CUSTOM,                // It is a custom symbol – the symbol has been created synthetically based on other symbols from the Market Watch and/or external data sources
    SYMBOL_BACKGROUND_COLOR,      // The color of the background used for the symbol in Market Watch
    SYMBOL_CHART_MODE,            // The price type used for generating symbols bars, i.e. Bid or Last
    SYMBOL_EXIST,                 // Symbol with this name exists
    SYMBOL_SELECT,                // Symbol is selected in Market Watch
    SYMBOL_VISIBLE,               // Symbol is visible in Market Watch.
    SYMBOL_SESSION_DEALS,         // Number of deals in the current session
    SYMBOL_SESSION_BUY_ORDERS,    // Number of Buy orders at the moment
    SYMBOL_SESSION_SELL_ORDERS,   // Number of Sell orders at the moment
    SYMBOL_VOLUME,                // Volume of the last deal
    SYMBOL_VOLUMEHIGH,            // Maximal day volume
    SYMBOL_VOLUMELOW,             // Minimal day volume
    SYMBOL_TIME,                  // Time of the last quote
    SYMBOL_TIME_MSC,              // Time of the last quote in milliseconds since 1970.01.01
    SYMBOL_DIGITS,                // Digits after a decimal point
    SYMBOL_SPREAD_FLOAT,          // Indication of a floating spread
    SYMBOL_SPREAD,                // Spread value in points
    SYMBOL_TICKS_BOOKDEPTH,       // Maximal number of requests shown in Depth of Market. For symbols that have no queue of requests, the value is equal to zero.
    SYMBOL_TRADE_CALC_MODE,       // Contract price calculation mode
    SYMBOL_TRADE_MODE,            // Order execution type
    SYMBOL_START_TIME,            // Date of the symbol trade beginning (usually used for futures)
    SYMBOL_EXPIRATION_TIME,       // Date of the symbol trade end (usually used for futures)
    SYMBOL_TRADE_STOPS_LEVEL,     // Minimal indention in points from the current close price to place Stop orders
    SYMBOL_TRADE_FREEZE_LEVEL,    // Distance to freeze trade operations in points
    SYMBOL_TRADE_EXEMODE,         // Deal execution mode
    SYMBOL_SWAP_MODE,             // Swap calculation model
    SYMBOL_SWAP_ROLLOVER3DAYS,    // Day of week to charge 3 days swap rollover
    SYMBOL_MARGIN_HEDGED_USE_LEG, // Calculating hedging margin using the larger leg (Buy or Sell)
    SYMBOL_EXPIRATION_MODE,       // Flags of allowed order expiration modes
    SYMBOL_FILLING_MODE,          // Flags of allowed order filling modes
    SYMBOL_ORDER_MODE,            // Flags of allowed order types
    SYMBOL_ORDER_GTC_MODE,        // Expiration of Stop Loss and Take Profit orders, if SYMBOL_EXPIRATION_MODE=SYMBOL_EXPIRATION_GTC (Good till canceled)
    SYMBOL_OPTION_MODE,           // Option type
    SYMBOL_OPTION_RIGHT           // Option right (Call/Put)
};

enum ENUM_SYMBOL_INFO_DOUBLE
{
    SYMBOL_BID,                        // Bid - best sell offer
    SYMBOL_BIDHIGH,                    // Maximal Bid of the day
    SYMBOL_BIDLOW,                     // Minimal Bid of the day
    SYMBOL_ASK,                        // Ask - best buy offer
    SYMBOL_ASKHIGH,                    // Maximal Ask of the day
    SYMBOL_ASKLOW,                     // Minimal Ask of the day
    SYMBOL_LAST,                       // Price of the last deal
    SYMBOL_LASTHIGH,                   // Maximal Last of the day
    SYMBOL_LASTLOW,                    // Minimal Last of the day
    SYMBOL_VOLUME_REAL,                // Volume of the last deal
    SYMBOL_VOLUMEHIGH_REAL,            // Maximum Volume of the day
    SYMBOL_VOLUMELOW_REAL,             // Minimum Volume of the day
    SYMBOL_OPTION_STRIKE,              // The strike price of an option. The price at which an option buyer can buy (in a Call option) or sell (in a Put option) the underlying asset, and the option seller is obliged to sell or buy the appropriate amount of the underlying asset.
    SYMBOL_POINT,                      // Symbol point value
    SYMBOL_TRADE_TICK_VALUE,           // Value of SYMBOL_TRADE_TICK_VALUE_PROFIT
    SYMBOL_TRADE_TICK_VALUE_PROFIT,    // Calculated tick price for a profitable position
    SYMBOL_TRADE_TICK_VALUE_LOSS,      // Calculated tick price for a losing position
    SYMBOL_TRADE_TICK_SIZE,            // Minimal price change
    SYMBOL_TRADE_CONTRACT_SIZE,        // Trade contract size
    SYMBOL_TRADE_ACCRUED_INTEREST,     // Accrued interest – accumulated coupon interest, i.e. part of the coupon interest calculated in proportion to the number of days since the coupon bond issuance or the last coupon interest payment
    SYMBOL_TRADE_FACE_VALUE,           // Face value – initial bond value set by the issuer
    SYMBOL_TRADE_LIQUIDITY_RATE,       // Liquidity Rate is the share of the asset that can be used for the margin.
    SYMBOL_VOLUME_MIN,                 // Minimal volume for a deal
    SYMBOL_VOLUME_MAX,                 // Maximal volume for a deal
    SYMBOL_VOLUME_STEP,                // Minimal volume change step for deal execution
    SYMBOL_VOLUME_LIMIT,               // Maximum allowed aggregate volume of an open position and pending orders in one direction (buy or sell) for the symbol. For example, with the limitation of 5 lots, you can have an open buy position with the volume of 5 lots and place a pending order Sell Limit with the volume of 5 lots. But in this case you cannot place a Buy Limit pending order (since the total volume in one direction will exceed the limitation) or place Sell Limit with the volume more than 5 lots.
    SYMBOL_SWAP_LONG,                  // Long swap value
    SYMBOL_SWAP_SHORT,                 // Short swap value
    SYMBOL_MARGIN_INITIAL,             // Initial margin means the amount in the margin currency required for opening a position with the volume of one lot. It is used for checking a client's assets when he or she enters the market.
    SYMBOL_MARGIN_MAINTENANCE,         // The maintenance margin. If it is set, it sets the margin amount in the margin currency of the symbol, charged from one lot. It is used for checking a client's assets when his/her account state changes. If the maintenance margin is equal to 0, the initial margin is used.
    SYMBOL_SESSION_VOLUME,             // Summary volume of current session deals
    SYMBOL_SESSION_TURNOVER,           // Summary turnover of the current session
    SYMBOL_SESSION_INTEREST,           // Summary open interest
    SYMBOL_SESSION_BUY_ORDERS_VOLUME,  // Current volume of Buy orders
    SYMBOL_SESSION_SELL_ORDERS_VOLUME, // Current volume of Sell orders
    SYMBOL_SESSION_OPEN,               // Open price of the current session
    SYMBOL_SESSION_CLOSE,              // Close price of the current session
    SYMBOL_SESSION_AW,                 // Average weighted price of the current session
    SYMBOL_SESSION_PRICE_SETTLEMENT,   // Settlement price of the current session
    SYMBOL_SESSION_PRICE_LIMIT_MIN,    // Minimal price of the current session
    SYMBOL_SESSION_PRICE_LIMIT_MAX,    // Maximal price of the current session
    SYMBOL_MARGIN_HEDGED,              // Contract size or margin value per one lot of hedged positions (oppositely directed positions of one symbol). Two margin calculation methods are possible for hedged positions. The calculation method is defined by the broker.
    SYMBOL_PRICE_CHANGE,               // Change of the current price relative to the end of the previous trading day in %
    SYMBOL_PRICE_VOLATILITY,           // Price volatility in %
    SYMBOL_PRICE_THEORETICAL,          // Theoretical option price
    SYMBOL_PRICE_DELTA,                // Option/warrant delta shows the value the option price changes by, when the underlying asset price changes by 1
    SYMBOL_PRICE_THETA,                // Option/warrant theta shows the number of points the option price is to lose every day due to a temporary breakup, i.e. when the expiration date approaches
    SYMBOL_PRICE_GAMMA,                // Option/warrant gamma shows the change rate of delta – how quickly or slowly the option premium changes
    SYMBOL_PRICE_VEGA,                 // Option/warrant vega shows the number of points the option price changes by when the volatility changes by 1%
    SYMBOL_PRICE_RHO,                  // Option/warrant rho reflects the sensitivity of the theoretical option price to the interest rate changing by 1%
    SYMBOL_PRICE_OMEGA,                // Option/warrant omega. Option elasticity shows a relative percentage change of the option price by the percentage change of the underlying asset price
    SYMBOL_PRICE_SENSITIVITY           // Option/warrant sensitivity shows by how many points the price of the option's underlying asset should change so that the price of the option changes by one point
};

enum ENUM_SYMBOL_INFO_STRING
{
    SYMBOL_BASIS,           // The underlying asset of a derivative
    SYMBOL_CATEGORY,        // The name of the sector or category to which the financial symbol belongs
    SYMBOL_COUNTRY,         // The country to which the financial symbol belongs
    SYMBOL_SECTOR_NAME,     // The sector of the economy to which the financial symbol belongs
    SYMBOL_INDUSTRY_NAME,   // The industry branch or the industry to which the financial symbol belongs
    SYMBOL_CURRENCY_BASE,   // Basic currency of a symbol
    SYMBOL_CURRENCY_PROFIT, // Profit currency
    SYMBOL_CURRENCY_MARGIN, // Margin currency
    SYMBOL_BANK,            // Feeder of the current quote
    SYMBOL_DESCRIPTION,     // Symbol description
    SYMBOL_EXCHANGE,        // The name of the exchange in which the financial symbol is traded
    SYMBOL_FORMULA,         // The formula used for the custom symbol pricing.
    SYMBOL_ISIN,            // The name of a symbol in the ISIN system (International Securities Identification Number). The International Securities Identification Number is a 12-digit alphanumeric code that uniquely identifies a security. The presence of this symbol property is determined on the side of a trade server.
    SYMBOL_PAGE,            // The address of the web page containing symbol information. This address will be displayed as a link when viewing symbol properties in the terminal
    SYMBOL_PATH             // Path in the symbol tree
};

enum ENUM_SYMBOL_CHART_MODE
{
    SYMBOL_CHART_MODE_BID, // Bars are based on Bid prices
    SYMBOL_CHART_MODE_LAST // Bars are based on Last prices
};

enum ENUM_SYMBOL_ORDER_GTC_MODE
{
    SYMBOL_ORDERS_GTC,                  // Pending orders and Stop Loss/Take Profit levels are valid for an unlimited period until their explicit cancellation
    SYMBOL_ORDERS_DAILY,                // Orders are valid during one trading day. At the end of the day, all Stop Loss and Take Profit levels, as well as pending orders are deleted.
    SYMBOL_ORDERS_DAILY_EXCLUDING_STOPS // When a trade day changes, only pending orders are deleted, while Stop Loss and Take Profit levels are preserved.
};

enum ENUM_SYMBOL_CALC_MODE
{
    SYMBOL_CALC_MODE_FOREX,              // Forex mode - calculation of profit and margin for Forex
    SYMBOL_CALC_MODE_FOREX_NO_LEVERAGE,  // Forex No Leverage mode – calculation of profit and margin for Forex symbols without taking into account the leverage
    SYMBOL_CALC_MODE_FUTURES,            // Futures mode - calculation of margin and profit for futures
    SYMBOL_CALC_MODE_CFD,                // CFD mode - calculation of margin and profit for CFD
    SYMBOL_CALC_MODE_CFDINDEX,           // CFD index mode - calculation of margin and profit for CFD by indexes
    SYMBOL_CALC_MODE_CFDLEVERAGE,        // CFD Leverage mode - calculation of margin and profit for CFD at leverage trading
    SYMBOL_CALC_MODE_EXCH_STOCKS,        // Exchange mode – calculation of margin and profit for trading securities on a stock exchange
    SYMBOL_CALC_MODE_EXCH_FUTURES,       // Futures mode –  calculation of margin and profit for trading futures contracts on a stock exchange
    SYMBOL_CALC_MODE_EXCH_FUTURES_FORTS, // FORTS Futures mode –  calculation of margin and profit for trading futures contracts on FORTS.
    SYMBOL_CALC_MODE_EXCH_BONDS,         // Exchange Bonds mode – calculation of margin and profit for trading bonds on a stock exchange
    SYMBOL_CALC_MODE_EXCH_STOCKS_MOEX,   // Exchange MOEX Stocks mode – calculation of margin and profit for trading securities on MOEX
    SYMBOL_CALC_MODE_EXCH_BONDS_MOEX,    // Exchange MOEX Bonds mode – calculation of margin and profit for trading bonds on MOEX
    SYMBOL_CALC_MODE_SERV_COLLATERAL     // Collateral mode - a symbol is used as a non-tradable asset on a trading account. The market value of an open position is calculated based on the volume, current market price, contract size and liquidity ratio. The value is included into Assets, which are added to Equity. Open positions of such symbols increase the Free Margin amount and are used as additional margin (collateral) for open positions of tradable instruments.
};

enum ENUM_SYMBOL_TRADE_MODE
{
    SYMBOL_TRADE_MODE_DISABLED,  // Trade is disabled for the symbol
    SYMBOL_TRADE_MODE_LONGONLY,  // Allowed only long positions
    SYMBOL_TRADE_MODE_SHORTONLY, // Allowed only short positions
    SYMBOL_TRADE_MODE_CLOSEONLY, // Allowed only position close operations
    SYMBOL_TRADE_MODE_FULL       // No trade restrictions
};

enum ENUM_SYMBOL_TRADE_EXECUTION
{
    SYMBOL_TRADE_EXECUTION_REQUEST, // Execution by request
    SYMBOL_TRADE_EXECUTION_INSTANT, // Instant execution
    SYMBOL_TRADE_EXECUTION_MARKET,  // Market execution
    SYMBOL_TRADE_EXECUTION_EXCHANGE // Exchange execution
};

enum ENUM_SYMBOL_SWAP_MODE
{
    SYMBOL_SWAP_MODE_DISABLED,         // Swaps disabled (no swaps)
    SYMBOL_SWAP_MODE_POINTS,           // Swaps are charged in points
    SYMBOL_SWAP_MODE_CURRENCY_SYMBOL,  // Swaps are charged in money in base currency of the symbol
    SYMBOL_SWAP_MODE_CURRENCY_MARGIN,  // Swaps are charged in money in margin currency of the symbol
    SYMBOL_SWAP_MODE_CURRENCY_DEPOSIT, // Swaps are charged in money, in client deposit currency
    SYMBOL_SWAP_MODE_INTEREST_CURRENT, // Swaps are charged as the specified annual interest from the instrument price at calculation of swap (standard bank year is 360 days)
    SYMBOL_SWAP_MODE_INTEREST_OPEN,    // Swaps are charged as the specified annual interest from the open price of position (standard bank year is 360 days)
    SYMBOL_SWAP_MODE_REOPEN_CURRENT,   // Swaps are charged by reopening positions. At the end of a trading day the position is closed. Next day it is reopened by the close price +/- specified number of points (parameters SYMBOL_SWAP_LONG and SYMBOL_SWAP_SHORT)
    SYMBOL_SWAP_MODE_REOPEN_BID        // Swaps are charged by reopening positions. At the end of a trading day the position is closed. Next day it is reopened by the current Bid price +/- specified number of points (parameters SYMBOL_SWAP_LONG and SYMBOL_SWAP_SHORT)
};

enum ENUM_DAY_OF_WEEK
{
    SUNDAY,    // Sunday
    MONDAY,    // Monday
    TUESDAY,   // Tuesday
    WEDNESDAY, // Wednesday
    THURSDAY,  // Thursday
    FRIDAY,    // Friday
    SATURDAY   // Saturday
};

enum ENUM_SYMBOL_OPTION_RIGHT
{
    SYMBOL_OPTION_RIGHT_CALL, // A call option gives you the right to buy an asset at a specified price
    SYMBOL_OPTION_RIGHT_PUT   // A put option gives you the right to sell an asset at a specified price
};

enum ENUM_SYMBOL_OPTION_MODE
{
    SYMBOL_OPTION_MODE_EUROPEAN, // European option may only be exercised on a specified date (expiration, execution date, delivery date)
    SYMBOL_OPTION_MODE_AMERICAN  // American option may be exercised on any trading day or before expiry. The period within which a buyer can exercise the option is specified for it
};

enum ENUM_SYMBOL_SECTOR
{
    SECTOR_UNDEFINED,              // Undefined
    SECTOR_BASIC_MATERIALS,        // Basic materials
    SECTOR_COMMUNICATION_SERVICES, // Communication services
    SECTOR_CONSUMER_CYCLICAL,      // Consumer cyclical
    SECTOR_CONSUMER_DEFENSIVE,     // Consumer defensive
    SECTOR_CURRENCY,               // Currencies
    SECTOR_CURRENCY_CRYPTO,        // Cryptocurrencies
    SECTOR_ENERGY,                 // Energy
    SECTOR_FINANCIAL,              // Finance
    SECTOR_HEALTHCARE,             // Healthcare
    SECTOR_INDUSTRIALS,            // Industrials
    SECTOR_REAL_ESTATE,            // Real estate
    SECTOR_TECHNOLOGY,             // Technology
    SECTOR_UTILITIES,              // Utilities
    SECTOR_INDEXES,                // Indexes
    SECTOR_COMMODITIES             // Exchange-traded goods
};

enum ENUM_SYMBOL_INDUSTRY
{
    INDUSTRY_UNDEFINED,                    // Undefined
    INDUSTRY_AGRICULTURAL_INPUTS,          // Agricultural inputs
    INDUSTRY_ALUMINIUM,                    // Aluminium
    INDUSTRY_BUILDING_MATERIALS,           // Building materials
    INDUSTRY_CHEMICALS,                    // Chemicals
    INDUSTRY_COKING_COAL,                  // Coking coal
    INDUSTRY_COPPER,                       // Copper
    INDUSTRY_GOLD,                         // Gold
    INDUSTRY_LUMBER_WOOD,                  // Lumber and wood production
    INDUSTRY_INDUSTRIAL_METALS,            // Other industrial metals and mining
    INDUSTRY_PRECIOUS_METALS,              // Other precious metals and mining
    INDUSTRY_PAPER,                        // Paper and paper products
    INDUSTRY_SILVER,                       // Silver
    INDUSTRY_SPECIALTY_CHEMICALS,          // Specialty chemicals
    INDUSTRY_STEEL,                        // Steel
    INDUSTRY_ADVERTISING,                  // Advertising agencies
    INDUSTRY_BROADCASTING,                 // Broadcasting
    INDUSTRY_GAMING_MULTIMEDIA,            // Electronic gaming and multimedia
    INDUSTRY_ENTERTAINMENT,                // Entertainment
    INDUSTRY_INTERNET_CONTENT,             // Internet content and information
    INDUSTRY_PUBLISHING,                   // Publishing
    INDUSTRY_TELECOM,                      // Telecom services
    INDUSTRY_APPAREL_MANUFACTURING,        // Apparel manufacturing
    INDUSTRY_APPAREL_RETAIL,               // Apparel retail
    INDUSTRY_AUTO_MANUFACTURERS,           // Auto manufacturers
    INDUSTRY_AUTO_PARTS,                   // Auto parts
    INDUSTRY_AUTO_DEALERSHIP,              // Auto and truck dealerships
    INDUSTRY_DEPARTMENT_STORES,            // Department stores
    INDUSTRY_FOOTWEAR_ACCESSORIES,         // Footwear and accessories
    INDUSTRY_FURNISHINGS,                  // Furnishing, fixtures and appliances
    INDUSTRY_GAMBLING,                     // Gambling
    INDUSTRY_HOME_IMPROV_RETAIL,           // Home improvement retail
    INDUSTRY_INTERNET_RETAIL,              // Internet retail
    INDUSTRY_LEISURE,                      // Leisure
    INDUSTRY_LODGING,                      // Lodging
    INDUSTRY_LUXURY_GOODS,                 // Luxury goods
    INDUSTRY_PACKAGING_CONTAINERS,         // Packaging and containers
    INDUSTRY_PERSONAL_SERVICES,            // Personal services
    INDUSTRY_RECREATIONAL_VEHICLES,        // Recreational vehicles
    INDUSTRY_RESIDENT_CONSTRUCTION,        // Residential construction
    INDUSTRY_RESORTS_CASINOS,              // Resorts and casinos
    INDUSTRY_RESTAURANTS,                  // Restaurants
    INDUSTRY_SPECIALTY_RETAIL,             // Specialty retail
    INDUSTRY_TEXTILE_MANUFACTURING,        // Textile manufacturing
    INDUSTRY_TRAVEL_SERVICES,              // Travel services
    INDUSTRY_BEVERAGES_BREWERS,            // Beverages - Brewers
    INDUSTRY_BEVERAGES_NON_ALCO,           // Beverages - Non-alcoholic
    INDUSTRY_BEVERAGES_WINERIES,           // Beverages - Wineries and distilleries
    INDUSTRY_CONFECTIONERS,                // Confectioners
    INDUSTRY_DISCOUNT_STORES,              // Discount stores
    INDUSTRY_EDUCATION_TRAINIG,            // Education and training services
    INDUSTRY_FARM_PRODUCTS,                // Farm products
    INDUSTRY_FOOD_DISTRIBUTION,            // Food distribution
    INDUSTRY_GROCERY_STORES,               // Grocery stores
    INDUSTRY_HOUSEHOLD_PRODUCTS,           // Household and personal products
    INDUSTRY_PACKAGED_FOODS,               // Packaged foods
    INDUSTRY_TOBACCO,                      // Tobacco
    INDUSTRY_OIL_GAS_DRILLING,             // Oil and gas drilling
    INDUSTRY_OIL_GAS_EP,                   // Oil and gas extraction and processing
    INDUSTRY_OIL_GAS_EQUIPMENT,            // Oil and gas equipment and services
    INDUSTRY_OIL_GAS_INTEGRATED,           // Oil and gas integrated
    INDUSTRY_OIL_GAS_MIDSTREAM,            // Oil and gas midstream
    INDUSTRY_OIL_GAS_REFINING,             // Oil and gas refining and marketing
    INDUSTRY_THERMAL_COAL,                 // Thermal coal
    INDUSTRY_URANIUM,                      // Uranium
    INDUSTRY_EXCHANGE_TRADED_FUND,         // Exchange traded fund
    INDUSTRY_ASSETS_MANAGEMENT,            // Assets management
    INDUSTRY_BANKS_DIVERSIFIED,            // Banks - Diversified
    INDUSTRY_BANKS_REGIONAL,               // Banks - Regional
    INDUSTRY_CAPITAL_MARKETS,              // Capital markets
    INDUSTRY_CLOSE_END_FUND_DEBT,          // Closed-End fund - Debt
    INDUSTRY_CLOSE_END_FUND_EQUITY,        // Closed-end fund - Equity
    INDUSTRY_CLOSE_END_FUND_FOREIGN,       // Closed-end fund - Foreign
    INDUSTRY_CREDIT_SERVICES,              // Credit services
    INDUSTRY_FINANCIAL_CONGLOMERATE,       // Financial conglomerates
    INDUSTRY_FINANCIAL_DATA_EXCHANGE,      // Financial data and stock exchange
    INDUSTRY_INSURANCE_BROKERS,            // Insurance brokers
    INDUSTRY_INSURANCE_DIVERSIFIED,        // Insurance - Diversified
    INDUSTRY_INSURANCE_LIFE,               // Insurance - Life
    INDUSTRY_INSURANCE_PROPERTY,           // Insurance - Property and casualty
    INDUSTRY_INSURANCE_REINSURANCE,        // Insurance - Reinsurance
    INDUSTRY_INSURANCE_SPECIALTY,          // Insurance - Specialty
    INDUSTRY_MORTGAGE_FINANCE,             // Mortgage finance
    INDUSTRY_SHELL_COMPANIES,              // Shell companies
    INDUSTRY_BIOTECHNOLOGY,                // Biotechnology
    INDUSTRY_DIAGNOSTICS_RESEARCH,         // Diagnostics and research
    INDUSTRY_DRUGS_MANUFACTURERS,          // Drugs manufacturers - general
    INDUSTRY_DRUGS_MANUFACTURERS_SPEC,     // Drugs manufacturers - Specialty and generic
    INDUSTRY_HEALTHCARE_PLANS,             // Healthcare plans
    INDUSTRY_HEALTH_INFORMATION,           // Health information services
    INDUSTRY_MEDICAL_FACILITIES,           // Medical care facilities
    INDUSTRY_MEDICAL_DEVICES,              // Medical devices
    INDUSTRY_MEDICAL_DISTRIBUTION,         // Medical distribution
    INDUSTRY_MEDICAL_INSTRUMENTS,          // Medical instruments and supplies
    INDUSTRY_PHARM_RETAILERS,              // Pharmaceutical retailers
    INDUSTRY_AEROSPACE_DEFENSE,            // Aerospace and defense
    INDUSTRY_AIRLINES,                     // Airlines
    INDUSTRY_AIRPORTS_SERVICES,            // Airports and air services
    INDUSTRY_BUILDING_PRODUCTS,            // Building products and equipment
    INDUSTRY_BUSINESS_EQUIPMENT,           // Business equipment and supplies
    INDUSTRY_CONGLOMERATES,                // Conglomerates
    INDUSTRY_CONSULTING_SERVICES,          // Consulting services
    INDUSTRY_ELECTRICAL_EQUIPMENT,         // Electrical equipment and parts
    INDUSTRY_ENGINEERING_CONSTRUCTION,     // Engineering and construction
    INDUSTRY_FARM_HEAVY_MACHINERY,         // Farm and heavy construction machinery
    INDUSTRY_INDUSTRIAL_DISTRIBUTION,      // Industrial distribution
    INDUSTRY_INFRASTRUCTURE_OPERATIONS,    // Infrastructure operations
    INDUSTRY_FREIGHT_LOGISTICS,            // Integrated freight and logistics
    INDUSTRY_MARINE_SHIPPING,              // Marine shipping
    INDUSTRY_METAL_FABRICATION,            // Metal fabrication
    INDUSTRY_POLLUTION_CONTROL,            // Pollution and treatment controls
    INDUSTRY_RAILROADS,                    // Railroads
    INDUSTRY_RENTAL_LEASING,               // Rental and leasing services
    INDUSTRY_SECURITY_PROTECTION,          // Security and protection services
    INDUSTRY_SPEALITY_BUSINESS_SERVICES,   // Specialty business services
    INDUSTRY_SPEALITY_MACHINERY,           // Specialty industrial machinery
    INDUSTRY_STUFFING_EMPLOYMENT,          // Stuffing and employment services
    INDUSTRY_TOOLS_ACCESSORIES,            // Tools and accessories
    INDUSTRY_TRUCKING,                     // Trucking
    INDUSTRY_WASTE_MANAGEMENT,             // Waste management
    INDUSTRY_REAL_ESTATE_DEVELOPMENT,      // Real estate - Development
    INDUSTRY_REAL_ESTATE_DIVERSIFIED,      // Real estate - Diversified
    INDUSTRY_REAL_ESTATE_SERVICES,         // Real estate services
    INDUSTRY_REIT_DIVERSIFIED,             // REIT - Diversified
    INDUSTRY_REIT_HEALTCARE,               // REIT - Healthcase facilities
    INDUSTRY_REIT_HOTEL_MOTEL,             // REIT - Hotel and motel
    INDUSTRY_REIT_INDUSTRIAL,              // REIT - Industrial
    INDUSTRY_REIT_MORTAGE,                 // REIT - Mortgage
    INDUSTRY_REIT_OFFICE,                  // REIT - Office
    INDUSTRY_REIT_RESIDENTAL,              // REIT - Residential
    INDUSTRY_REIT_RETAIL,                  // REIT - Retail
    INDUSTRY_REIT_SPECIALITY,              // REIT - Specialty
    INDUSTRY_COMMUNICATION_EQUIPMENT,      // Communication equipment
    INDUSTRY_COMPUTER_HARDWARE,            // Computer hardware
    INDUSTRY_CONSUMER_ELECTRONICS,         // Consumer electronics
    INDUSTRY_ELECTRONIC_COMPONENTS,        // Electronic components
    INDUSTRY_ELECTRONIC_DISTRIBUTION,      // Electronics and computer distribution
    INDUSTRY_IT_SERVICES,                  // Information technology services
    INDUSTRY_SCIENTIFIC_INSTRUMENTS,       // Scientific and technical instruments
    INDUSTRY_SEMICONDUCTOR_EQUIPMENT,      // Semiconductor equipment and materials
    INDUSTRY_SEMICONDUCTORS,               // Semiconductors
    INDUSTRY_SOFTWARE_APPLICATION,         // Software - Application
    INDUSTRY_SOFTWARE_INFRASTRUCTURE,      // Software - Infrastructure
    INDUSTRY_SOLAR,                        // Solar
    INDUSTRY_UTILITIES_DIVERSIFIED,        // Utilities - Diversified
    INDUSTRY_UTILITIES_POWERPRODUCERS,     // Utilities - Independent power producers
    INDUSTRY_UTILITIES_RENEWABLE,          // Utilities - Renewable
    INDUSTRY_UTILITIES_REGULATED_ELECTRIC, // Utilities - Regulated electric
    INDUSTRY_UTILITIES_REGULATED_GAS,      // Utilities - Regulated gas
    INDUSTRY_UTILITIES_REGULATED_WATER,    // Utilities - Regulated water
    INDUSTRY_UTILITIES_FIRST,              // Start of the utilities services types enumeration. Corresponds to INDUSTRY_UTILITIES_DIVERSIFIED.
    INDUSTRY_UTILITIES_LAST                // End of the utilities services types enumeration. Corresponds to INDUSTRY_UTILITIES_REGULATED_WATER.
};

enum ENUM_ORDER_TYPE
{
    ORDER_TYPE_BUY,             // Market Buy order
    ORDER_TYPE_SELL,            // Market Sell order
    ORDER_TYPE_BUY_LIMIT,       // Buy Limit pending order
    ORDER_TYPE_SELL_LIMIT,      // Sell Limit pending order
    ORDER_TYPE_BUY_STOP,        // Buy Stop pending order
    ORDER_TYPE_SELL_STOP,       // Sell Stop pending order
    ORDER_TYPE_BUY_STOP_LIMIT,  // Upon reaching the order price, a pending Buy Limit order is placed at the StopLimit price
    ORDER_TYPE_SELL_STOP_LIMIT, // Upon reaching the order price, a pending Sell Limit order is placed at the StopLimit price
    ORDER_TYPE_CLOSE_BY         // Order to close a position by an opposite one
};

enum ENUM_ORDER_STATE
{
    ORDER_STATE_STARTED,        // Order checked, but not yet accepted by broker
    ORDER_STATE_PLACED,         // Order accepted
    ORDER_STATE_CANCELED,       // Order canceled by client
    ORDER_STATE_PARTIAL,        // Order partially executed
    ORDER_STATE_FILLED,         // Order fully executed
    ORDER_STATE_REJECTED,       // Order rejected
    ORDER_STATE_EXPIRED,        // Order expired
    ORDER_STATE_REQUEST_ADD,    // Order is being registered (placing to the trading system)
    ORDER_STATE_REQUEST_MODIFY, // Order is being modified (changing its parameters)
    ORDER_STATE_REQUEST_CANCEL  // Order is being deleted (deleting from the trading system)
};

enum ENUM_ORDER_TYPE_TIME
{
    ORDER_TIME_GTC,          // Good till cancel order
    ORDER_TIME_DAY,          // Good till current trade day order
    ORDER_TIME_SPECIFIED,    // Good till expired order
    ORDER_TIME_SPECIFIED_DAY // The order will be effective till 23:59:59 of the specified day. If this time is outside a trading session, the order expires in the nearest trading time.
};

enum ENUM_ORDER_REASON
{
    ORDER_REASON_CLIENT, // The order was placed from a desktop terminal
    ORDER_REASON_MOBILE, // The order was placed from a mobile application
    ORDER_REASON_WEB,    // The order was placed from a web platform
    ORDER_REASON_EXPERT, // The order was placed from an MQL5-program, i.e. by an Expert Advisor or a script
    ORDER_REASON_SL,     // The order was placed as a result of Stop Loss activation
    ORDER_REASON_TP,     // The order was placed as a result of Take Profit activation
    ORDER_REASON_SO      // The order was placed as a result of the Stop Out event
};

enum ENUM_BOOK_TYPE
{
    BOOK_TYPE_SELL,        // Sell order (Offer)
    BOOK_TYPE_BUY,         // Buy order (Bid)
    BOOK_TYPE_SELL_MARKET, // Sell order by Market
    BOOK_TYPE_BUY_MARKET   // Buy order by Market
};

enum ENUM_DATABASE_FIELD_TYPE
{
    DATABASE_FIELD_TYPE_INVALID, // Error getting type, the error code can be obtained using int GetLastError()
    DATABASE_FIELD_TYPE_INTEGER, // Integer type
    DATABASE_FIELD_TYPE_FLOAT,   // Real type
    DATABASE_FIELD_TYPE_TEXT,    // String type
    DATABASE_FIELD_TYPE_BLOB,    // Binary type
    DATABASE_FIELD_TYPE_NULL     // Special NULL type
};

enum ENUM_DX_BUFFER_TYPE
{
    DX_BUFFER_VERTEX, // Vertex buffer
    DX_BUFFER_INDEX   // Index buffer
};

enum ENUM_DX_FORMAT
{
    DX_FORMAT_UNKNOWN,                    // 0 DXGI_FORMAT_UNKNOWN
    DX_FORMAT_R32G32B32A32_TYPELESS,      // 1 DXGI_FORMAT_R32G32B32A32_TYPELESS
    DX_FORMAT_R32G32B32A32_FLOAT,         // 2 DXGI_FORMAT_R32G32B32A32_FLOAT
    DX_FORMAT_R32G32B32A32_UINT,          // 3 DXGI_FORMAT_R32G32B32A32_UINT
    DX_FORMAT_R32G32B32A32_SINT,          // 4 DXGI_FORMAT_R32G32B32A32_SINT
    DX_FORMAT_R32G32B32_TYPELESS,         // 5 DXGI_FORMAT_R32G32B32_TYPELESS
    DX_FORMAT_R32G32B32_FLOAT,            // 6 DXGI_FORMAT_R32G32B32_FLOAT
    DX_FORMAT_R32G32B32_UINT,             // 7 DXGI_FORMAT_R32G32B32_UINT
    DX_FORMAT_R32G32B32_SINT,             // 8 DXGI_FORMAT_R32G32B32_SINT
    DX_FORMAT_R16G16B16A16_TYPELESS,      // 9 DXGI_FORMAT_R16G16B16A16_TYPELESS
    DX_FORMAT_R16G16B16A16_FLOAT,         // 10 DXGI_FORMAT_R16G16B16A16_FLOAT
    DX_FORMAT_R16G16B16A16_UNORM,         // 11 DXGI_FORMAT_R16G16B16A16_UNORM
    DX_FORMAT_R16G16B16A16_UINT,          // 12 DXGI_FORMAT_R16G16B16A16_UINT
    DX_FORMAT_R16G16B16A16_SNORM,         // 13 DXGI_FORMAT_R16G16B16A16_SNORM
    DX_FORMAT_R16G16B16A16_SINT,          // 14 DXGI_FORMAT_R16G16B16A16_SINT
    DX_FORMAT_R32G32_TYPELESS,            // 15 DXGI_FORMAT_R32G32_TYPELESS
    DX_FORMAT_R32G32_FLOAT,               // 16 DXGI_FORMAT_R32G32_FLOAT
    DX_FORMAT_R32G32_UINT,                // 17 DXGI_FORMAT_R32G32_UINT
    DX_FORMAT_R32G32_SINT,                // 18 DXGI_FORMAT_R32G32_SINT
    DX_FORMAT_R32G8X24_TYPELESS,          // 19 DXGI_FORMAT_R32G8X24_TYPELESS
    DX_FORMAT_D32_FLOAT_S8X24_UINT,       // 20 DXGI_FORMAT_D32_FLOAT_S8X24_UINT
    DX_FORMAT_R32_FLOAT_X8X24_TYPELESS,   // 21 DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS
    DX_FORMAT_X32_TYPELESS_G8X24_UINT,    // 22 DXGI_FORMAT_X32_TYPELESS_G8X24_UINT
    DX_FORMAT_R10G10B10A2_TYPELESS,       // 23 DXGI_FORMAT_R10G10B10A2_TYPELESS
    DX_FORMAT_R10G10B10A2_UNORM,          // 24 DXGI_FORMAT_R10G10B10A2_UNORM
    DX_FORMAT_R10G10B10A2_UINT,           // 25 DXGI_FORMAT_R10G10B10A2_UINT
    DX_FORMAT_R11G11B10_FLOAT,            // 26 DXGI_FORMAT_R11G11B10_FLOAT
    DX_FORMAT_R8G8B8A8_TYPELESS,          // 27 DXGI_FORMAT_R8G8B8A8_TYPELESS
    DX_FORMAT_R8G8B8A8_UNORM,             // 28 DXGI_FORMAT_R8G8B8A8_UNORM
    DX_FORMAT_R8G8B8A8_UNORM_SRGB,        // 29 DXGI_FORMAT_R8G8B8A8_UNORM_SRGB
    DX_FORMAT_R8G8B8A8_UINT,              // 30 DXGI_FORMAT_R8G8B8A8_UINT
    DX_FORMAT_R8G8B8A8_SNORM,             // 31 DXGI_FORMAT_R8G8B8A8_SNORM
    DX_FORMAT_R8G8B8A8_SINT,              // 32 DXGI_FORMAT_R8G8B8A8_SINT
    DX_FORMAT_R16G16_TYPELESS,            // 33 DXGI_FORMAT_R16G16_TYPELESS
    DX_FORMAT_R16G16_FLOAT,               // 34 DXGI_FORMAT_R16G16_FLOAT
    DX_FORMAT_R16G16_UNORM,               // 35 DXGI_FORMAT_R16G16_UNORM
    DX_FORMAT_R16G16_UINT,                // 36 DXGI_FORMAT_R16G16_UINT
    DX_FORMAT_R16G16_SNORM,               // 37 DXGI_FORMAT_R16G16_SNORM
    DX_FORMAT_R16G16_SINT,                // 38 DXGI_FORMAT_R16G16_SINT
    DX_FORMAT_R32_TYPELESS,               // 39 DXGI_FORMAT_R32_TYPELESS
    DX_FORMAT_D32_FLOAT,                  // 40 DXGI_FORMAT_D32_FLOAT
    DX_FORMAT_R32_FLOAT,                  // 41 DXGI_FORMAT_R32_FLOAT
    DX_FORMAT_R32_UINT,                   // 42 DXGI_FORMAT_R32_UINT
    DX_FORMAT_R32_SINT,                   // 43 DXGI_FORMAT_R32_SINT
    DX_FORMAT_R24G8_TYPELESS,             // 44 DXGI_FORMAT_R24G8_TYPELESS
    DX_FORMAT_D24_UNORM_S8_UINT,          // 45 DXGI_FORMAT_D24_UNORM_S8_UINT
    DX_FORMAT_R24_UNORM_X8_TYPELESS,      // 46 DXGI_FORMAT_R24_UNORM_X8_TYPELESS
    DX_FORMAT_X24_TYPELESS_G8_UINT,       // 47 DXGI_FORMAT_X24_TYPELESS_G8_UINT
    DX_FORMAT_R8G8_TYPELESS,              // 48 DXGI_FORMAT_R8G8_TYPELESS
    DX_FORMAT_R8G8_UNORM,                 // 49 DXGI_FORMAT_R8G8_UNORM
    DX_FORMAT_R8G8_UINT,                  // 50 DXGI_FORMAT_R8G8_UINT
    DX_FORMAT_R8G8_SNORM,                 // 51 DXGI_FORMAT_R8G8_SNORM
    DX_FORMAT_R8G8_SINT,                  // 52 DXGI_FORMAT_R8G8_SINT
    DX_FORMAT_R16_TYPELESS,               // 53 DXGI_FORMAT_R16_TYPELESS
    DX_FORMAT_R16_FLOAT,                  // 54 DXGI_FORMAT_R16_FLOAT
    DX_FORMAT_D16_UNORM,                  // 55 DXGI_FORMAT_D16_UNORM
    DX_FORMAT_R16_UNORM,                  // 56 DXGI_FORMAT_R16_UNORM
    DX_FORMAT_R16_UINT,                   // 57 DXGI_FORMAT_R16_UINT
    DX_FORMAT_R16_SNORM,                  // 58 DXGI_FORMAT_R16_SNORM
    DX_FORMAT_R16_SINT,                   // 59 DXGI_FORMAT_R16_SINT
    DX_FORMAT_R8_TYPELESS,                // 60 DXGI_FORMAT_R8_TYPELESS
    DX_FORMAT_R8_UNORM,                   // 61 DXGI_FORMAT_R8_UNORM
    DX_FORMAT_R8_UINT,                    // 62 DXGI_FORMAT_R8_UINT
    DX_FORMAT_R8_SNORM,                   // 63 DXGI_FORMAT_R8_SNORM
    DX_FORMAT_R8_SINT,                    // 64 DXGI_FORMAT_R8_SINT
    DX_FORMAT_A8_UNORM,                   // 65 DXGI_FORMAT_A8_UNORM
    DX_FORMAT_R1_UNORM,                   // 66 DXGI_FORMAT_R1_UNORM
    DX_FORMAT_R9G9B9E5_SHAREDEXP,         // 67 DXGI_FORMAT_R9G9B9E5_SHAREDEXP
    DX_FORMAT_R8G8_B8G8_UNORM,            // 68 DXGI_FORMAT_R8G8_B8G8_UNORM
    DX_FORMAT_G8R8_G8B8_UNORM,            // 69 DXGI_FORMAT_G8R8_G8B8_UNORM
    DX_FORMAT_BC1_TYPELESS,               // 70 DXGI_FORMAT_BC1_TYPELESS
    DX_FORMAT_BC1_UNORM,                  // 71 DXGI_FORMAT_BC1_UNORM
    DX_FORMAT_BC1_UNORM_SRGB,             // 72 DXGI_FORMAT_BC1_UNORM_SRGB
    DX_FORMAT_BC2_TYPELESS,               // 73 DXGI_FORMAT_BC2_TYPELESS
    DX_FORMAT_BC2_UNORM,                  // 74 DXGI_FORMAT_BC2_UNORM
    DX_FORMAT_BC2_UNORM_SRGB,             // 75 DXGI_FORMAT_BC2_UNORM_SRGB
    DX_FORMAT_BC3_TYPELESS,               // 76 DXGI_FORMAT_BC3_TYPELESS
    DX_FORMAT_BC3_UNORM,                  // 77 DXGI_FORMAT_BC3_UNORM
    DX_FORMAT_BC3_UNORM_SRGB,             // 78 DXGI_FORMAT_BC3_UNORM_SRGB
    DX_FORMAT_BC4_TYPELESS,               // 79 DXGI_FORMAT_BC4_TYPELESS
    DX_FORMAT_BC4_UNORM,                  // 80 DXGI_FORMAT_BC4_UNORM
    DX_FORMAT_BC4_SNORM,                  // 81 DXGI_FORMAT_BC4_SNORM
    DX_FORMAT_BC5_TYPELESS,               // 82 DXGI_FORMAT_BC5_TYPELESS
    DX_FORMAT_BC5_UNORM,                  // 83 DXGI_FORMAT_BC5_UNORM
    DX_FORMAT_BC5_SNORM,                  // 84 DXGI_FORMAT_BC5_SNORM
    DX_FORMAT_B5G6R5_UNORM,               // 85 DXGI_FORMAT_B5G6R5_UNORM
    DX_FORMAT_B5G5R5A1_UNORM,             // 86 DXGI_FORMAT_B5G5R5A1_UNORM
    DX_FORMAT_B8G8R8A8_UNORM,             // 87 DXGI_FORMAT_B8G8R8A8_UNORM
    DX_FORMAT_B8G8R8X8_UNORM,             // 88 DXGI_FORMAT_B8G8R8X8_UNORM
    DX_FORMAT_R10G10B10_XR_BIAS_A2_UNORM, // 89 DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM
    DX_FORMAT_B8G8R8A8_TYPELESS,          // 90 DXGI_FORMAT_B8G8R8A8_TYPELESS
    DX_FORMAT_B8G8R8A8_UNORM_SRGB,        // 91 DXGI_FORMAT_B8G8R8A8_UNORM_SRGB
    DX_FORMAT_B8G8R8X8_TYPELESS,          // 92 DXGI_FORMAT_B8G8R8X8_TYPELESS
    DX_FORMAT_B8G8R8X8_UNORM_SRGB,        // 93 DXGI_FORMAT_B8G8R8X8_UNORM_SRGB
    DX_FORMAT_BC6H_TYPELESS,              // 94 DXGI_FORMAT_BC6H_TYPELESS
    DX_FORMAT_BC6H_UF16,                  // 95 DXGI_FORMAT_BC6H_UF16
    DX_FORMAT_BC6H_SF16,                  // 96 DXGI_FORMAT_BC6H_SF16
    DX_FORMAT_BC7_TYPELESS,               // 97 DXGI_FORMAT_BC7_TYPELESS
    DX_FORMAT_BC7_UNORM,                  // 98 DXGI_FORMAT_BC7_UNORM
    DX_FORMAT_BC7_UNORM_SRGB,             // 99 DXGI_FORMAT_BC7_UNORM_SRGB
    DX_FORMAT_AYUV,                       // 100 DXGI_FORMAT_AYUV
    DX_FORMAT_Y410,                       // 101 DXGI_FORMAT_Y410
    DX_FORMAT_Y416,                       // 102 DXGI_FORMAT_Y416
    DX_FORMAT_NV12,                       // 103 DXGI_FORMAT_NV12
    DX_FORMAT_P010,                       // 104 DXGI_FORMAT_P010
    DX_FORMAT_P016,                       // 105 DXGI_FORMAT_P016
    DX_FORMAT_420_OPAQUE,                 // 106 DXGI_FORMAT_420_OPAQUE
    DX_FORMAT_YUY2,                       // 107 DXGI_FORMAT_YUY2
    DX_FORMAT_Y210,                       // 108 DXGI_FORMAT_Y210
    DX_FORMAT_Y216,                       // 109 DXGI_FORMAT_Y216
    DX_FORMAT_NV11,                       // 110 DXGI_FORMAT_NV11
    DX_FORMAT_AI44,                       // 111 DXGI_FORMAT_AI44
    DX_FORMAT_IA44,                       // 112 DXGI_FORMAT_IA44
    DX_FORMAT_P8,                         // 113 DXGI_FORMAT_P8
    DX_FORMAT_A8P8,                       // 114 DXGI_FORMAT_A8P8
    DX_FORMAT_B4G4R4A4_UNORM,             // 115 DXGI_FORMAT_B4G4R4A4_UNORM
    DX_FORMAT_P208,                       // 130 DXGI_FORMAT_P208
    DX_FORMAT_V208,                       // 131 DXGI_FORMAT_V208
    DX_FORMAT_V408,                       // 132 DXGI_FORMAT_V408
    DX_FORMAT_FORCE_UINT                  // 0xffffffff DXGI_FORMAT_FORCE_UINT
};

enum ENUM_DX_SHADER_TYPE
{
    DX_SHADER_VERTEX,   // 0 Vertex shader
    DX_SHADER_GEOMETRY, // 1 Geometry shader
    DX_SHADER_PIXEL     // 2 Pixel shader
};

enum ENUM_DX_PRIMITIVE_TOPOLOGY
{
    DX_PRIMITIVE_TOPOLOGY_POINTLIST,        // 1 D3D11_PRIMITIVE_TOPOLOGY_POINTLIST
    DX_PRIMITIVE_TOPOLOGY_LINELIST,         // 2 D3D11_PRIMITIVE_TOPOLOGY_LINELIST
    DX_PRIMITIVE_TOPOLOGY_LINESTRIP,        // 3 D3D11_PRIMITIVE_TOPOLOGY_LINESTRIP
    DX_PRIMITIVE_TOPOLOGY_TRIANGLELIST,     // 4 D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST
    DX_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP,    // 5 D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP
    DX_PRIMITIVE_TOPOLOGY_LINELIST_ADJ,     // 6 D3D11_PRIMITIVE_TOPOLOGY_LINELIST_ADJ
    DX_PRIMITIVE_TOPOLOGY_LINESTRIP_ADJ,    // 7 D3D11_PRIMITIVE_TOPOLOGY_LINESTRIP_ADJ
    DX_PRIMITIVE_TOPOLOGY_TRIANGLELIST_ADJ, // 8 D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST_ADJ
    DX_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP_ADJ // 9 D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP_ADJ
};

enum ENUM_DX_HANDLE_TYPE
{
    DX_HANDLE_INVALID, // 0 Invalid handle
    DX_HANDLE_CONTEXT, // 1 Graphic context handle
    DX_HANDLE_SHADER,  // 2 Shader handle
    DX_HANDLE_BUFFER,  // 3 Vertex or index buffer handle
    DX_HANDLE_INPUT,   // 4 Handle for shader inputs
    DX_HANDLE_TEXTURE  // 5 Texture handle
};

enum ENUM_FILE_PROPERTY_INTEGER
{
    FILE_EXISTS,      //  Check the existence
    FILE_CREATE_DATE, //  Date of creation
    FILE_MODIFY_DATE, //  Date of the last modification
    FILE_ACCESS_DATE, //  Date of the last access to the file
    FILE_SIZE,        //  File size in bytes
    FILE_POSITION,    //  Position of a pointer in the file
    FILE_END,         //  Get the end of file sign
    FILE_LINE_END,    //  Get the end of line sign
    FILE_IS_COMMON,   //  The file is opened in a shared folder of all terminals (see FILE_COMMON)
    FILE_IS_TEXT,     //  The file is opened as a text file (see FILE_TXT)
    FILE_IS_BINARY,   //  The file is opened as a binary file (see FILE_BIN)
    FILE_IS_CSV,      //  The file is opened as CSV (see FILE_CSV)
    FILE_IS_ANSI,     //  The file is opened as ANSI (see FILE_ANSI)
    FILE_IS_READABLE, //  The opened file is readable (see FILE_READ)
    FILE_IS_WRITABLE  //  The opened file is writable (see FILE_WRITE)
};

enum ENUM_FILE_POSITION
{
    SEEK_SET, // File beginning
    SEEK_CUR, // Current position of a file pointer
    SEEK_END  // File end
};

enum ENUM_DEAL_PROPERTY_INTEGER
{
    DEAL_TICKET,     //  Deal ticket. Unique number assigned to each deal
    DEAL_ORDER,      //  Deal order number
    DEAL_TIME,       //  Deal time
    DEAL_TIME_MSC,   //  The time of a deal execution in milliseconds since 01.01.1970
    DEAL_TYPE,       //  Deal type
    DEAL_ENTRY,      //  Deal entry - entry in, entry out, reverse
    DEAL_MAGIC,      //  Deal magic number (see ORDER_MAGIC)
    DEAL_REASON,     //  The reason or source for deal execution
    DEAL_POSITION_ID //  Identifier of a position, in the opening, modification or closing of which this deal took part. Each position has a unique identifier that is assigned to all deals executed for the symbol during the entire lifetime of the position.
};

enum ENUM_DEAL_PROPERTY_DOUBLE
{
    DEAL_VOLUME,     //  Deal volume
    DEAL_PRICE,      //  Deal price
    DEAL_COMMISSION, //  Deal commission
    DEAL_SWAP,       //  Cumulative swap on close
    DEAL_PROFIT,     //  Deal profit
    DEAL_FEE,        //  Fee for making a deal charged immediately after performing a deal
    DEAL_SL,         //  Stop Loss level
    DEAL_TP          //  Take Profit level
};

enum ENUM_DEAL_PROPERTY_STRING
{
    DEAL_SYMBOL,     // Deal symbol
    DEAL_COMMENT,    // Deal comment
    DEAL_EXTERNAL_ID // Deal identifier in an external trading system (on the Exchange)
};

enum ENUM_DEAL_TYPE
{
    DEAL_TYPE_BUY,                      //  Buy
    DEAL_TYPE_SELL,                     //  Sell
    DEAL_TYPE_BALANCE,                  //  Balance
    DEAL_TYPE_CREDIT,                   //  Credit
    DEAL_TYPE_CHARGE,                   //  Additional charge
    DEAL_TYPE_CORRECTION,               //  Correction
    DEAL_TYPE_BONUS,                    //  Bonus
    DEAL_TYPE_COMMISSION,               //  Additional commission
    DEAL_TYPE_COMMISSION_DAILY,         //  Daily commission
    DEAL_TYPE_COMMISSION_MONTHLY,       //  Monthly commission
    DEAL_TYPE_COMMISSION_AGENT_DAILY,   //  Daily agent commission
    DEAL_TYPE_COMMISSION_AGENT_MONTHLY, //  Monthly agent commission
    DEAL_TYPE_INTEREST,                 //  Interest rate
    DEAL_TYPE_BUY_CANCELED,             //  Canceled buy deal. There can be a situation when a previously executed buy deal is canceled. In this case, the type of the previously executed deal (DEAL_TYPE_BUY) is changed to DEAL_TYPE_BUY_CANCELED, and its profit/loss is zeroized. Previously obtained profit/loss is charged/withdrawn using a separated balance operation
    DEAL_TYPE_SELL_CANCELED,            //  Canceled sell deal. There can be a situation when a previously executed sell deal is canceled. In this case, the type of the previously executed deal (DEAL_TYPE_SELL) is changed to DEAL_TYPE_SELL_CANCELED, and its profit/loss is zeroized. Previously obtained profit/loss is charged/withdrawn using a separated balance operation
    DEAL_DIVIDEND,                      //  Dividend operations
    DEAL_DIVIDEND_FRANKED,              //  Franked (non-taxable) dividend operations
    DEAL_TAX                            //  Tax charges
};

enum ENUM_DEAL_ENTRY
{
    DEAL_ENTRY_IN,    // Entry in
    DEAL_ENTRY_OUT,   // Entry out
    DEAL_ENTRY_INOUT, // Reverse
    DEAL_ENTRY_OUT_BY // Close a position by an opposite one
};

enum ENUM_DEAL_REASON
{
    DEAL_REASON_CLIENT,   //  The deal was executed as a result of activation of an order placed from a desktop terminal
    DEAL_REASON_MOBILE,   //  The deal was executed as a result of activation of an order placed from a mobile application
    DEAL_REASON_WEB,      //  The deal was executed as a result of activation of an order placed from the web platform
    DEAL_REASON_EXPERT,   //  The deal was executed as a result of activation of an order placed from an MQL5 program, i.e. an Expert Advisor or a script
    DEAL_REASON_SL,       //  The deal was executed as a result of Stop Loss activation
    DEAL_REASON_TP,       //  The deal was executed as a result of Take Profit activation
    DEAL_REASON_SO,       //  The deal was executed as a result of the Stop Out event
    DEAL_REASON_ROLLOVER, //  The deal was executed due to a rollover
    DEAL_REASON_VMARGIN,  //  The deal was executed after charging the variation margin
    DEAL_REASON_SPLIT     //  The deal was executed after the split (price reduction) of an instrument, which had an open position during split announcement
};

enum ENUM_ORDER_PROPERTY_INTEGER
{
    ORDER_TICKET,          //  Order ticket. Unique number assigned to each order
    ORDER_TIME_SETUP,      //  Order setup time
    ORDER_TYPE,            //  Order type
    ORDER_STATE,           //  Order state
    ORDER_TIME_EXPIRATION, //  Order expiration time
    ORDER_TIME_DONE,       //  Order execution or cancellation time
    ORDER_TIME_SETUP_MSC,  //  The time of placing an order for execution in milliseconds since 01.01.1970
    ORDER_TIME_DONE_MSC,   //  Order execution/cancellation time in milliseconds since 01.01.1970
    ORDER_TYPE_FILLING,    //  Order filling type
    ORDER_TYPE_TIME,       //  Order lifetime
    ORDER_MAGIC,           //  ID of an Expert Advisor that has placed the order (designed to ensure that each Expert Advisor places its own unique number)
    ORDER_REASON,          //  The reason or source for placing an order
    ORDER_POSITION_ID,     //  Position identifier that is set to an order as soon as it is executed. Each executed order results in a deal that opens or modifies an already existing position. The identifier of exactly this position is set to the executed order at this moment.
    ORDER_POSITION_BY_ID   //  Identifier of an opposite position used for closing by order  ORDER_TYPE_CLOSE_BY
};

enum ENUM_ORDER_PROPERTY_DOUBLE
{
    ORDER_VOLUME_INITIAL, //  Order initial volume
    ORDER_VOLUME_CURRENT, //  Order current volume
    ORDER_PRICE_OPEN,     //  Price specified in the order
    ORDER_SL,             //  Stop Loss value
    ORDER_TP,             //  Take Profit value
    ORDER_PRICE_CURRENT,  //  The current price of the order symbol
    ORDER_PRICE_STOPLIMIT //  The Limit order price for the StopLimit order
};

enum ENUM_ORDER_PROPERTY_STRING
{
    ORDER_SYMBOL,     // Symbol of the order
    ORDER_COMMENT,    // Order comment
    ORDER_EXTERNAL_ID // Order identifier in an external trading system (on the Exchange)
};

enum ENUM_SERIESMODE
{
    MODE_OPEN,        //  Opening price
    MODE_LOW,         //  Low price
    MODE_HIGH,        //  High price
    MODE_CLOSE,       //  Close price
    MODE_VOLUME,      //  Tick volume
    MODE_REAL_VOLUME, //  Real volume
    MODE_SPREAD       //  Spread
};

enum ENUM_APPLIED_PRICE
{
    PRICE_CLOSE,   //  Close price
    PRICE_OPEN,    //  Open price
    PRICE_HIGH,    //  The maximum price for the period
    PRICE_LOW,     //  The minimum price for the period
    PRICE_MEDIAN,  //  Median price, (high + low)/2
    PRICE_TYPICAL, //  Typical price, (high + low + close)/3
    PRICE_WEIGHTED //  Average price, (high + low + close + close)/4
};

enum ENUM_APPLIED_VOLUME
{
    VOLUME_TICK, // Tick volume
    VOLUME_REAL  // Trade volume
};

enum ENUM_STO_PRICE
{
    STO_LOWHIGH,   // Calculation is based on Low/High prices
    STO_CLOSECLOSE // Calculation is based on Close/Close prices
};

enum ENUM_MA_METHOD
{
    MODE_SMA,  // Simple averaging
    MODE_EMA,  // Exponential averaging
    MODE_SMMA, // Smoothed averaging
    MODE_LWMA  // Linear-weighted averaging
};

enum ENUM_INDICATOR
{
    IND_AC,         //  Accelerator Oscillator
    IND_AD,         //  Accumulation/Distribution
    IND_ADX,        //  Average Directional Index
    IND_ADXW,       //  ADX by Welles Wilder
    IND_ALLIGATOR,  //  Alligator
    IND_AMA,        //  Adaptive Moving Average
    IND_AO,         //  Awesome Oscillator
    IND_ATR,        //  Average True Range
    IND_BANDS,      //  Bollinger Bands®
    IND_BEARS,      //  Bears Power
    IND_BULLS,      //  Bulls Power
    IND_BWMFI,      //  Market Facilitation Index
    IND_CCI,        //  Commodity Channel Index
    IND_CHAIKIN,    //  Chaikin Oscillator
    IND_CUSTOM,     //  Custom indicator
    IND_DEMA,       //  Double Exponential Moving Average
    IND_DEMARKER,   //  DeMarker
    IND_ENVELOPES,  //  Envelopes
    IND_FORCE,      //  Force Index
    IND_FRACTALS,   //  Fractals
    IND_FRAMA,      //  Fractal Adaptive Moving Average
    IND_GATOR,      //  Gator Oscillator
    IND_ICHIMOKU,   //  Ichimoku Kinko Hyo
    IND_MA,         //  Moving Average
    IND_MACD,       //  MACD
    IND_MFI,        //  Money Flow Index
    IND_MOMENTUM,   //  Momentum
    IND_OBV,        //  On Balance Volume
    IND_OSMA,       //  OsMA
    IND_RSI,        //  Relative Strength Index
    IND_RVI,        //  Relative Vigor Index
    IND_SAR,        //  Parabolic SAR
    IND_STDDEV,     //  Standard Deviation
    IND_STOCHASTIC, //  Stochastic Oscillator
    IND_TEMA,       //  Triple Exponential Moving Average
    IND_TRIX,       //  Triple Exponential Moving Averages Oscillator
    IND_VIDYA,      //  Variable Index Dynamic Average
    IND_VOLUMES,    //  Volumes
    IND_WPR         //  Williams' Percent Range
};

enum ENUM_DATATYPE
{
    TYPE_BOOL,     // bool
    TYPE_CHAR,     // char
    TYPE_UCHAR,    // uchar
    TYPE_SHORT,    // short
    TYPE_USHORT,   // ushort
    TYPE_COLOR,    // color
    TYPE_INT,      // int
    TYPE_UINT,     // uint
    TYPE_DATETIME, // datetime
    TYPE_LONG,     // long
    TYPE_ULONG,    // ulong
    TYPE_FLOAT,    // float
    TYPE_DOUBLE,   // double
    TYPE_STRING    // string
};

enum ENUM_OBJECT
{
    OBJ_VLINE,             // Vertical Line
    OBJ_HLINE,             // Horizontal Line
    OBJ_TREND,             // Trend Line
    OBJ_TRENDBYANGLE,      // Trend Line By Angle
    OBJ_CYCLES,            // Cycle Lines
    OBJ_ARROWED_LINE,      // Arrowed Line
    OBJ_CHANNEL,           // Equidistant Channel
    OBJ_STDDEVCHANNEL,     // Standard Deviation Channel
    OBJ_REGRESSION,        // Linear Regression Channel
    OBJ_PITCHFORK,         // Andrews’ Pitchfork
    OBJ_GANNLINE,          // Gann Line
    OBJ_GANNFAN,           // Gann Fan
    OBJ_GANNGRID,          // Gann Grid
    OBJ_FIBO,              // Fibonacci Retracement
    OBJ_FIBOTIMES,         // Fibonacci Time Zones
    OBJ_FIBOFAN,           // Fibonacci Fan
    OBJ_FIBOARC,           // Fibonacci Arcs
    OBJ_FIBOCHANNEL,       // Fibonacci Channel
    OBJ_EXPANSION,         // Fibonacci Expansion
    OBJ_ELLIOTWAVE5,       // Elliott Motive Wave
    OBJ_ELLIOTWAVE3,       // Elliott Correction Wave
    OBJ_RECTANGLE,         // Rectangle
    OBJ_TRIANGLE,          // Triangle
    OBJ_ELLIPSE,           // Ellipse
    OBJ_ARROW_THUMB_UP,    // Thumbs Up
    OBJ_ARROW_THUMB_DOWN,  // Thumbs Down
    OBJ_ARROW_UP,          // Arrow Up
    OBJ_ARROW_DOWN,        // Arrow Down
    OBJ_ARROW_STOP,        // Stop Sign
    OBJ_ARROW_CHECK,       // Check Sign
    OBJ_ARROW_LEFT_PRICE,  // Left Price Label
    OBJ_ARROW_RIGHT_PRICE, // Right Price Label
    OBJ_ARROW_BUY,         // Buy Sign
    OBJ_ARROW_SELL,        // Sell Sign
    OBJ_ARROW,             // Arrow
    OBJ_TEXT,              // Text
    OBJ_LABEL,             // Label
    OBJ_BUTTON,            // Button
    OBJ_CHART,             // Chart
    OBJ_BITMAP,            // Bitmap
    OBJ_BITMAP_LABEL,      // Bitmap Label
    OBJ_EDIT,              // Edit
    OBJ_EVENT,             // The "Event" object corresponding to an event in the economic calendar
    OBJ_RECTANGLE_LABEL    // The "Rectangle label" object for creating and designing the custom graphical interface.
};

enum ENUM_TRADE_TRANSACTION_TYPE
{
    TRADE_TRANSACTION_ORDER_ADD,      // Adding a new open order.
    TRADE_TRANSACTION_ORDER_UPDATE,   // Updating an open order. The updates include not only evident changes from the client terminal or a trade server sides but also changes of an order state when setting it (for example, transition from ORDER_STATE_STARTED to ORDER_STATE_PLACED or from ORDER_STATE_PLACED to ORDER_STATE_PARTIAL, etc.).
    TRADE_TRANSACTION_ORDER_DELETE,   // Removing an order from the list of the open ones. An order can be deleted from the open ones as a result of setting an appropriate request or execution (filling) and moving to the history.
    TRADE_TRANSACTION_DEAL_ADD,       // Adding a deal to the history. The action is performed as a result of an order execution or performing operations with an account balance.
    TRADE_TRANSACTION_DEAL_UPDATE,    // Updating a deal in the history. There may be cases when a previously executed deal is changed on a server. For example, a deal has been changed in an external trading system (exchange) where it was previously transferred by a broker.
    TRADE_TRANSACTION_DEAL_DELETE,    // Deleting a deal from the history. There may be cases when a previously executed deal is deleted from a server. For example, a deal has been deleted in an external trading system (exchange) where it was previously transferred by a broker.
    TRADE_TRANSACTION_HISTORY_ADD,    // Adding an order to the history as a result of execution or cancellation.
    TRADE_TRANSACTION_HISTORY_UPDATE, // Changing an order located in the orders history. This type is provided for enhancing functionality on a trade server side.
    TRADE_TRANSACTION_HISTORY_DELETE, // Deleting an order from the orders history. This type is provided for enhancing functionality on a trade server side.
    TRADE_TRANSACTION_POSITION,       // Changing a position not related to a deal execution. This type of transaction shows that a position has been changed on a trade server side. Position volume, open price, Stop Loss and Take Profit levels can be changed. Data on changes are submitted in MqlTradeTransaction structure via OnTradeTransaction handler. Position change (adding, changing or closing), as a result of a deal execution, does not lead to the occurrence of TRADE_TRANSACTION_POSITION transaction.
    TRADE_TRANSACTION_REQUEST         // Notification of the fact that a trade request has been processed by a server and processing result has been received. Only type field (trade transaction type) must be analyzed for such transactions in MqlTradeTransaction structure. The second and third parameters of OnTradeTransaction (request and result) must be analyzed for additional data.
};

enum ENUM_TRADE_REQUEST_ACTIONS
{
    TRADE_ACTION_DEAL,    // Place a trade order for an immediate execution with the specified parameters (market order)
    TRADE_ACTION_PENDING, // Place a trade order for the execution under specified conditions (pending order)
    TRADE_ACTION_SLTP,    // Modify Stop Loss and Take Profit values of an opened position
    TRADE_ACTION_MODIFY,  // Modify the parameters of the order placed previously
    TRADE_ACTION_REMOVE,  // Delete the pending order placed previously
    TRADE_ACTION_CLOSE_BY // Close a position by an opposite one
};

enum ENUM_ORDER_TYPE_FILLING
{
    ORDER_FILLING_FOK,   // An order can be executed in the specified volume only.
    ORDER_FILLING_IOC,   // A trader agrees to execute a deal with the volume maximally available in the market within that indicated in the order.
    ORDER_FILLING_RETURN // In case of partial filling, an order with remaining volume is not canceled but processed further.
};

enum ENUM_POSITION_PROPERTY_INTEGER
{
    POSITION_TICKET,          // Position ticket. Unique number assigned to each newly opened position. It usually matches the ticket of an order used to open the position except when the ticket is changed as a result of service operations on the server, for example, when charging swaps with position re-opening. To find an order used to open a position, apply the POSITION_IDENTIFIER property.
    POSITION_TIME,            // Position open time
    POSITION_TIME_MSC,        // Position opening time in milliseconds since 01.01.1970
    POSITION_TIME_UPDATE,     // Position changing time
    POSITION_TIME_UPDATE_MSC, // Position changing time in milliseconds since 01.01.1970
    POSITION_TYPE,            // Position type
    POSITION_MAGIC,           // Position magic number (see ORDER_MAGIC)
    POSITION_IDENTIFIER,      // Position identifier is a unique number assigned to each re-opened position. It does not change throughout its life cycle and corresponds to the ticket of an order used to open a position.
    POSITION_REASON           // The reason for opening a position
};

enum ENUM_POSITION_PROPERTY_DOUBLE
{
    POSITION_VOLUME,        // Position volume
    POSITION_PRICE_OPEN,    // Position open price
    POSITION_SL,            // Stop Loss level of opened position
    POSITION_TP,            // Take Profit level of opened position
    POSITION_PRICE_CURRENT, // Current price of the position symbol
    POSITION_SWAP,          // Cumulative swap
    POSITION_PROFIT         // Current profit
};

enum ENUM_POSITION_PROPERTY_STRING
{
    POSITION_SYMBOL,     // Symbol of the position
    POSITION_COMMENT,    // Position comment
    POSITION_EXTERNAL_ID // Position identifier in an external trading system (on the Exchange)
};

enum ENUM_POSITION_TYPE
{
    POSITION_TYPE_BUY, // Buy
    POSITION_TYPE_SELL // Sell
};

enum ENUM_POSITION_REASON
{
    POSITION_REASON_CLIENT, // The position was opened as a result of activation of an order placed from a desktop terminal
    POSITION_REASON_MOBILE, // The position was opened as a result of activation of an order placed from a mobile application
    POSITION_REASON_WEB,    // The position was opened as a result of activation of an order placed from the web platform
    POSITION_REASON_EXPERT  // The position was opened as a result of activation of an order placed from an MQL5 program, i.e. an Expert Advisor or a script
};

enum ENUM_COLOR_FORMAT
{
    COLOR_FORMAT_XRGB_NOALPHA,  // The component of the alpha channel is ignored
    COLOR_FORMAT_ARGB_RAW,      // Color components are not handled by the terminal (must be correctly set by the user)
    COLOR_FORMAT_ARGB_NORMALIZE // Color components are handled by the terminal
};

enum ENUM_SERIES_INFO_INTEGER
{
    SERIES_BARS_COUNT,         // Bars count for the symbol-period for the current moment
    SERIES_FIRSTDATE,          // The very first date for the symbol-period for the current moment
    SERIES_LASTBAR_DATE,       // Open time of the last bar of the symbol-period
    SERIES_SERVER_FIRSTDATE,   // The very first date in the history of the symbol on the server regardless of the timeframe
    SERIES_TERMINAL_FIRSTDATE, // The very first date in the history of the symbol in the client terminal, regardless of the timeframe
    SERIES_SYNCHRONIZED        // Symbol/period data synchronization flag for the current moment
};

enum ENUM_INDEXBUFFER_TYPE
{
    INDICATOR_DATA,        // Data to draw
    INDICATOR_COLOR_INDEX, // Color
    INDICATOR_CALCULATIONS // Auxiliary buffers for intermediate calculations
};

enum ENUM_CUSTOMIND_PROPERTY_INTEGER
{
    INDICATOR_DIGITS,     // Accuracy of drawing of indicator values
    INDICATOR_HEIGHT,     // Fixed height of the indicator's window (the preprocessor command #property indicator_height)
    INDICATOR_LEVELS,     // Number of levels in the indicator window
    INDICATOR_LEVELCOLOR, // Color of the level line
    INDICATOR_LEVELSTYLE, // Style of the level line
    INDICATOR_LEVELWIDTH  // Thickness of the level line
};

enum ENUM_CUSTOMIND_PROPERTY_DOUBLE
{
    INDICATOR_MINIMUM,   // Minimum of the indicator window
    INDICATOR_MAXIMUM,   // Maximum of the indicator window
    INDICATOR_LEVELVALUE // Level value
};

enum ENUM_CUSTOMIND_PROPERTY_STRING
{
    INDICATOR_SHORTNAME, // Short indicator name
    INDICATOR_LEVELTEXT  // Level description
};

enum ENUM_SIGNAL_BASE_DOUBLE
{
    SIGNAL_BASE_BALANCE,      // Account balance
    SIGNAL_BASE_EQUITY,       // Account equity
    SIGNAL_BASE_GAIN,         // Account gain
    SIGNAL_BASE_MAX_DRAWDOWN, // Account maximum drawdown
    SIGNAL_BASE_PRICE,        // Signal subscription price
    SIGNAL_BASE_ROI           // Return on Investment (%)
};

enum ENUM_SIGNAL_BASE_INTEGER
{
    SIGNAL_BASE_DATE_PUBLISHED, // Publication date (date when it become available for subscription)
    SIGNAL_BASE_DATE_STARTED,   // Monitoring starting date
    SIGNAL_BASE_DATE_UPDATED,   // The date of the last update of the signal's trading statistics
    SIGNAL_BASE_ID,             // Signal ID
    SIGNAL_BASE_LEVERAGE,       // Account leverage
    SIGNAL_BASE_PIPS,           // Profit in pips
    SIGNAL_BASE_RATING,         // Position in rating
    SIGNAL_BASE_SUBSCRIBERS,    // Number of subscribers
    SIGNAL_BASE_TRADES,         // Number of trades
    SIGNAL_BASE_TRADE_MODE      // Account type (0-real, 1-demo, 2-contest)
};

enum ENUM_SIGNAL_BASE_STRING
{
    SIGNAL_BASE_AUTHOR_LOGIN,  // Author login
    SIGNAL_BASE_BROKER,        // Broker name (company)
    SIGNAL_BASE_BROKER_SERVER, // Broker server
    SIGNAL_BASE_NAME,          // Signal name
    SIGNAL_BASE_CURRENCY       // Signal base currency
};

enum ENUM_SIGNAL_INFO_DOUBLE
{
    SIGNAL_INFO_EQUITY_LIMIT,  // Equity limit
    SIGNAL_INFO_SLIPPAGE,      // Slippage (used when placing market orders in synchronization of positions and copying of trades)
    SIGNAL_INFO_VOLUME_PERCENT // Maximum percent of deposit used (%), r/o
};

enum ENUM_SIGNAL_INFO_INTEGER
{
    SIGNAL_INFO_CONFIRMATIONS_DISABLED, // The flag enables synchronization without confirmation dialog
    SIGNAL_INFO_COPY_SLTP,              // Copy Stop Loss and Take Profit flag
    SIGNAL_INFO_DEPOSIT_PERCENT,        // Deposit percent (%)
    SIGNAL_INFO_ID,                     // Signal id, r/o
    SIGNAL_INFO_SUBSCRIPTION_ENABLED,   // "Copy trades by subscription" permission flag
    SIGNAL_INFO_TERMS_AGREE             // "Agree to terms of use of Signals service" flag, r/o
};

enum ENUM_SIGNAL_INFO_STRING
{
    SIGNAL_INFO_NAME // Signal name, r/o
};

enum ENUM_STATISTICS
{
    STAT_INITIAL_DEPOSIT,       // The value of the initial deposit
    STAT_WITHDRAWAL,            // Money withdrawn from an account
    STAT_PROFIT,                // Net profit after testing, the sum of STAT_GROSS_PROFIT and STAT_GROSS_LOSS (STAT_GROSS_LOSS is always less than or equal to zero)
    STAT_GROSS_PROFIT,          // Total profit, the sum of all profitable (positive) trades. The value is greater than or equal to zero
    STAT_GROSS_LOSS,            // Total loss, the sum of all negative trades. The value is less than or equal to zero
    STAT_MAX_PROFITTRADE,       // Maximum profit – the largest value of all profitable trades. The value is greater than or equal to zero
    STAT_MAX_LOSSTRADE,         // Maximum loss – the lowest value of all losing trades. The value is less than or equal to zero
    STAT_CONPROFITMAX,          // Maximum profit in a series of profitable trades. The value is greater than or equal to zero
    STAT_CONPROFITMAX_TRADES,   // The number of trades that have formed STAT_CONPROFITMAX (maximum profit in a series of profitable trades)
    STAT_MAX_CONWINS,           // The total profit of the longest series of profitable trades
    STAT_MAX_CONPROFIT_TRADES,  // The number of trades in the longest series of profitable trades STAT_MAX_CONWINS
    STAT_CONLOSSMAX,            // Maximum loss in a series of losing trades. The value is less than or equal to zero
    STAT_CONLOSSMAX_TRADES,     // The number of trades that have formed STAT_CONLOSSMAX (maximum loss in a series of losing trades)
    STAT_MAX_CONLOSSES,         // The total loss of the longest series of losing trades
    STAT_MAX_CONLOSS_TRADES,    // The number of trades in the longest series of losing trades STAT_MAX_CONLOSSES
    STAT_BALANCEMIN,            // Minimum balance value
    STAT_BALANCE_DD,            // Maximum balance drawdown in monetary terms. In the process of trading, a balance may have numerous drawdowns; here the largest value is taken
    STAT_BALANCEDD_PERCENT,     // Balance drawdown as a percentage that was recorded at the moment of the maximum balance drawdown in monetary terms (STAT_BALANCE_DD).
    STAT_BALANCE_DDREL_PERCENT, // Maximum balance drawdown as a percentage. In the process of trading, a balance may have numerous drawdowns, for each of which the relative drawdown value in percents is calculated. The greatest value is returned
    STAT_BALANCE_DD_RELATIVE,   // Balance drawdown in monetary terms that was recorded at the moment of the maximum balance drawdown as a percentage (STAT_BALANCE_DDREL_PERCENT).
    STAT_EQUITYMIN,             // Minimum equity value
    STAT_EQUITY_DD,             // Maximum equity drawdown in monetary terms. In the process of trading, numerous drawdowns may appear on the equity; here the largest value is taken
    STAT_EQUITYDD_PERCENT,      // Drawdown in percent that was recorded at the moment of the maximum equity drawdown in monetary terms (STAT_EQUITY_DD).
    STAT_EQUITY_DDREL_PERCENT,  // Maximum equity drawdown as a percentage. In the process of trading, an equity may have numerous drawdowns, for each of which the relative drawdown value in percents is calculated. The greatest value is returned
    STAT_EQUITY_DD_RELATIVE,    // Equity drawdown in monetary terms that was recorded at the moment of the maximum equity drawdown in percent (STAT_EQUITY_DDREL_PERCENT).
    STAT_EXPECTED_PAYOFF,       // Expected payoff
    STAT_PROFIT_FACTOR,         // Profit factor, equal to  the ratio of STAT_GROSS_PROFIT/STAT_GROSS_LOSS. If STAT_GROSS_LOSS=0, the profit factor is equal to DBL_MAX
    STAT_RECOVERY_FACTOR,       // Recovery factor, equal to the ratio of STAT_PROFIT/STAT_BALANCE_DD
    STAT_SHARPE_RATIO,          // Sharpe ratio
    STAT_MIN_MARGINLEVEL,       // Minimum value of the margin level
    STAT_CUSTOM_ONTESTER,       // The value of the calculated custom optimization criterion returned by the OnTester() function
    STAT_DEALS,                 // The number of deals
    STAT_TRADES,                // The number of trades
    STAT_PROFIT_TRADES,         // Profitable trades
    STAT_LOSS_TRADES,           // Losing trades
    STAT_SHORT_TRADES,          // Short trades
    STAT_LONG_TRADES,           // Long trades
    STAT_PROFIT_SHORTTRADES,    // Profitable short trades
    STAT_PROFIT_LONGTRADES,     // Profitable long trades
    STAT_PROFITTRADES_AVGCON,   // Average length of a profitable series of trades
    STAT_LOSSTRADES_AVGCON      // Average length of a losing series of trades
};

enum ENUM_ANCHOR_POINT
{
    ANCHOR_LEFT_UPPER,  // Anchor point at the upper left corner
    ANCHOR_LEFT,        // Anchor point to the left in the center
    ANCHOR_LEFT_LOWER,  // Anchor point at the lower left corner
    ANCHOR_LOWER,       // Anchor point below in the center
    ANCHOR_RIGHT_LOWER, // Anchor point at the lower right corner
    ANCHOR_RIGHT,       // Anchor point to the right in the center
    ANCHOR_RIGHT_UPPER, // Anchor point at the upper right corner
    ANCHOR_UPPER,       // Anchor point above in the center
    ANCHOR_CENTER       // Anchor point strictly in the center of the object
};

enum ENUM_CHART_PROPERTY_INTEGER
{
    CHART_SHOW,                // Price chart drawing.
    CHART_IS_OBJECT,           // Identifying "Chart" (OBJ_CHART) object – returns true for a graphical object. Returns false for a real chart
    CHART_BRING_TO_TOP,        // Show chart on top of other charts
    CHART_CONTEXT_MENU,        // Enabling/disabling access to the context menu using the right click.
    CHART_CROSSHAIR_TOOL,      // Enabling/disabling access to the Crosshair tool using the middle click.
    CHART_MOUSE_SCROLL,        // Scrolling the chart horizontally using the left mouse button. Vertical scrolling is also available if the value of any following properties is set to true: CHART_SCALEFIX, CHART_SCALEFIX_11 or CHART_SCALE_PT_PER_BAR
    CHART_EVENT_MOUSE_WHEEL,   // Sending messages about mouse wheel events (CHARTEVENT_MOUSE_WHEEL) to all mql5 programs on a chart
    CHART_EVENT_MOUSE_MOVE,    // Send notifications of mouse move and mouse click events (CHARTEVENT_MOUSE_MOVE) to all mql5 programs on a chart
    CHART_EVENT_OBJECT_CREATE, // Send a notification of an event of new object creation (CHARTEVENT_OBJECT_CREATE) to all mql5-programs on a chart
    CHART_EVENT_OBJECT_DELETE, // Send a notification of an event of object deletion (CHARTEVENT_OBJECT_DELETE) to all mql5-programs on a chart
    CHART_MODE,                // Chart type (candlesticks, bars or line)
    CHART_FOREGROUND,          // Price chart in the foreground
    CHART_SHIFT,               // Mode of price chart indent from the right border
    CHART_AUTOSCROLL,          // Mode of automatic moving to the right border of the chart
    CHART_KEYBOARD_CONTROL,    // Allow managing the chart using a keyboard ("Home", "End", "PageUp", "+", "-", "Up arrow", etc.). Setting CHART_KEYBOARD_CONTROL to false disables chart scrolling and scaling while leaving intact the ability to receive the keys pressing events in OnChartEvent().
    CHART_QUICK_NAVIGATION,    // Allow the chart to intercept Space and Enter key strokes to activate the quick navigation bar. The quick navigation bar automatically appears at the bottom of the chart after double-clicking the mouse or pressing Space/Enter. It allows you to quickly change a symbol, timeframe and first visible bar date.
    CHART_SCALE,               // Scale
    CHART_SCALEFIX,            // Fixed scale mode
    CHART_SCALEFIX_11,         // Scale 1:1 mode
    CHART_SCALE_PT_PER_BAR,    // Scale to be specified in points per bar
    CHART_SHOW_TICKER,         // Display a symbol ticker in the upper left corner. Setting CHART_SHOW_TICKER to 'false' also sets CHART_SHOW_OHLC to 'false' and disables OHLC
    CHART_SHOW_OHLC,           // Display OHLC values in the upper left corner. Setting CHART_SHOW_OHLC to 'true' also sets CHART_SHOW_TICKER to 'true' and enables the ticker
    CHART_SHOW_BID_LINE,       // Display Bid values as a horizontal line in a chart
    CHART_SHOW_ASK_LINE,       // Display Ask values as a horizontal line in a chart
    CHART_SHOW_LAST_LINE,      // Display Last values as a horizontal line in a chart
    CHART_SHOW_PERIOD_SEP,     // Display vertical separators between adjacent periods
    CHART_SHOW_GRID,           // Display grid in the chart
    CHART_SHOW_VOLUMES,        // Display volume in the chart
    CHART_SHOW_OBJECT_DESCR,   // Display textual descriptions of objects (not available for all objects)
    CHART_VISIBLE_BARS,        // The number of bars on the chart that can be displayed
    CHART_WINDOWS_TOTAL,       // The total number of chart windows, including indicator subwindows
    CHART_WINDOW_IS_VISIBLE,   // Visibility of subwindows
    CHART_WINDOW_HANDLE,       // Chart window handle (HWND)
    CHART_WINDOW_YDISTANCE,    // The distance between the upper frame of the indicator subwindow and the upper frame of the main chart window, along the vertical Y axis, in pixels. In case of a mouse event, the cursor coordinates are passed in terms of the coordinates of the main chart window, while the coordinates of graphical objects in an indicator subwindow are set relative to the upper left corner of the subwindow.The value is required for converting the absolute coordinates of the main chart to the local coordinates of a subwindow for correct work with the graphical objects, whose coordinates are set relative to  the upper left corner of the subwindow frame.
    CHART_FIRST_VISIBLE_BAR,   // Number of the first visible bar in the chart. Indexing of bars is the same as for timeseries.
    CHART_WIDTH_IN_BARS,       // Chart width in bars
    CHART_WIDTH_IN_PIXELS,     // Chart width in pixels
    CHART_HEIGHT_IN_PIXELS,    // Chart height in pixels
    CHART_COLOR_BACKGROUND,    // Chart background color
    CHART_COLOR_FOREGROUND,    // Color of axes, scales and OHLC line
    CHART_COLOR_GRID,          // Grid color
    CHART_COLOR_VOLUME,        // Color of volumes and position opening levels
    CHART_COLOR_CHART_UP,      // Color for the up bar, shadows and body borders of bull candlesticks
    CHART_COLOR_CHART_DOWN,    // Color for the down bar, shadows and body borders of bear candlesticks
    CHART_COLOR_CHART_LINE,    // Line chart color and color of "Doji" Japanese candlesticks
    CHART_COLOR_CANDLE_BULL,   // Body color of a bull candlestick
    CHART_COLOR_CANDLE_BEAR,   // Body color of a bear candlestick
    CHART_COLOR_BID,           // Bid price level color
    CHART_COLOR_ASK,           // Ask price level color
    CHART_COLOR_LAST,          // Line color of the last executed deal price (Last)
    CHART_COLOR_STOP_LEVEL,    // Color of stop order levels (Stop Loss and Take Profit)
    CHART_SHOW_TRADE_LEVELS,   // Displaying trade levels in the chart (levels of open positions, Stop Loss, Take Profit and pending orders)
    CHART_DRAG_TRADE_LEVELS,   // Permission to drag trading levels on a chart with a mouse. The drag mode is enabled by default (true value)
    CHART_SHOW_DATE_SCALE,     // Showing the time scale on a chart
    CHART_SHOW_PRICE_SCALE,    // Showing the price scale on a chart
    CHART_SHOW_ONE_CLICK,      // Showing the "One click trading" panel on a chart
    CHART_IS_MAXIMIZED,        // Chart window is maximized
    CHART_IS_MINIMIZED,        // Chart window is minimized
    CHART_IS_DOCKED,           // The chart window is docked. If set to false, the chart can be dragged outside the terminal area
    CHART_FLOAT_LEFT,          // The left coordinate of the undocked chart window relative to the virtual screen
    CHART_FLOAT_TOP,           // The top coordinate of the undocked chart window relative to the virtual screen
    CHART_FLOAT_RIGHT,         // The right coordinate of the undocked chart window relative to the virtual screen
    CHART_FLOAT_BOTTOM         // The bottom coordinate of the undocked chart window relative to the virtual screen
};

enum ENUM_CHART_EVENT
{
    CHARTEVENT_KEYDOWN,        // Keystrokes
    CHARTEVENT_MOUSE_MOVE,     // Mouse move, mouse clicks (if CHART_EVENT_MOUSE_MOVE=true is set for the chart)
    CHARTEVENT_MOUSE_WHEEL,    // Pressing or scrolling the mouse wheel (if CHART_EVENT_MOUSE_WHEEL=True for the chart)
    CHARTEVENT_OBJECT_CREATE,  // Graphical object created (if CHART_EVENT_OBJECT_CREATE=true is set for the chart)
    CHARTEVENT_OBJECT_CHANGE,  // Graphical object property changed via the properties dialog
    CHARTEVENT_OBJECT_DELETE,  // Graphical object deleted (if CHART_EVENT_OBJECT_DELETE=true is set for the chart)
    CHARTEVENT_CLICK,          // Clicking on a chart
    CHARTEVENT_OBJECT_CLICK,   // Clicking on a graphical object
    CHARTEVENT_OBJECT_DRAG,    // Drag and drop of a graphical object
    CHARTEVENT_OBJECT_ENDEDIT, // End of text editing in the graphical object Edit
    CHARTEVENT_CHART_CHANGE,   // Change of the chart size or modification of chart properties through the Properties dialog
    CHARTEVENT_CUSTOM,         // Initial number of an event from a range of custom events
    CHARTEVENT_CUSTOM_LAST     // The final number of an event from a range of custom events
};

enum ENUM_BASE_CORNER
{
    CORNER_LEFT_UPPER,  // Center of coordinates is in the upper left corner of the chart
    CORNER_LEFT_LOWER,  // Center of coordinates is in the lower left corner of the chart
    CORNER_RIGHT_LOWER, // Center of coordinates is in the lower right corner of the chart
    CORNER_RIGHT_UPPER  // Center of coordinates is in the upper right corner of the chart
};

enum ENUM_DRAW_TYPE
{
    DRAW_NONE,             // Not drawn
    DRAW_LINE,             // Line
    DRAW_SECTION,          // Section
    DRAW_HISTOGRAM,        // Histogram from the zero line
    DRAW_HISTOGRAM2,       // Histogram of the two indicator buffers
    DRAW_ARROW,            // Drawing arrows
    DRAW_ZIGZAG,           // Style Zigzag allows vertical section on the bar
    DRAW_FILLING,          // Color fill between the two levels
    DRAW_BARS,             // Display as a sequence of bars
    DRAW_CANDLES,          // Display as a sequence of candlesticks
    DRAW_COLOR_LINE,       // Multicolored line
    DRAW_COLOR_SECTION,    // Multicolored section
    DRAW_COLOR_HISTOGRAM,  // Multicolored histogram from the zero line
    DRAW_COLOR_HISTOGRAM2, // Multicolored histogram of the two indicator buffers
    DRAW_COLOR_ARROW,      // Drawing multicolored arrows
    DRAW_COLOR_ZIGZAG,     // Multicolored ZigZag
    DRAW_COLOR_BARS,       // Multicolored bars
    DRAW_COLOR_CANDLES     // Multicolored candlesticks
};

enum ENUM_DATABASE_OPEN_FLAGS
{
    DATABASE_OPEN_READONLY,  // Read only
    DATABASE_OPEN_READWRITE, // Open for reading and writing
    DATABASE_OPEN_CREATE,    // Create the file on a disk if necessary
    DATABASE_OPEN_MEMORY,    // Create a database in RAM
    DATABASE_OPEN_COMMON     // The file is in the common folder of all terminals
};

enum ENUM_ELLIOT_WAVE_DEGREE
{
    ELLIOTT_GRAND_SUPERCYCLE, // Grand Supercycle
    ELLIOTT_SUPERCYCLE,       // Supercycle
    ELLIOTT_CYCLE,            // Cycle
    ELLIOTT_PRIMARY,          // Primary
    ELLIOTT_INTERMEDIATE,     // Intermediate
    ELLIOTT_MINOR,            // Minor
    ELLIOTT_MINUTE,           // Minute
    ELLIOTT_MINUETTE,         // Minuette
    ELLIOTT_SUBMINUETTE       // Subminuette
};

enum ENUM_GANN_DIRECTION
{
    GANN_UP_TREND,  // Line corresponding to the uptrend line
    GANN_DOWN_TREND // Line corresponding to the downward trend
};

enum ENUM_MQL_INFO_INTEGER
{
    MQL_HANDLES_USED,    // The current number of active object handles. These include both dynamic (created via new) and non-dynamic objects, global/local variables or class members. The more handles a program uses, the more resources it consumes.
    MQL_MEMORY_LIMIT,    // Maximum possible amount of dynamic memory for MQL5 program in MB
    MQL_MEMORY_USED,     // Memory used by MQL5 program in MB
    MQL_PROGRAM_TYPE,    // Type of the MQL5 program
    MQL_DLLS_ALLOWED,    // The permission to use DLL for the given running program
    MQL_TRADE_ALLOWED,   // The permission to trade for the given running program
    MQL_SIGNALS_ALLOWED, // The permission to modify the Signals for the given running program
    MQL_DEBUG,           // Indication that the program is running in the debugging mode
    MQL_PROFILER,        // Indication that the program is running in the code profiling mode
    MQL_TESTER,          // Indication that the program is running in the tester
    MQL_FORWARD,         // Indication that the program is running in the forward testing process
    MQL_OPTIMIZATION,    // Indication that the program is running in the optimization mode
    MQL_VISUAL_MODE,     // Indication that the program is running in the visual testing mode
    MQL_FRAME_MODE,      // Indication that the Expert Advisor is running in gathering optimization result frames mode
    MQL_LICENSE_TYPE     // Type of license of the EX5 module. The license refers to the EX5 module, from which a request is made using MQLInfoInteger(MQL_LICENSE_TYPE).
};

enum ENUM_MQL_INFO_STRING
{
    MQL_PROGRAM_NAME, // Name of the running mql5-program
    MQL_PROGRAM_PATH  // Path for the given running program
};

enum ENUM_PROGRAM_TYPE
{
    PROGRAM_SCRIPT,   // Script
    PROGRAM_EXPERT,   // Expert
    PROGRAM_INDICATOR // Indicator
};

enum ENUM_LICENSE_TYPE
{
    LICENSE_FREE, // A free unlimited version
    LICENSE_DEMO, // A trial version of a paid product from the Market. It works only in the strategy tester
    LICENSE_FULL, // A purchased licensed version allows at least 5 activations. The number of activations is specified by seller.
    LICENSE_TIME  // A version with a limited term license
};

enum ENUM_CHART_MODE
{
    CHART_BARS,    // Display as a sequence of bars
    CHART_CANDLES, // Display as Japanese candlesticks
    CHART_LINE     // Display as a line drawn by Close prices
};

enum ENUM_CHART_VOLUME_MODE
{
    CHART_VOLUME_HIDE, // Volumes are not shown
    CHART_VOLUME_TICK, // Tick volumes
    CHART_VOLUME_REAL  // Trade volumes
};

enum ENUM_CHART_PROPERTY_STRING
{
    CHART_COMMENT,     // Text of a comment in a chart
    CHART_EXPERT_NAME, // The name of the Expert Advisor running on the chart with the specified chart_id
    CHART_SCRIPT_NAME  // The name of the script running on the chart with the specified chart_id
};

enum ENUM_CHART_PROPERTY_DOUBLE
{
    CHART_SHIFT_SIZE,     // The size of the zero bar indent from the right border in percents
    CHART_FIXED_POSITION, // Chart fixed position from the left border in percent value. Chart fixed position is marked by a small gray triangle on the horizontal time axis. It is displayed only if the automatic chart scrolling to the right on tick incoming is disabled (see CHART_AUTOSCROLL property). The bar on a fixed position remains in the same place when zooming in and out.
    CHART_FIXED_MAX,      // Fixed  chart maximum
    CHART_FIXED_MIN,      // Fixed  chart minimum
    CHART_POINTS_PER_BAR, // Scale in points per bar
    CHART_PRICE_MIN,      // Chart minimum
    CHART_PRICE_MAX       // Chart maximum
};

enum ENUM_PLOT_PROPERTY_INTEGER
{
    PLOT_ARROW,         // Arrow code for style DRAW_ARROW
    PLOT_ARROW_SHIFT,   // Vertical shift of arrows for style DRAW_ARROW
    PLOT_DRAW_BEGIN,    // Number of initial bars without drawing and values in the DataWindow
    PLOT_DRAW_TYPE,     // Type of graphical construction
    PLOT_SHOW_DATA,     // Sign of display of construction values in the DataWindow
    PLOT_SHIFT,         // Shift of indicator plotting along the time axis in bars
    PLOT_LINE_STYLE,    // Drawing line style
    PLOT_LINE_WIDTH,    // The thickness of the drawing line
    PLOT_COLOR_INDEXES, // The number of colors
    PLOT_LINE_COLOR     // The index of a buffer containing the drawing color
};

enum ENUM_PLOT_PROPERTY_DOUBLE
{
    PLOT_EMPTY_VALUE // An empty value for plotting, for which there is no drawing
};

enum ENUM_PLOT_PROPERTY_STRING
{
    PLOT_LABEL // The name of the indicator graphical series to display in the DataWindow.
};

enum ENUM_LINE_STYLE
{
    STYLE_SOLID,     // Solid line
    STYLE_DASH,      // Broken line
    STYLE_DOT,       // Dotted line
    STYLE_DASHDOT,   // Dash - dot line
    STYLE_DASHDOTDOT // Dash - two points
};

enum ENUM_INIT_RETCODE
{
    INIT_SUCCEEDED,            // Successful initialization, testing of the Expert Advisor can be continued.
    INIT_FAILED,               // Initialization failed; there is no point in continuing testing because of fatal errors.
    INIT_PARAMETERS_INCORRECT, // This value means the incorrect set of input parameters.
    INIT_AGENT_NOT_SUITABLE,   // No errors during initialization, but for some reason the agent is not suitable for testing.
};

enum ENUM_TERMINAL_INFO_INTEGER
{
    TERMINAL_BUILD,                 // The client terminal build number
    TERMINAL_COMMUNITY_ACCOUNT,     // The flag indicates the presence of MQL5.community authorization data in the terminal
    TERMINAL_COMMUNITY_CONNECTION,  // Connection to MQL5.community
    TERMINAL_CONNECTED,             // Connection to a trade server
    TERMINAL_DLLS_ALLOWED,          // Permission to use DLL
    TERMINAL_TRADE_ALLOWED,         // Permission to trade
    TERMINAL_EMAIL_ENABLED,         // Permission to send e-mails using SMTP-server and login, specified in the terminal settings
    TERMINAL_FTP_ENABLED,           // Permission to send reports using FTP-server and login, specified in the terminal settings
    TERMINAL_NOTIFICATIONS_ENABLED, // Permission to send notifications to smartphone
    TERMINAL_MAXBARS,               // The maximal bars count on the chart
    TERMINAL_MQID,                  // The flag indicates the presence of MetaQuotes ID data for Push notifications
    TERMINAL_CODEPAGE,              // Number of the code page of the language installed in the client terminal
    TERMINAL_CPU_CORES,             // The number of CPU cores in the system
    TERMINAL_DISK_SPACE,            // Free disk space for the MQL5\Files folder of the terminal (agent), MB
    TERMINAL_MEMORY_PHYSICAL,       // Physical memory in the system, MB
    TERMINAL_MEMORY_TOTAL,          // Memory available to the process of the terminal (agent), MB
    TERMINAL_MEMORY_AVAILABLE,      // Free memory of the terminal (agent) process, MB
    TERMINAL_MEMORY_USED,           // Memory used by the terminal (agent), MB
    TERMINAL_X64,                   // Indication of the "64-bit terminal"
    TERMINAL_OPENCL_SUPPORT,        // The version of the supported OpenCL in the format of 0x00010002 = 1.2.  "0" means that OpenCL is not supported
    TERMINAL_SCREEN_DPI,            // The resolution of information display on the screen is measured as number of Dots in a line per Inch (DPI).
    TERMINAL_SCREEN_LEFT,           // The left coordinate of the virtual screen. A virtual screen is a rectangle that covers all monitors. If the system has two monitors ordered from right to left, then the left coordinate of the virtual screen can be on the border of two monitors.
    TERMINAL_SCREEN_TOP,            // The top coordinate of the virtual screen
    TERMINAL_SCREEN_WIDTH,          // Terminal width
    TERMINAL_SCREEN_HEIGHT,         // Terminal height
    TERMINAL_LEFT,                  // The left coordinate of the terminal relative to the virtual screen
    TERMINAL_TOP,                   // The top coordinate of the terminal relative to the virtual screen
    TERMINAL_RIGHT,                 // The right coordinate of the terminal relative to the virtual screen
    TERMINAL_BOTTOM,                // The bottom coordinate of the terminal relative to the virtual screen
    TERMINAL_PING_LAST,             // The last known value of a ping to a trade server in microseconds. One second comprises of one million microseconds
    TERMINAL_VPS,                   // Indication that the terminal is launched on the MetaTrader Virtual Hosting server (MetaTrader VPS)
    TERMINAL_KEYSTATE_LEFT,         // State of the "Left arrow" key
    TERMINAL_KEYSTATE_UP,           // State of the "Up arrow" key
    TERMINAL_KEYSTATE_RIGHT,        // State of the "Right arrow" key
    TERMINAL_KEYSTATE_DOWN,         // State of the "Down arrow" key
    TERMINAL_KEYSTATE_SHIFT,        // State of the "Shift" key
    TERMINAL_KEYSTATE_CONTROL,      // State of the "Ctrl" key
    TERMINAL_KEYSTATE_MENU,         // State of the "Windows" key
    TERMINAL_KEYSTATE_CAPSLOCK,     // State of the "CapsLock" key
    TERMINAL_KEYSTATE_NUMLOCK,      // State of the "NumLock" key
    TERMINAL_KEYSTATE_SCRLOCK,      // State of the "ScrollLock" key
    TERMINAL_KEYSTATE_ENTER,        // State of the "Enter" key
    TERMINAL_KEYSTATE_INSERT,       // State of the "Insert" key
    TERMINAL_KEYSTATE_DELETE,       // State of the "Delete" key
    TERMINAL_KEYSTATE_HOME,         // State of the "Home" key
    TERMINAL_KEYSTATE_END,          // State of the "End" key
    TERMINAL_KEYSTATE_TAB,          // State of the "Tab" key
    TERMINAL_KEYSTATE_PAGEUP,       // State of the "PageUp" key
    TERMINAL_KEYSTATE_PAGEDOWN,     // State of the "PageDown" key
    TERMINAL_KEYSTATE_ESCAPE        // State of the "Escape" key
};

enum ENUM_TERMINAL_INFO_DOUBLE
{
    TERMINAL_COMMUNITY_BALANCE, // Balance in MQL5.community
    TERMINAL_RETRANSMISSION     // Percentage of resent network packets in the TCP/IP protocol for all running applications and services on the given computer.
};

enum ENUM_TERMINAL_INFO_STRING
{
    TERMINAL_LANGUAGE,       // Language of the terminal
    TERMINAL_COMPANY,        // Company name
    TERMINAL_NAME,           // Terminal name
    TERMINAL_PATH,           // Folder from which the terminal is started
    TERMINAL_DATA_PATH,      // Folder in which terminal data are stored
    TERMINAL_COMMONDATA_PATH // Common path for all of the terminals installed on a computer
};

enum ENUM_ARROW_ANCHOR
{
    ANCHOR_TOP,   // Anchor on the top side
    ANCHOR_BOTTOM // Anchor on the bottom side
};

enum ENUM_ACTIVATION_FUNCTION
{
    AF_NONE,         // Activation function not used, input value is passed to the output
    AF_ELU,          // Exponential Linear Unit
    AF_EXP,          // Exponential
    AF_GELU,         // Gaussian Error Linear Unit
    AF_HARD_SIGMOID, // Hard Sigmoid
    AF_LINEAR,       // Linear
    AF_LRELU,        // Leaky Rectified Linear Unit
    AF_RELU,         // Rectified Linear Unit
    AF_SELU,         // Scaled Exponential Linear Unit
    AF_SIGMOID,      // Sigmoid
    AF_SOFTMAX,      // Softmax
    AF_SOFTPLUS,     // Softplus
    AF_SOFTSIGN,     // Softsign
    AF_SWISH,        // Swish function
    AF_TANH,         // Hyperbolic Tangent
    AF_TRELU         // Thresholded Rectified Linear Unit
};

enum ENUM_SORT_MODE
{
    SORT_ASCENDING, // Sort in ascending order
    SORT_DESCENDING // Sort in descending order
};

enum ENUM_MATRIX_AXIS
{
    AXIS_NONE, // Axis not specified
    AXIS_HORZ, // Horizontal axis
    AXIS_VERT  // Vertical axis
};

enum ENUM_VECTOR_CONVOLVE
{
    VECTOR_CONVOLVE_FULL, // Full convolution
    VECTOR_CONVOLVE_SAME, // Convolution with "same" type
    VECTOR_CONVOLVE_VALID // Convolution with "valid" type
};

enum ENUM_MATRIX_NORM
{
    MATRIX_NORM_FROBENIUS, // Frobenius norm
    MATRIX_NORM_SPECTRAL,  // Spectral norm
    MATRIX_NORM_NUCLEAR,   // Nuclear norm
    MATRIX_NORM_INF,       // Infinity norm
    MATRIX_NORM_P1,        // P1 norm
    MATRIX_NORM_P2,        // P2 norm
    MATRIX_NORM_MINUS_INF, // Negative infinity norm
    MATRIX_NORM_MINUS_P1,  // Negative P1 norm
    MATRIX_NORM_MINUS_P2   // Negative P2 norm
};

enum ENUM_REGRESSION_METRIC
{
    REGRESSION_MAE,   // Mean Absolute Error
    REGRESSION_MSE,   // Mean Squared Error
    REGRESSION_RMSE,  // Root Mean Squared Error
    REGRESSION_R2,    // R-Squared
    REGRESSION_MAPE,  // Mean Absolute Percentage Error
    REGRESSION_MSPE,  // Mean Squared Percentage Error
    REGRESSION_RMSLE, // Root Mean Squared Logarithmic Error
    REGRESSION_SMAPE, // Symmetric Mean Absolute Percentage Error
    REGRESSION_MAXE,  // Maximum Absolute Error
    REGRESSION_MEDE,  // Median Absolute Error
    REGRESSION_MPD,   // Mean Poisson Deviance
    REGRESSION_MGD,   // Mean Gamma Deviance
    REGRESSION_EXPV   // Explained Variance
};

enum ENUM_VECTOR_NORM
{
    VECTOR_NORM_INF,       // Infinity norm
    VECTOR_NORM_MINUS_INF, // Negative infinity norm
    VECTOR_NORM_P          // P-norm
};

enum ENUM_LOSS_FUNCTION
{
    LOSS_MSE,       // Mean Squared Error
    LOSS_MAE,       // Mean Absolute Error
    LOSS_CCE,       // Categorical Cross Entropy
    LOSS_BCE,       // Binary Cross Entropy
    LOSS_MAPE,      // Mean Absolute Percentage Error
    LOSS_MSLE,      // Mean Squared Logarithmic Error
    LOSS_KLD,       // Kullback-Leibler Divergence
    LOSS_COSINE,    // Cosine Similarity/Proximity
    LOSS_POISSON,   // Poisson Loss
    LOSS_HINGE,     // Hinge Loss
    LOSS_SQ_HINGE,  // Squared Hinge Loss
    LOSS_CAT_HINGE, // Categorical Hinge Loss
    LOSS_LOG_COSH,  // Log-Cosh Loss
    LOSS_HUBER      // Huber Loss
};

struct MqlCalendarCountry
{
    ulong id;               // country ID (ISO 3166-1)
    string name;            // country text name (in the current terminal encoding)
    string code;            // country code name (ISO 3166-1 alpha-2)
    string currency;        // country currency code
    string currency_symbol; // country currency symbol
    string url_name;        // country name used in the mql5.com website URL
};

struct MqlCalendarEvent
{
    ulong id;                                  // event ID
    ENUM_CALENDAR_EVENT_TYPE type;             // event type from the ENUM_CALENDAR_EVENT_TYPE enumeration
    ENUM_CALENDAR_EVENT_SECTOR sector;         // sector an event is related to
    ENUM_CALENDAR_EVENT_FREQUENCY frequency;   // event frequency
    ENUM_CALENDAR_EVENT_TIMEMODE time_mode;    // event time mode
    ulong country_id;                          // country ID
    ENUM_CALENDAR_EVENT_UNIT unit;             // economic indicator value's unit of measure
    ENUM_CALENDAR_EVENT_IMPORTANCE importance; // event importance
    ENUM_CALENDAR_EVENT_MULTIPLIER multiplier; // economic indicator value multiplier
    uint digits;                               // number of decimal places
    string source_url;                         // URL of a source where an event is published
    string event_code;                         // event code
    string name;                               // event text name in the terminal language (in the current terminal encoding)
};

struct MqlCalendarValue
{
    ulong id;                               // value ID
    ulong event_id;                         // event ID
    datetime time;                          // event date and time
    datetime period;                        // event reporting period
    int revision;                           // revision of the published indicator relative to the reporting period
    long actual_value;                      // actual value multiplied by 10^6 or LONG_MIN if the value is not set
    long prev_value;                        // previous value multiplied by 10^6 or LONG_MIN if the value is not set
    long revised_prev_value;                // revised previous value multiplied by 10^6 or LONG_MIN if the value is not set
    long forecast_value;                    // forecast value multiplied by 10^6 or LONG_MIN if the value is not set
    ENUM_CALENDAR_EVENT_IMPACT impact_type; // potential impact on the currency rate
                                            //--- functions checking the values
    bool HasActualValue(void) const;        // returns true if actual_value is set
    bool HasPreviousValue(void) const;      // returns true if prev_value is set
    bool HasRevisedValue(void) const;       // returns true if revised_prev_value is set
    bool HasForecastValue(void) const;      // returns true if forecast_value is set
                                            //--- functions receiving the values
    double GetActualValue(void) const;      // returns actual_value or nan if the value is no set
    double GetPreviousValue(void) const;    // returns prev_value or nan if the value is no set
    double GetRevisedValue(void) const;     // returns revised_prev_value or nan if the value is no set
    double GetForecastValue(void) const;    // returns forecast_value or nan if the value is no set
};

struct MqlRates
{
    datetime time;    // Period start time
    double open;      // Open price
    double high;      // The highest price of the period
    double low;       // The lowest price of the period
    double close;     // Close price
    long tick_volume; // Tick volume
    int spread;       // Spread
    long real_volume; // Trade volume
};

struct MqlTick
{
    datetime time;      // Time of the last prices update
    double bid;         // Current Bid price
    double ask;         // Current Ask price
    double last;        // Price of the last deal (Last)
    ulong volume;       // Volume for the current Last price
    long time_msc;      // Time of a price last update in milliseconds
    uint flags;         // Tick flags
    double volume_real; // Volume for the current Last price with greater accuracy
};

struct MqlBookInfo
{
    ENUM_BOOK_TYPE type; // Order type from ENUM_BOOK_TYPE enumeration
    double price;        // Price
    long volume;         // Volume
    double volume_real;  // Volume with greater accuracy
};

struct DXVertexLayout
{
    string semantic_name;  // The HLSL semantic associated with this element in a shader input-signature.
    uint semantic_index;   // The semantic index for the element. A semantic index modifies a semantic, with an integer index number. A semantic index is only needed in a case where there is more than one element with the same semantic
    ENUM_DX_FORMAT format; // The data type of the element data.
};

struct MqlParam
{
    ENUM_DATATYPE type;  // type of the input parameter, value of ENUM_DATATYPE
    long integer_value;  // field to store an integer type
    double double_value; // field to store a double type
    string string_value; // field to store a string type
};

struct MqlTradeTransaction
{
    ulong deal;                       // Deal ticket
    ulong order;                      // Order ticket
    string symbol;                    // Trade symbol name
    ENUM_TRADE_TRANSACTION_TYPE type; // Trade transaction type
    ENUM_ORDER_TYPE order_type;       // Order type
    ENUM_ORDER_STATE order_state;     // Order state
    ENUM_DEAL_TYPE deal_type;         // Deal type
    ENUM_ORDER_TYPE_TIME time_type;   // Order type by action period
    datetime time_expiration;         // Order expiration time
    double price;                     // Price
    double price_trigger;             // Stop limit order activation price
    double price_sl;                  // Stop Loss level
    double price_tp;                  // Take Profit level
    double volume;                    // Volume in lots
    ulong position;                   // Position ticket
    ulong position_by;                // Ticket of an opposite position
};

struct MqlTradeRequest
{
    ENUM_TRADE_REQUEST_ACTIONS action;    // Trade operation type
    ulong magic;                          // Expert Advisor ID (magic number)
    ulong order;                          // Order ticket
    string symbol;                        // Trade symbol
    double volume;                        // Requested volume for a deal in lots
    double price;                         // Price
    double stoplimit;                     // StopLimit level of the order
    double sl;                            // Stop Loss level of the order
    double tp;                            // Take Profit level of the order
    ulong deviation;                      // Maximal possible deviation from the requested price
    ENUM_ORDER_TYPE type;                 // Order type
    ENUM_ORDER_TYPE_FILLING type_filling; // Order execution type
    ENUM_ORDER_TYPE_TIME type_time;       // Order expiration type
    datetime expiration;                  // Order expiration time (for the orders of ORDER_TIME_SPECIFIED type)
    string comment;                       // Order comment
    ulong position;                       // Position ticket
    ulong position_by;                    // The ticket of an opposite position
};

struct MqlTradeResult
{
    uint retcode;          // Operation return code
    ulong deal;            // Deal ticket, if it is performed
    ulong order;           // Order ticket, if it is placed
    double volume;         // Deal volume, confirmed by broker
    double price;          // Deal price, confirmed by broker
    double bid;            // Current Bid price
    double ask;            // Current Ask price
    string comment;        // Broker comment to operation (by default it is filled by description of trade server return code)
    uint request_id;       // Request ID set by the terminal during the dispatch
    uint retcode_external; // Return code of an external trading system
};

struct MqlTradeCheckResult
{
    uint retcode;        // Reply code
    double balance;      // Balance after the execution of the deal
    double equity;       // Equity after the execution of the deal
    double profit;       // Floating profit
    double margin;       // Margin requirements
    double margin_free;  // Free margin
    double margin_level; // Margin level
    string comment;      // Comment to the reply code (description of the error)
};

struct MqlDateTime
{
    int year;        // Year
    int mon;         // Month
    int day;         // Day
    int hour;        // Hour
    int min;         // Minutes
    int sec;         // Seconds
    int day_of_week; // Day of week (0-Sunday, 1-Monday, ... ,6-Saturday)
    int day_of_year; // Day number of the year (January 1st is assigned the number value of zero)
};

/** The _AppliedTo variable allows finding out the type of data, used for indicator calculation.
 */
int _AppliedTo = 0;

/** The _LastError variable contains code of the last error, that occurred during the mql5-program run.
 */
int _LastError = 0;

/** The _Period variable contains the value of the timeframe of the current chart.
 */
int _Period = 0;

/** Variable for storing the current state when generating pseudo-random integers.
 */
int _RandomSeed = 0;

/** The _StopFlag variable contains the flag of the mql5-program stop.
 */
bool _StopFlag = 0;

/** The _UninitReason variable contains the code of the program uninitialization reason.
 */
int _UninitReason = 0;

/** The _IsX64 variable allows finding out the bit version of the terminal, in which an MQL5 application is running.
 */
int _IsX64 = 0;

/** Absence of color
 */
const int clrNONE = -1, CLR_NONE = -1;

/** Path to the file of an image that will be used as an icon of the EX5 program.
 */
string icon;

/** Link to the company website
 */
string link;

/** The company name
 */
string copyright;

/** Program version, maximum 31 characters
 */
string version;

/** Brief text description of a mql5-program.
 */
string description;

/** MQL5 program stack size. The stack of sufficient size is necessary when executing function recursive calls.
 */
int stacksize;

/** A library; no start function is assigned, functions with the export modifier can be imported in other mql5-programs
 */
int library;

/** Specifies the default value for the "Apply to" field.
 */
int indicator_applied_price;

/** Show the indicator in the chart window
 */
int indicator_chart_window;

/**Show the indicator in a separate window
 */
int indicator_separate_window;

/** Fixed height of the indicator subwindow in pixels (property INDICATOR_HEIGHT)
 */
int indicator_height;

/** Number of buffers for indicator calculation
 */
int indicator_buffers;

/** Number of graphic series in the indicator
 */
int indicator_plots;

/** The bottom scaling limit for a separate indicator window
 */
double indicator_minimum;

/** The top scaling limit for a separate indicator window
 */
double indicator_maximum;

/** Sets a label for the N-th graphic series displayed in DataWindow.
 */
string indicator_labelN;

/** The color for displaying line N, where N is the number of graphic series; numbering starts from 1
 */
color indicator_colorN;

/** Line thickness in graphic series, where N is the number of graphic series; numbering starts from 1
 */
int indicator_widthN;

/** Line style in graphic series, specified by the values of ENUM_LINE_STYLE. N is the number of graphic series; numbering starts from 1
 */
int indicator_styleN;

/** Type of graphical plotting, specified by the values of ENUM_DRAW_TYPE. N is the number of graphic series; numbering starts from 1
 */
int indicator_typeN;

/** Horizontal level of N in a separate indicator window
 */
double indicator_levelN;

/** Color of horizontal levels of the indicator
 */
color indicator_levelcolor;

/** Thickness of horizontal levels of the indicator
 */
int indicator_levelwidth;

/** Style of horizontal levels of the indicator
 */
int indicator_levelstyle;

/** Display a confirmation window before running the script
 */
int script_show_confirm;

/** Display a window with the properties before running the script and disable this confirmation window
 */
int script_show_inputs;

/** Name of a custom indicator in the format of "indicator_name.ex5"
 */
string tester_indicator;

/** File name for a tester with the indication of extension, in double quotes (as a constant string).
 */
string tester_file;

/** Library name with the extension, in double quotes. A library can have 'dll' or 'ex5' as file extension.
 */
string tester_library;

/** Name of the set file with the values ​​and the step of the input parameters.
 */
string tester_set;

/** When performing optimization, the strategy tester saves all results of executed passes to the optimization cache, in which the test result is saved for each set of the input parameters.
 */
string tester_no_cache;

/** In the Strategy Tester, indicators are only calculated when their data are accessed, i.e. when the values of indicator buffers are requested.
 */
string tester_everytick_calculate;

/** Specifies the chart type and the names of two input parameters which will be used for the visualization of optimization results.
 */
string optimization_chart_mode;

int ARRAYPRINT_HEADER = 0;  // print headers for the structure array
int ARRAYPRINT_INDEX = 1;   // print index at the left side
int ARRAYPRINT_LIMIT = 2;   // print only the first 100 and the last 100 array elements. Use if you want to print only a part of a large array.
int ARRAYPRINT_ALIGN = 3;   // enable alignment of the printed values – numbers are aligned to the right, while lines to the left.
int ARRAYPRINT_DATE = 4;    // when printing datetime, print the date in the dd.mm.yyyy format
int ARRAYPRINT_MINUTES = 5; // when printing datetime, print the time in the HH:MM format
int ARRAYPRINT_SECONDS = 6; // when printing datetime, print the time in the HH:MM:SS format

int TIME_DATE = 0;    // gets result as "yyyy.mm.dd"
int TIME_MINUTES = 1; // gets result as "hh:mi"
int TIME_SECONDS = 2; // gets results as "hh:mi:ss".

/** Signature of the function in whose body the macro is located. Logging of the full description of functions can be useful in the identification of overloaded functions
 */
int __FUNCSIG__;

/** Compiler build number
 */
int __MQLBUILD__, __MQL5BUILD__;

/** An absolute path to the file that is currently being compiled
 */
int __PATH__;

/** Main line
 */
const int BASE_LINE = 0;

/** Maximal value, which can be represented by char type
 */
const char CHAR_MAX = 127;

/** Minimal value, which can be represented by char type
 */
const char CHAR_MIN = -128;

/** The maximum possible number of simultaneously open charts in the terminal
 */
const int CHARTS_MAX = 100;

/** Chikou Span line
 */
const int CHIKOUSPAN_LINE = 4;

/** The current Windows ANSI code page.
 */
int CP_ACP = 0;

/** The current system Macintosh code page.
Note: This value is mostly used in earlier created program codes and is of no use now, since modern Macintosh computers use Unicode for encoding.
 */
const int CP_MACCP = 2;

/** The current system OEM code page.
 */
const int CP_OEMCP = 1;

/** Symbol code page
 */
const int CP_SYMBOL = 42;

/** The Windows ANSI code page for the current thread.
 */
const int CP_THREAD_ACP = 3;

/** UTF-7 code page.
 */
const int CP_UTF7 = 7;

/** UTF-8 code page.
 */
const int CP_UTF8 = 8;

/** Number of significant decimal digits for double type
 */
const int DBL_DIG = 15;

/** Minimal value, which satisfies the condition: 1.0+DBL_EPSILON != 1.0 (for double type)
 */
const float DBL_EPSILON;

/** Bits count in a mantissa for double type
 */
const int DBL_MANT_DIG;

/** Maximal value, which can be represented by double type
 */
const float DBL_MAX = 1.7976931348623158e+308;

/** Maximal decimal value of exponent degree for double type
 */
const int DBL_MAX_10_EXP;

/** Maximal binary value of exponent degree for double type
 */
const int DBL_MAX_EXP;

/** Minimal positive value, which can be represented by double type
 */
const float DBL_MIN;

/** Minimal decimal value of exponent degree for double type
 */
const int DBL_MIN_10_EXP;

/** Minimal binary value of exponent degree for double type
 */
const int DBL_MIN_EXP;

/** Empty value in an indicator buffer
 */
const float EMPTY_VALUE = DBL_MAX;

/** Wrong account property ID
 */
int ERR_ACCOUNT_WRONG_PROPERTY = 4701;

/** Requested array size exceeds 2 GB
 */
int ERR_ARRAY_BAD_SIZE = 4011;

/** Not enough memory for the relocation of an array, or an attempt to change the size of a static array
 */
int ERR_ARRAY_RESIZE_ERROR = 4007;

/** Depth Of Market can not be added
 */
int ERR_BOOKS_CANNOT_ADD = 4901;

/** Depth Of Market can not be removed
 */
int ERR_BOOKS_CANNOT_DELETE = 4902;

/** The data from Depth Of Market can not be obtained
 */
int ERR_BOOKS_CANNOT_GET = 4902;

/** Error in subscribing to receive new data from Depth Of Market
 */
int ERR_BOOKS_CANNOT_SUBSCRIBE = 4904;

/** Not enough memory for the distribution of indicator buffers
 */
int ERR_BUFFERS_NO_MEMORY = 4601;

/** Wrong indicator buffer index
 */
int ERR_BUFFERS_WRONG_INDEX = 4602;

/** Failed to clear the directory (probably one or more files are blocked and removal operation failed)
 */
int ERR_CANNOT_CLEAN_DIRECTORY = 5025;

/** The directory cannot be removed
 */
int ERR_CANNOT_DELETE_DIRECTORY = 5024;

/** File deleting error
 */
int ERR_CANNOT_DELETE_FILE = 5006;

/** File opening error
 */
int ERR_CANNOT_OPEN_FILE = 5004;

/** Must be an array of type char
 */
int ERR_CHAR_ARRAY_ONLY = 5062;

/** Failed to change chart symbol and period
 */
int ERR_CHART_CANNOT_CHANGE = 4106;

/** Failed to create timer
 */
int ERR_CHART_CANNOT_CREATE_TIMER = 4108;

/** Chart opening error
 */
int ERR_CHART_CANNOT_OPEN = 4105;

/** Error adding an indicator to chart
 */
int ERR_CHART_INDICATOR_CANNOT_ADD = 4114;

/** Error deleting an indicator from the chart
 */
int ERR_CHART_INDICATOR_CANNOT_DEL = 4115;

/** Indicator not found on the specified chart
 */
int ERR_CHART_INDICATOR_NOT_FOUND = 4116;

/** Error navigating through chart
 */
int ERR_CHART_NAVIGATE_FAILED = 4111;

/** No Expert Advisor in the chart that could handle the event
 */
int ERR_CHART_NO_EXPERT = 4104;

/** Chart does not respond
 */
int ERR_CHART_NO_REPLY = 4102;

/** Chart not found
 */
int ERR_CHART_NOT_FOUND = 4103;

/** Error creating screenshots
 */
int ERR_CHART_SCREENSHOT_FAILED = 4110;

/** Error applying template
 */
int ERR_CHART_TEMPLATE_FAILED = 4112;

/** Subwindow containing the indicator was not found
 */
int ERR_CHART_WINDOW_NOT_FOUND = 4113;

/** Wrong chart ID
 */
int ERR_CHART_WRONG_ID = 4101;

/** Error value of the parameter for the function of working with charts
 */
int ERR_CHART_WRONG_PARAMETER = 4107;

/** Wrong chart property ID
 */
int ERR_CHART_WRONG_PROPERTY = 4109;

/** Wrong ID of the custom indicator property
 */
int ERR_CUSTOM_WRONG_PROPERTY = 4603;

/** Directory does not exist
 */
int ERR_DIRECTORY_NOT_EXIST = 5022;

/** Must be an array of type double
 */
int ERR_DOUBLE_ARRAY_ONLY = 5057;

/** String size must be specified, because the file is opened as binary
 */
int ERR_FILE_BINSTRINGSIZE = 5016;

/** Not enough memory for cache to read
 */
int ERR_FILE_CACHEBUFFER_ERROR = 5005;

/** File can not be rewritten
 */
int ERR_FILE_CANNOT_REWRITE = 5020;

/** This is not a file, this is a directory
 */
int ERR_FILE_IS_DIRECTORY = 5018;

/** This is a file, not a directory
 */
int ERR_FILE_ISNOT_DIRECTORY = 5023;

/** File does not exist
 */
int ERR_FILE_NOT_EXIST = 5019;

/** The file must be opened as a binary one
 */
int ERR_FILE_NOTBIN = 5011;

/** The file must be opened as CSV
 */
int ERR_FILE_NOTCSV = 5014;

/** The file must be opened for reading
 */
int ERR_FILE_NOTTOREAD = 5010;

/** The file must be opened for writing
 */
int ERR_FILE_NOTTOWRITE = 5009;

/** The file must be opened as a text
 */
int ERR_FILE_NOTTXT = 5012;

/** The file must be opened as a text or CSV
 */
int ERR_FILE_NOTTXTORCSV = 5013;

/** File reading error
 */
int ERR_FILE_READERROR = 5015;

/** Failed to write a resource to a file
 */
int ERR_FILE_WRITEERROR = 5026;

/** Must be an array of type float
 */
int ERR_FLOAT_ARRAY_ONLY = 5058;

/** File sending via ftp failed
 */
int ERR_FTP_SEND_FAILED = 4514;

/** Function is not allowed for call
 */
int ERR_FUNCTION_NOT_ALLOWED = 4014;

/** Global variable of the client terminal with the same name already exists
 */
int ERR_GLOBALVARIABLE_EXISTS = 4502;

/** Global variable of the client terminal is not found
 */
int ERR_GLOBALVARIABLE_NOT_FOUND = 4501;

/** Requested history not found
 */
int ERR_HISTORY_NOT_FOUND = 4401;

/** Wrong ID of the history property
 */
int ERR_HISTORY_WRONG_PROPERTY = 4402;

/** Copying incompatible arrays. String array can be copied only to a string array, and a numeric array - in numeric array only
 */
int ERR_INCOMPATIBLE_ARRAYS = 5050;

/** A text file must be for string arrays, for other arrays - binary
 */
int ERR_INCOMPATIBLE_FILE = 5017;

/** Error applying an indicator to chart
 */
int ERR_INDICATOR_CANNOT_ADD = 4805;

/** The indicator cannot be applied to another indicator
 */
int ERR_INDICATOR_CANNOT_APPLY = 4804;

/** Indicator cannot be created
 */
int ERR_INDICATOR_CANNOT_CREATE = 4802;

/** The first parameter in the array must be the name of the custom indicator
 */
int ERR_INDICATOR_CUSTOM_NAME = 4810;

/** Requested data not found
 */
int ERR_INDICATOR_DATA_NOT_FOUND = 4806;

/** Not enough memory to add the indicator
 */
int ERR_INDICATOR_NO_MEMORY = 4803;

/** Invalid parameter type in the array when creating an indicator
 */
int ERR_INDICATOR_PARAMETER_TYPE = 4811;

/** No parameters when creating an indicator
 */
int ERR_INDICATOR_PARAMETERS_MISSING = 4809;

/** Unknown symbol
 */
int ERR_INDICATOR_UNKNOWN_SYMBOL = 4801;

/** Wrong indicator handle
 */
int ERR_INDICATOR_WRONG_HANDLE = 4807;

/** Wrong index of the requested indicator buffer
 */
int ERR_INDICATOR_WRONG_INDEX = 4812;

/** Wrong number of parameters when creating an indicator
 */
int ERR_INDICATOR_WRONG_PARAMETERS = 4808;

/** Must be an array of type int
 */
int ERR_INT_ARRAY_ONLY = 5060;

/** Unexpected internal error
 */
int ERR_INTERNAL_ERROR = 4001;

/** Array of a wrong type, wrong size, or a damaged object of a dynamic array
 */
int ERR_INVALID_ARRAY = 4006;

/** Invalid date and/or time
 */
int ERR_INVALID_DATETIME = 4010;

/** A file with this handle was closed, or was not opening at all
 */
int ERR_INVALID_FILEHANDLE = 5007;

/** Wrong parameter when calling the system function
 */
int ERR_INVALID_PARAMETER = 4003;

/** Wrong pointer
 */
int ERR_INVALID_POINTER = 4012;

/** Wrong type of pointer
 */
int ERR_INVALID_POINTER_TYPE = 4013;

/** Must be an array of type long
 */
int ERR_LONG_ARRAY_ONLY = 5059;

/** Email sending failed
 */
int ERR_MAIL_SEND_FAILED = 4510;

/** Time of the last tick is not known (no ticks)
 */
int ERR_MARKET_LASTTIME_UNKNOWN = 4304;

/** Symbol is not selected in MarketWatch
 */
int ERR_MARKET_NOT_SELECTED = 4302;

/** Error adding or deleting a symbol in MarketWatch
 */
int ERR_MARKET_SELECT_ERROR = 4305;

/** Unknown symbol
 */
int ERR_MARKET_UNKNOWN_SYMBOL = 4301;

/** Wrong identifier of a symbol property
 */
int ERR_MARKET_WRONG_PROPERTY = 4303;

/** Wrong identifier of the program property
 */
int ERR_MQL5_WRONG_PROPERTY = 4512;

/** No date in the string
 */
int ERR_NO_STRING_DATE = 5030;

/** Not enough memory to perform the system function
 */
int ERR_NOT_ENOUGH_MEMORY = 4004;

/** Failed to send a notification
 */
int ERR_NOTIFICATION_SEND_FAILED = 4515;

/** Too frequent sending of notifications
 */
int ERR_NOTIFICATION_TOO_FREQUENT = 4518;

/** Invalid parameter for sending a notification – an empty string or NULL has been passed to the SendNotification() function
 */
int ERR_NOTIFICATION_WRONG_PARAMETER = 4516;

/** Wrong settings of notifications in the terminal (ID is not specified or permission is not set)
 */
int ERR_NOTIFICATION_WRONG_SETTINGS = 4517;

/** Not initialized string
 */
int ERR_NOTINITIALIZED_STRING = 4009;

/** Must be a numeric array
 */
int ERR_NUMBER_ARRAYS_ONLY = 5054;

/** Error working with a graphical object
 */
int ERR_OBJECT_ERROR = 4201;

/** Unable to get date corresponding to the value
 */
int ERR_OBJECT_GETDATE_FAILED = 4204;

/** Unable to get value corresponding to the date
 */
int ERR_OBJECT_GETVALUE_FAILED = 4205;

/** Graphical object was not found
 */
int ERR_OBJECT_NOT_FOUND = 4202;

/** Wrong ID of a graphical object property
 */
int ERR_OBJECT_WRONG_PROPERTY = 4203;

/** Must be a one-dimensional array
 */
int ERR_ONEDIM_ARRAYS_ONLY = 5055;

/** Failed to create an OpenCL buffer
 */
int ERR_OPENCL_BUFFER_CREATE = 5112;

/** Error creating the OpenCL context
 */
int ERR_OPENCL_CONTEXT_CREATE = 5103;

/** OpenCL program runtime error
 */
int ERR_OPENCL_EXECUTE = 5109;

/** Internal error occurred when running OpenCL
 */
int ERR_OPENCL_INTERNAL = 5101;

/** Invalid OpenCL handle
 */
int ERR_OPENCL_INVALID_HANDLE = 5102;

/** Error creating an OpenCL kernel
 */
int ERR_OPENCL_KERNEL_CREATE = 5107;

/** OpenCL functions are not supported on this computer
 */
int ERR_OPENCL_NOT_SUPPORTED = 5100;

/** Error occurred when compiling an OpenCL program
 */
int ERR_OPENCL_PROGRAM_CREATE = 5105;

/** Failed to create a run queue in OpenCL
 */
int ERR_OPENCL_QUEUE_CREATE = 5104;

/** Error occurred when setting parameters for the OpenCL kernel
 */
int ERR_OPENCL_SET_KERNEL_PARAMETER = 5108;

/** Too long kernel name (OpenCL kernel)
 */
int ERR_OPENCL_TOO_LONG_KERNEL_NAME = 5106;

/** Invalid offset in the OpenCL buffer
 */
int ERR_OPENCL_WRONG_BUFFER_OFFSET = 5111;

/** Invalid size of the OpenCL buffer
 */
int ERR_OPENCL_WRONG_BUFFER_SIZE = 5110;

/** Sound playing failed
 */
int ERR_PLAY_SOUND_FAILED = 4511;

/** The names of the dynamic and the static resource match
 */
int ERR_RESOURCE_NAME_DUPLICATED = 4015;

/** The resource name exceeds 63 characters
 */
int ERR_RESOURCE_NAME_IS_TOO_LONG = 4018;

/** Resource with this name has not been found in EX5
 */
int ERR_RESOURCE_NOT_FOUND = 4016;

/** Unsupported resource type or its size exceeds 16 Mb
 */
int ERR_RESOURCE_UNSUPPOTED_TYPE = 4017;

/** Timeseries cannot be used
 */
int ERR_SERIES_ARRAY = 5056;

/** Must be an array of type short
 */
int ERR_SHORT_ARRAY_ONLY = 5061;

/** Too small array, the starting position is outside the array
 */
int ERR_SMALL_ARRAY = 5052;

/** The receiving array is declared as AS_SERIES, and it is of insufficient size
 */
int ERR_SMALL_ASSERIES_ARRAY = 5051;

/** Not enough memory for the string
 */
int ERR_STRING_OUT_OF_MEMORY = 5034;

/** Not enough memory for the relocation of string
 */
int ERR_STRING_RESIZE_ERROR = 4008;

/** The string length is less than expected
 */
int ERR_STRING_SMALL_LEN = 5035;

/** Error converting string to date
 */
int ERR_STRING_TIME_ERROR = 5033;

/** Too large number, more than ULONG_MAX
 */
int ERR_STRING_TOO_BIGNUMBER = 5036;

/** Unknown data type when converting to a string
 */
int ERR_STRING_UNKNOWNTYPE = 5043;

/** 0 added to the string end, a useless operation
 */
int ERR_STRING_ZEROADDED = 5042;

/** Position outside the string
 */
int ERR_STRINGPOS_OUTOFRANGE = 5041;

/** The structure contains objects of strings and/or dynamic arrays and/or structure of such objects and/or classes
 */
int ERR_STRUCT_WITHOBJECTS_ORCLASS = 4005;

/** The operation completed successfully
 */
int ERR_SUCCESS = 0;

/** Wrong identifier of the terminal property
 */
int ERR_TERMINAL_WRONG_PROPERTY = 4513;

/** Too long file name
 */
int ERR_TOO_LONG_FILENAME = 5003;

/** More than 64 files cannot be opened at the same time
 */
int ERR_TOO_MANY_FILES = 5001;

/** Amount of format specifiers more than the parameters
 */
int ERR_TOO_MANY_FORMATTERS = 5038;

/** Amount of parameters more than the format specifiers
 */
int ERR_TOO_MANY_PARAMETERS = 5039;

/** Deal not found
 */
int ERR_TRADE_DEAL_NOT_FOUND = 4755;

/** Trading by Expert Advisors prohibited
 */
int ERR_TRADE_DISABLED = 4752;

/** Order not found
 */
int ERR_TRADE_ORDER_NOT_FOUND = 4754;

/** Position not found
 */
int ERR_TRADE_POSITION_NOT_FOUND = 4753;

/** Trade request sending failed
 */
int ERR_TRADE_SEND_FAILED = 4756;

/** Wrong trade property ID
 */
int ERR_TRADE_WRONG_PROPERTY = 4751;

/** User defined errors start with this code
 */
int ERR_USER_ERROR_FIRST = 65536;

/** Failed to connect to specified URL
 */
int ERR_WEBREQUEST_CONNECT_FAILED = 5201;

/** Invalid URL
 */
int ERR_WEBREQUEST_INVALID_ADDRESS = 5200;

/** HTTP request failed
 */
int ERR_WEBREQUEST_REQUEST_FAILED = 5203;

/** Timeout exceeded
 */
int ERR_WEBREQUEST_TIMEOUT = 5202;

/** Wrong directory name
 */
int ERR_WRONG_DIRECTORYNAME = 5021;

/** Wrong file handle
 */
int ERR_WRONG_FILEHANDLE = 5008;

/** Invalid file name
 */
int ERR_WRONG_FILENAME = 5002;

/** Invalid format string
 */
int ERR_WRONG_FORMATSTRING = 5037;

/** Wrong parameter in the inner call of the client terminal function
 */
int ERR_WRONG_INTERNAL_PARAMETER = 4002;

/** Wrong date in the string
 */
int ERR_WRONG_STRING_DATE = 5031;

/** Damaged string object
 */
int ERR_WRONG_STRING_OBJECT = 5044;

/** Damaged parameter of string type
 */
int ERR_WRONG_STRING_PARAMETER = 5040;

/** Wrong time in the string
 */
int ERR_WRONG_STRING_TIME = 5032;

/** An array of zero length
 */
int ERR_ZEROSIZE_ARRAY = 5053;

/** Strings of ANSI type (one byte symbols). Flag is used in FileOpen().
 */
const int FILE_ANSI = 32;

/** Binary read/write mode (without string to string conversion). Flag is used in FileOpen().
 */
const int FILE_BIN = 4;

/** The file path in the common folder of all client terminals \Terminal\Common\Files. Flag is used in FileOpen(), FileCopy(), FileMove() and in FileIsExist() functions.
 */
const int FILE_COMMON = 4096;

/** CSV file (all its elements are converted to strings of the appropriate type, Unicode or ANSI, and separated by separator). Flag is used in FileOpen().
 */
const int FILE_CSV = 8;

/** File is opened for reading. Flag is used in FileOpen(). When opening a file specification of FILE_WRITE and/or FILE_READ is required.
 */
const int FILE_READ = 1;

/** Possibility for the file rewrite using functions FileCopy() and FileMove(). The file should exist or should be opened for writing, otherwise the file will not be opened.
 */
const int FILE_REWRITE = 512;

/** Shared access for reading from several programs. Flag is used in FileOpen(), but it does not replace the necessity to indicate FILE_WRITE and/or the FILE_READ flag when opening a file.
 */
const int FILE_SHARE_READ = 128;

/** Shared access for writing from several programs. Flag is used in FileOpen(), but it does not replace the necessity to indicate FILE_WRITE and/or the FILE_READ flag when opening a file.
 */
const int FILE_SHARE_WRITE = 256;

/** Simple text file (the same as csv file, but without taking into account the separators). Flag is used in FileOpen().
 */
const int FILE_TXT = 16;

/** Strings of UNICODE type (two byte symbols). Flag is used in FileOpen().
 */
const int FILE_UNICODE = 64;

/** File is opened for writing. Flag is used in FileOpen(). When opening a file specification of FILE_WRITE and/or FILE_READ is required.
 */
const int FILE_WRITE = 2;

/** Number of significant decimal digits for float type
 */
const int FLT_DIG = 6;

/** Minimal value, which satisfies the condition: 1.0+DBL_EPSILON != 1.0 (for float type)
 */
const float FLT_EPSILON;

/** Bits count in a mantissa for float type
 */
const int FLT_MANT_DIG = 24;

/** Maximal value, which can be represented by float type
 */
const float FLT_MAX;

/** Maximal decimal value of exponent degree for float type
 */
const int FLT_MAX_10_EXP = 38;

/** Maximal binary value of exponent degree for float type
 */
const int FLT_MAX_EXP = 128;

/** Minimal positive value, which can be represented by float type
 */
const float FLT_MIN;

/** Minimal decimal value of exponent degree for float type
 */
const int FLT_MIN_10_EXP = -37;

/** Minimal binary value of exponent degree for float type
 */
const int FLT_MIN_EXP = (-125);

/** Jaw line
 */
const int GATORJAW_LINE = 0;

/** Lips line
 */
const int GATORLIPS_LINE = 2;

/** Teeth line
 */
const int GATORTEETH_LINE = 1;

/** "Abort" button has been pressed
 */
const int IDABORT = 3;

/** "Cancel" button has been pressed
 */
const int IDCANCEL = 2;

/** "Continue" button has been pressed
 */
const int IDCONTINUE = 11;

/** "Ignore" button has been pressed
 */
const int IDIGNORE = 5;

/** "No" button has been pressed
 */
const int IDNO = 7;

/** "OK" button has been pressed
 */
const int IDOK = 1;

/** "Retry" button has been pressed
 */
const int IDRETRY = 4;

/** "Try Again" button has been pressed
 */
const int IDTRYAGAIN = 10;

/** "Yes" button has been pressed
 */
const int IDYES = 6;

/** Maximal value, which can be represented by int type
 */
const int INT_MAX = 2147483647;

/** Minimal value, which can be represented by int type
 */
const int INT_MIN = -2147483648;

/** Incorrect handle
 */
const int INVALID_HANDLE = -1;

/** Flag that a mq5-program operates in debug mode
 */
const int IS_DEBUG_MODE = 0;

/** Flag that a mq5-program operates in profiling mode
 */
const int IS_PROFILE_MODE = 0;

/** Kijun-sen line
 */
const int KIJUNSEN_LINE = 1;

/** Maximal value, which can be represented by long type
 */
const long LONG_MAX = 9223372036854775807;

/** Minimal value, which can be represented by long type
 */
const long LONG_MIN = -9223372036854775808;

/** Lower limit
 */
const int LOWER_BAND = 2;

/** Bottom histogram
 */
const int LOWER_HISTOGRAM = 2;

/** Bottom line
 */
const int LOWER_LINE = 1;

/** 1/pi
 */
const float M_1_PI = 0.318309886183790671538;

/** 2/pi
 */
const float M_2_PI = 0.636619772367581343076;

/** 2/sqrt(pi)
 */
const float M_2_SQRTPI = 1.12837916709551257390;

/** e
 */
const float M_E = 2.71828182845904523536;

/** ln(10)
 */
const float M_LN10 = 2.30258509299404568402;

/** ln(2)
 */
const float M_LN2 = 0.693147180559945309417;

/** log10(e)
 */
const float M_LOG10E = 0.434294481903251827651;

/** log2(e)
 */
const float M_LOG2E = 1.44269504088896340736;

/** pi
 */
const float M_PI = 3.14159265358979323846;

/** pi/2
 */
const float M_PI_2 = 1.57079632679489661923;

/** pi/4
 */
const float M_PI_4 = 0.785398163397448309616;

/** 1/sqrt(2)
 */
const float M_SQRT1_2 = 0.707106781186547524401;

/** sqrt(2)
 */
const float M_SQRT2 = 1.41421356237309504880;

/** Main line
 */
const int MAIN_LINE = 0;

/** Message window contains three buttons: Abort, Retry and Ignore
 */
const int MB_ABORTRETRYIGNORE = 0x00000002;

/** Message window contains three buttons: Cancel, Try Again, Continue
 */
const int MB_CANCELTRYCONTINUE = 0x00000006;

/** The first button MB_DEFBUTTON1 - is default, if the other buttons MB_DEFBUTTON2, MB_DEFBUTTON3, or MB_DEFBUTTON4 are not specified
 */
const int MB_DEFBUTTON1 = 0x00000000;

/** The second button is default
 */
const int MB_DEFBUTTON2 = 0x00000100;

/** The third button is default
 */
const int MB_DEFBUTTON3 = 0x00000200;

/** The fourth button is default
 */
const int MB_DEFBUTTON4 = 0x00000300;

/** The exclamation/warning sign icon
 */
const int MB_ICONEXCLAMATION = 0x00000030,
          MB_ICONWARNING = 0x00000030;

/** The encircled i sign
 */
const int MB_ICONINFORMATION = 0x00000040,
          MB_ICONASTERISK = 0x00000040;

/** The question sign icon
 */
const int MB_ICONQUESTION = 0x00000020;

/** The STOP sign icon
 */
const int MB_ICONSTOP = 0x00000010,
          MB_ICONERROR = 0x00000010,
          MB_ICONHAND = 0x00000010;

/** Message window contains only one button: OK. Default
 */
const int MB_OK = 0x00000000;

/** Message window contains two buttons: OK and Cancel
 */
const int MB_OKCANCEL = 0x00000001;

/** Message window contains two buttons: Retry and Cancel
 */
const int MB_RETRYCANCEL = 0x00000005;

/** Message window contains two buttons: Yes and No
 */
const int MB_YESNO = 0x00000004;

/** Message window contains three buttons: Yes, No and Cancel
 */
const int MB_YESNOCANCEL = 0x00000003;

/** Line –DI
 */
const int MINUSDI_LINE = 2;

/** The object is drawn in all timeframes
 */
const int OBJ_ALL_PERIODS = 0x001fffff;

/** The object is not drawn in all timeframes
 */
const int OBJ_NO_PERIODS = 0;

/** The object is drawn in day charts
 */
const int OBJ_PERIOD_D1 = 0x00040000;

/** The object is drawn in 1-hour chart
 */
const int OBJ_PERIOD_H1 = 0x00000800;

/** The object is drawn in 12-hour chart
 */
const int OBJ_PERIOD_H12 = 0x00020000;

/** The object is drawn in 2-hour chart
 */
const int OBJ_PERIOD_H2 = 0x00001000;

/** The object is drawn in 3-hour chart
 */
const int OBJ_PERIOD_H3 = 0x00002000;

/** The object is drawn in 4-hour chart
 */
const int OBJ_PERIOD_H4 = 0x00004000;

/** The object is drawn in 6-hour chart
 */
const int OBJ_PERIOD_H6 = 0x00008000;

/** The object is drawn in 8-hour chart
 */
const int OBJ_PERIOD_H8 = 0x00010000;

/** The object is drawn in 1-minute chart
 */
const int OBJ_PERIOD_M1 = 0x00000001;

/** The object is drawn in 10-minute chart
 */
const int OBJ_PERIOD_M10 = 0x00000040;

/** The object is drawn in 12-minute chart
 */
const int OBJ_PERIOD_M12 = 0x00000080;

/** The object is drawn in 15-minute chart
 */
const int OBJ_PERIOD_M15 = 0x00000100;

/** The object is drawn in 2-minute chart
 */
const int OBJ_PERIOD_M2 = 0x00000002;

/** The object is drawn in 20-minute chart
 */
const int OBJ_PERIOD_M20 = 0x00000200;

/** The object is drawn in 3-minute chart
 */
const int OBJ_PERIOD_M3 = 0x00000004;

/** The object is drawn in 30-minute chart
 */
const int OBJ_PERIOD_M30 = 0x00000400;

/** The object is drawn in 4-minute chart
 */
const int OBJ_PERIOD_M4 = 0x00000008;

/** The object is drawn in 5-minute chart
 */
const int OBJ_PERIOD_M5 = 0x00000010;

/** The object is drawn in 6-minute chart
 */
const int OBJ_PERIOD_M6 = 0x00000020;

/** The object is drawn in month charts
 */
const int OBJ_PERIOD_MN1 = 0x00100000;

/** The object is drawn in week charts
 */
const int OBJ_PERIOD_W1 = 0x00080000;

/** Line +DI
 */
const int PLUSDI_LINE = 1;

/** Another account has been activated or reconnection to the trade server has occurred due to changes in the account settings
 */
const int REASON_ACCOUNT = 6;

/** Symbol or chart period has been changed
 */
const int REASON_CHARTCHANGE = 3;

/** Chart has been closed
 */
const int REASON_CHARTCLOSE = 4;

/** Terminal has been closed
 */
const int REASON_CLOSE = 9;

/** This value means that OnInit() handler has returned a nonzero value
 */
const int REASON_INITFAILED = 8;

/** Input parameters have been changed by a user
 */
const int REASON_PARAMETERS = 5;

/** Expert Advisor terminated its operation by calling the ExpertRemove() function
 */
const int REASON_PROGRAM = 0;

/** Program has been recompiled
 */
const int REASON_RECOMPILE = 2;

/** Program has been deleted from the chart
 */
const int REASON_REMOVE = 1;

/** A new template has been applied
 */
const int REASON_TEMPLATE = 7;

/** Senkou Span A line
 */
const int SENKOUSPANA_LINE = 2;

/** Senkou Span B line
 */
const int SENKOUSPANB_LINE = 3;

/** Maximal value, which can be represented by short type
 */
short SHORT_MAX = 32767;

/** Minimal value, which can be represented by short type
 */
short SHORT_MIN = -32768;

/** Signal line
 */
const int SIGNAL_LINE = 1;

/** The order is valid till the end of the day
 */
const int SYMBOL_EXPIRATION_DAY = 2;

/** The order is valid during the unlimited time period, until it is explicitly canceled
 */
const int SYMBOL_EXPIRATION_GTC = 1;

/** The expiration time is specified in the order
 */
const int SYMBOL_EXPIRATION_SPECIFIED = 4;

/** The expiration date is specified in the order
 */
const int SYMBOL_EXPIRATION_SPECIFIED_DAY = 8;

/** This policy means that a deal can be executed only with the specified volume. If the necessary amount of a financial instrument is currently unavailable in the market, the order will not be executed. The required volume can be filled using several offers available on the market at the moment.
 */
const int SYMBOL_FILLING_FOK = 1;

/** In this case a trader agrees to execute a deal with the volume maximally available in the market within that indicated in the order. In case the order cannot be filled completely, the available volume of the order will be filled, and the remaining volume will be canceled. The possibility of using IOC orders is determined at the trade server.
 */
const int SYMBOL_FILLING_IOC = 2;

/** Limit orders are allowed (Buy Limit and Sell Limit)
 */
const int SYMBOL_ORDER_LIMIT = 2;

/** Market orders are allowed (Buy and Sell)
 */
const int SYMBOL_ORDER_MARKET = 1;

/** Stop Loss is allowed
 */
const int SYMBOL_ORDER_SL = 16;

/** Stop orders are allowed (Buy Stop and Sell Stop)
 */
const int SYMBOL_ORDER_STOP = 4;

/** Stop-limit orders are allowed (Buy Stop Limit and Sell Stop Limit)
 */
const int SYMBOL_ORDER_STOP_LIMIT = 8;

/** Take Profit is allowed
 */
const int SYMBOL_ORDER_TP = 32;

/** Tenkan-sen line
 */
int TENKANSEN_LINE = 0;

/** Request canceled by trader
 */
int TRADE_RETCODE_CANCEL = 10007;

/** Autotrading disabled by client terminal
 */
int TRADE_RETCODE_CLIENT_DISABLES_AT = 10027;

/** No connection with the trade server
 */
int TRADE_RETCODE_CONNECTION = 10031;

/** Request completed
 */
int TRADE_RETCODE_DONE = 10009;

/** Only part of the request was completed
 */
int TRADE_RETCODE_DONE_PARTIAL = 10010;

/** Request processing error
 */
int TRADE_RETCODE_ERROR = 10011;

/** Order or position frozen
 */
int TRADE_RETCODE_FROZEN = 10029;

/** Invalid request
 */
int TRADE_RETCODE_INVALID = 10013;

/** Invalid order expiration date in the request
 */
int TRADE_RETCODE_INVALID_EXPIRATION = 10022;

/** Invalid order filling type
 */
int TRADE_RETCODE_INVALID_FILL = 10030;

/** Incorrect or prohibited order type
 */
int TRADE_RETCODE_INVALID_ORDER = 10035;

/** Invalid price in the request
 */
int TRADE_RETCODE_INVALID_PRICE = 10015;

/** Invalid stops in the request
 */
int TRADE_RETCODE_INVALID_STOPS = 10016;

/** Invalid volume in the request
 */
int TRADE_RETCODE_INVALID_VOLUME = 10014;

/** The number of pending orders has reached the limit
 */
int TRADE_RETCODE_LIMIT_ORDERS = 10033;

/** The volume of orders and positions for the symbol has reached the limit
 */
int TRADE_RETCODE_LIMIT_VOLUME = 10034;

/** Request locked for processing
 */
int TRADE_RETCODE_LOCKED = 10028;

/** Market is closed
 */
int TRADE_RETCODE_MARKET_CLOSED = 10018;

/** No changes in request
 */
int TRADE_RETCODE_NO_CHANGES = 10025;

/** There is not enough money to complete the request
 */
int TRADE_RETCODE_NO_MONEY = 10019;

/** Operation is allowed only for live accounts
 */
int TRADE_RETCODE_ONLY_REAL = 10032;

/** Order state changed
 */
int TRADE_RETCODE_ORDER_CHANGED = 10023;

/** Order placed
 */
int TRADE_RETCODE_PLACED = 10008;

/** Position with the specified POSITION_IDENTIFIER has already been closed
 */
int TRADE_RETCODE_POSITION_CLOSED = 10036;

/** Prices changed
 */
int TRADE_RETCODE_PRICE_CHANGED = 10020;

/** There are no quotes to process the request
 */
int TRADE_RETCODE_PRICE_OFF = 10021;

/** Request rejected
 */
int TRADE_RETCODE_REJECT = 10006;

/** Requote
 */
int TRADE_RETCODE_REQUOTE = 10004;

/** Autotrading disabled by server
 */
int TRADE_RETCODE_SERVER_DISABLES_AT = 10026;

/** Request canceled by timeout
 */
int TRADE_RETCODE_TIMEOUT = 10012;

/** Too frequent requests
 */
int TRADE_RETCODE_TOO_MANY_REQUESTS = 10024;

/** Trade is disabled
 */
int TRADE_RETCODE_TRADE_DISABLED = 10017;

/** Maximal value, which can be represented by uchar type
 */
int UCHAR_MAX = 255;

/** Maximal value, which can be represented by uint type
 */
int UINT_MAX = 4294967295;

/** Maximal value, which can be represented by ulong type
 */
int ULONG_MAX = 18446744073709551615;

/** Upper limit
 */
int UPPER_BAND = 1;

/** Upper histogram
 */
int UPPER_HISTOGRAM = 0;

/** Upper line
 */
int UPPER_LINE = 0;

/** Maximal value, which can be represented by ushort type
 */
int USHORT_MAX = 65535;

/** Means the number of items remaining until the end of the array, i.e., the entire array will be processed
 */
int WHOLE_ARRAY = -1;

/** The constant can be implicitly cast to any enumeration type
 */
int WRONG_VALUE = -1;

/** Returns the value of the appropriate account property.
 * @param property_id  [in]  Property identifier. The value can be one of the values of ENUM_ACCOUNT_INFO_DOUBLE.
 * @return ( double )
 */
double AccountInfoDouble(ENUM_ACCOUNT_INFO_DOUBLE property_id);

/** Returns the value of the appropriate account property.
 * @param property_id  [in]  Property identifier. The value can be one of the values of ENUM_ACCOUNT_INFO_INTEGER.
 * @return ( long )
 */
long AccountInfoInteger(ENUM_ACCOUNT_INFO_INTEGER property_id);

/** Returns the value of the appropriate account property.
 * @param property_id  [in]  Property identifier. The value can be one of the values of ENUM_ACCOUNT_INFO_STRING.
 * @return ( string )
 */
string AccountInfoString(ENUM_ACCOUNT_INFO_STRING property_id);

/** The function returns the arccosine of x within the range 0 to π in radians.
 * @param value  [in]  The val value between -1 and 1, the arc cosine of which is to be calculated.
 * @return ( double )
 */
double acos(double value);

template <typename A>
/** Displays a message in a separate window.
 * @param any  [in]  Any values separated by commas. The number of parameters can not exceed 64.
 */
void Alert(A any...);

/** Searches for a specified value in a multidimensional numeric array sorted ascending. Search is performed through the elements of the first dimension.
 * For searching in an array of double type
 * @param array  [in]  Numeric array for search.
 * @param value  [in]  Value for search.
 * @return ( double )
 */
double ArrayBsearch(const double (&array)[], double value);

/** Searches for a specified value in a multidimensional numeric array sorted ascending. Search is performed through the elements of the first dimension.
 * For searching in an array of float type
 * @param array  [in]  Numeric array for search.
 * @param value  [in]  Value for search.
 * @return ( float )
 */
float ArrayBsearch(const float (&array)[], float value);

/** Searches for a specified value in a multidimensional numeric array sorted ascending. Search is performed through the elements of the first dimension.
 * For searching in an array of long type
 * @param array  [in]  Numeric array for search.
 * @param value  [in]  Value for search.
 * @return ( long )
 */
long ArrayBsearch(const long (&array)[], long value);

/** Searches for a specified value in a multidimensional numeric array sorted ascending. Search is performed through the elements of the first dimension.
 * For searching in an array of int type
 * @param array  [in]  Numeric array for search.
 * @param value  [in]  Value for search.
 * @return ( int )
 */
int ArrayBsearch(const int (&array)[], int value);

/** Searches for a specified value in a multidimensional numeric array sorted ascending. Search is performed through the elements of the first dimension.
 * For searching in an array of short type
 * @param array  [in]  Numeric array for search.
 * @param value  [in]  Value for search.
 * @return ( short )
 */
short ArrayBsearch(const short (&array)[], short value);

/** Searches for a specified value in a multidimensional numeric array sorted ascending. Search is performed through the elements of the first dimension.
 * For searching in an array of char type
 * @param array  [in]  Numeric array for search.
 * @param value  [in]  Value for search.
 * @return ( char )
 */
char ArrayBsearch(const char (&array)[], char value);

template <typename VOID>
/** The function returns the result of comparing two arrays of the same type. It can be used to compare arrays of simple types or custom structures without complex objects, that is the custom structures that do not contain strings, dynamic arrays, classes and other structures with complex objects.
 * @param array1  [in]  First array.
 * @param array2  [in]  Second array.
 * @param start1  [in]  The element's initial index in the first array, from which comparison starts. The default start index - 0.
 * @param start2  [in]  The element's initial index in the second array, from which comparison starts. The default start index - 0.
 * @param count  [in]  Number of elements to be compared. All elements of both arrays participate in comparison by default (count=WHOLE_ARRAY).
 * @return ( int )
 */
int ArrayCompare(const VOID (&array1)[], const VOID (&array2)[], int start1 = 0, int start2 = 0, int count = WHOLE_ARRAY);

template <typename VOID>
/** It copies an array into another one.
 * @param dst_array  [out]  Destination array
 * @param src_array  [in]  Source array
 * @param dst_start  [in]  Starting index from the destination array. By default, start index is 0.
 * @param src_start  [in]  Starting index for the source array. By default, start index is 0.
 * @param count  [in]  Number of elements that should be copied. By default, the whole array is copied (count=WHOLE_ARRAY).
 * @return ( int )
 */
int ArrayCopy(VOID (&dst_array)[], const VOID (&src_array)[], int dst_start = 0, int src_start = 0, int count = WHOLE_ARRAY);

template <typename VOID>
/** The function fills an array with the specified value.
 * @param array  [out]  Array of simple type (char, uchar, short, ushort, int, uint, long, ulong, bool, color, datetime, float, double).
 * @param start  [in]  Starting index.  In such a case, specified AS_SERIES flag is ignored.
 * @param count  [in]  Number of elements to fill.
 * @param value  [in]  Value to fill the array with.
 */
void ArrayFill(VOID (&array)[], int start, int count, VOID value);

template <typename VOID>
/** It frees up a buffer of any dynamic array and sets the size of the zero dimension to 0.
 * @param array  [in]  Dynamic array.
 */
void ArrayFree(VOID (&array)[]);

template <typename VOID>
/** It checks direction of an array index.
 * @param array  [in]  Checked array.
 * @return ( bool )
 */
bool ArrayGetAsSeries(const VOID (&array)[]);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of char type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(char array[], char value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of short type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(short array[], short value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of int type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(int array[], int value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of long type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(long array[], long value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of float type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(float array[], float value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of double type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(double array[], double value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of bool type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(bool array[], bool value);

/** The function initializes a numeric array by a preset value.
 * For initialization of an array of uint type
 * @param array  [out]  Numeric array that should be initialized.
 * @param value  [in]  New value that should be set to all array elements.
 * @return ( int )
 */
int ArrayInitialize(uint array[], uint value);

template <typename VOID>
/** The function checks whether an array is dynamic.
 * @param array  [in]  Checked array.
 * @return ( bool )
 */
bool ArrayIsDynamic(const VOID (&array)[]);

template <typename VOID>
/** The function checks whether an array is a timeseries.
 * @param array  [in]  Checked array.
 * @return ( bool )
 */
bool ArrayIsSeries(const VOID (&array)[]);

template <typename VOID>
/** Searches for the largest element in the first dimension of a multidimensional numeric array.
 * @param array  [in]  A numeric array, in which search is made.
 * @param start  [in]  Index to start checking with.
 * @param count  [in]  Number of elements for search. By default, searches in the entire array (count=WHOLE_ARRAY).
 * @return ( int )
 */
int ArrayMaximum(const VOID (&array)[], int start = 0, int count = WHOLE_ARRAY);

template <typename VOID>
/** Searches for the lowest element in the first dimension of a multidimensional numeric array.
 * @param array  [in]  A numeric array, in which search is made.
 * @param start  [in]  Index to start checking with.
 * @param count  [in]  Number of elements for search. By default, searches in the entire array (count=WHOLE_ARRAY).
 * @return ( int )
 */
int ArrayMinimum(const VOID (&array)[N], int start = 0, int count = WHOLE_ARRAY);

template <typename VOID>
/** The function returns the number of elements in a selected array dimension.
 * @param array  [in]  Checked array.
 * @param rank_index  [in]  Index of dimension.
 * @return ( int )
 */
int ArrayRange(const VOID (&array)[], int rank_index);

template <typename VOID>
/** The function sets a new size for the first dimension
 * @param array  [out] Array for changing sizes.
 * @param new_size  [in]  New size for the first dimension.
 * @param reserve_size  [in]  Distributed size to get reserve.
 * @return ( int )
 */
int ArrayResize(VOID (&array)[], int new_size, int reserve_size = 0);

template <typename VOID>
/** The function sets the AS_SERIES flag to a selected object of a dynamic array, and elements will be indexed like in timeseries.
 * @param array  [in][out]  Numeric array to set.
 * @param flag  [in]  Array indexing direction.
 * @return ( bool )
 */
bool ArraySetAsSeries(const VOID (&array)[], bool flag);

template <typename VOID>
/** The function returns the number of elements of a selected array.
 * @param array  [in]  Array of any type.
 * @return ( int )
 */
int ArraySize(const VOID (&array)[]);

template <typename VOID>
/** Sorts the values in the first dimension of a multidimensional numeric array in the ascending order.
 * @param array  [in][out]  Numeric array for sorting.
 * @return ( bool )
 */
bool ArraySort(VOID (&array)[]);

template <typename VOID>
/** Prints an array of a simple type or a simple structure into journal.
 * @param array  [in]  Array of a simple type or a simple structure.
 * @param digits  [in]  The number of decimal places for real types. The default value is _Digits.
 * @param separator  [in]  Separator of the structure element field values. The default value NULL means an empty line. A space is used as a separator in that case.
 * @param start  [in]  The index of the first printed array element.  It is printed from the zero index by default.
 * @param count  [in]  Number of the array elements to be printed. The entire array is displayed by default (count=WHOLE_ARRAY).
 * @param flags  [in]  Combination of flags setting the output mode.
 */
void ArrayPrint(const VOID (&array)[], uint digits = _Digits, const string separator = NULL, ulong start = 0, ulong count = WHOLE_ARRAY, ulong flags = ARRAYPRINT_HEADER | ARRAYPRINT_INDEX | ARRAYPRINT_LIMIT | ARRAYPRINT_ALIGN);

template <typename VOID>
/** Inserts the specified number of elements from a source array to a receiving one starting from a specified index.
 * @param dst_array  [in][out]  Receiving array the elements should be added to.
 * @param src_array  [in]  Source array the elements are to be added from.
 * @param dst_start  [in]  Index in the receiving array for inserting elements from the source array.
 * @param src_start  [in]  Index in the receiving array, starting from which the elements of the source array are taken for insertion.
 * @param count  [in]  Number of elements to be added from the source array. The WHOLE_ARRAY means all elements from the specified index up to the end of the array.
 * @return ( bool )
 */
bool ArrayInsert(VOID (&dst_array)[], const VOID (&src_array)[], uint dst_start, uint src_start = 0, uint count = WHOLE_ARRAY);

template <typename VOID>
/** Removes the specified number of elements from the array starting with a specified index.
 * @param array  [in][out]  Array.
 * @param start  [in]  Index, starting from which the array elements are removed.
 * @param count  [in]  Number of removed elements. The WHOLE_ARRAY value means removing all elements from the specified index up the end of the array.
 * @return ( bool )
 */
bool ArrayRemove(VOID (&array)[], uint start, uint count = WHOLE_ARRAY);

template <typename VOID>
/** Reverses the specified number of elements in the array starting with a specified index.
 * @param array  [in][out]  Array.
 * @param start  [in]  Index the array reversal starts from.
 * @param count  [in]  Number of reversed elements. If WHOLE_ARRAY, then all array elements are moved in the inversed manner starting with the specified start index up to the end of the array.
 * @return ( bool )
 */
bool ArrayReverse(VOID (&array)[], uint start = 0, uint count = WHOLE_ARRAY);

template <typename VOID>
/** Swaps the contents of two dynamic arrays of the same type. For multidimensional arrays, the number of elements in all dimensions except the first one should match.
 * @param array1  [in][out]  Array of numerical type.
 * @param array2  [in][out]  Array of numerical type.
 * @return ( bool )
 */
bool ArraySwap(VOID (&array1)[], VOID (&array2)[]);

/** The function returns the arc sine of x within the range of -π/2 to π/2 radians.
 * @param value  [in]   The val value between -1 and 1, the arc sine of which is to be calculated.
 * @return ( double )
 */
double asin(double value);

/** The function returns the arc tangent of x. If x is equal to 0, the function returns 0.
 * @param value  [in]  A number representing a tangent.
 * @return ( double )
 */
double atan(double value);

/** Returns the number of bars count in the history for a specified symbol and period. There are 2 variants of functions calls.
 * Request all of the history bars
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @return ( int )
 */
int Bars(string symbol_name, ENUM_TIMEFRAMES timeframe);

/** Returns the number of bars count in the history for a specified symbol and period. There are 2 variants of functions calls.
 * Request the history bars for the selected time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  Bar time corresponding to the first element.
 * @param stop_time  [in]  Bar time corresponding to the last element.
 * @return ( int )
 */
int Bars(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time);

/** Returns the number of calculated data for the specified indicator.
 * @param indicator_handle  [in]  The indicator handle, returned by the corresponding indicator function.
 * @return ( int )
 */
int BarsCalculated(int indicator_handle);

/** Get a country description by its ID.
 * @param country_id  [in]  Country ID (ISO 3166-1).
 * @param country  [out]  MqlCalendarCountry type variable for receiving a country description.
 * @return ( bool )
 */
bool CalendarCountryById(const long country_id, MqlCalendarCountry &country);

/** Get an event description by its ID.
 * @param event_id  [in]  Event ID.
 * @param event  [out]  MqlCalendarEvent type variable for receiving an event description.
 * @return ( bool )
 */
bool CalendarEventById(ulong event_id, MqlCalendarEvent &event);

/** Get an event value description by its ID.
 * @param value_id  [in]  Event value ID.
 * @param value  [out]  MqlCalendarValue type variable for receiving an event description. See the example of handling calendar events.
 * @return ( bool )
 */
bool CalendarValueById(ulong value_id, MqlCalendarValue &value);

/** Get the array of country names available in the Calendar.
 * @param countries  [out]  An array of MqlCalendarCountry type for receiving all Calendar countries' descriptions.
 * @return ( int )
 */
int CalendarCountries(MqlCalendarCountry (&countries)[]);

/** Get the array of descriptions of all events available in the Calendar by a specified country code.
 * @param country_code  [in]  Country code name (ISO 3166-1 alpha-2)
 * @param events  [out]  MqlCalendarEvent type array for receiving descriptions of all events for a specified country.
 * @return ( int )
 */
int CalendarEventByCountry(string country_code, MqlCalendarEvent (&events)[]);

/** Get the array of descriptions of all events available in the Calendar by a specified currency.
 * @param currency  [in]  Country currency code name.
 * @param events  [out]  MqlCalendarEvent type array for receiving descriptions of all events for a specified currency.
 * @return ( int )
 */
int CalendarEventByCurrency(const string currency, MqlCalendarEvent (&events)[]);

/** Get the array of values for all events in a specified time range by an event ID.
 * @param event_id  [in]  Event ID.
 * @param values  [out]  MqlCalendarValue type array for receiving event values. See the example of handling calendar events.
 * @param datetime_from  [in]  Initial date of a time range events are selected from by a specified ID, while datetime_from < datetime_to.
 * @param datetime_to  [in]  End date of a time range events are selected from by a specified ID. If the datetime_to is not set (or is 0), all event values beginning from the specified datetime_from date in the Calendar database are returned (including the values of future events).
 * @return ( bool )
 */
bool CalendarValueHistoryByEvent(ulong event_id, MqlCalendarValue (&values)[], datetime datetime_from, datetime datetime_to = 0);

/** Get the array of values for all events in a specified time range with the ability to sort by country and/or currency.
 * @param values  [out]  MqlCalendarValue type array for receiving event values. See the example of handling calendar events.
 * @param datetime_from  [in]  Initial date of a time range events are selected from by a specified ID, while datetime_from < datetime_to.
 * @param datetime_to  [in]  End date of a time range events are selected from by a specified ID. If the datetime_to is not set (or is 0), all event values beginning from the specified datetime_from date in the Calendar database are returned (including the values of future events).
 * @param country_code  [in]  Country code name (ISO 3166-1 alpha-2)
 * @param currency  [in]  Country currency code name.
 * @return ( bool )
 */
bool CalendarValueHistory(MqlCalendarValue (&values)[], datetime datetime_from, datetime datetime_to = 0, const string country_code = NULL, const string currency = NULL);

/** Get the array of event values by its ID since the Calendar database status with a specified change_id.
 * @param event_id  [in]  Event ID.
 * @param change_id  [in][out]  Change ID.
 * @param values  [out]  MqlCalendarValue type array for receiving event values. See the example of handling calendar events.
 * @return ( int )
 */
int CalendarValueLastByEvent(ulong event_id, ulong &change_id, MqlCalendarValue (&values)[]);

/** Get the array of values for all events with the ability to sort by country and/or currency since the calendar database status with a specified change_id.
 * @param change_id  [in][out]  Change ID.
 * @param values  [out]  MqlCalendarValue type array for receiving event values. See the example of handling calendar events.
 * @param country_code  [in]  Country code name (ISO 3166-1 alpha-2)
 * @param currency  [in]  Country currency code name.
 * @return ( int )
 */
int CalendarValueLast(ulong &change_id, MqlCalendarValue (&values)[], const string country_code = NULL, const string currency = NULL);

/** The function returns integer numeric value closest from above.
 * @param value  [in]  Numeric value.
 * @return ( double )
 */
double ceil(double value);

/** It copies and converts part of array of uchar type into a returned string.
 * @param array  [in]  Array of uchar type.
 * @param start  [in]  Position from which copying starts. by default 0 is used.
 * @param count  [in]  Number of array elements for copying. Defines the length of a resulting string. Default value is -1, which means copying up to the array end, or till terminal 0.
 * @param codepage  [in]  The value of the code page. There is a number of built-in constants for the most used code pages.
 * @return ( string )
 */
string CharArrayToString(uchar array[], int start = 0, int count = -1, uint codepage = CP_ACP);

/** Applies a specific template from a specified file to the chart. The command is added to chart messages queue and will be executed after processing of all previous commands.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param filename  [in]  The name of the file containing the template.
 * @return ( bool )
 */
bool ChartApplyTemplate(long chart_id, const string filename);

/** Closes the specified chart.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @return ( bool )
 */
bool ChartClose(long chart_id = 0);

/** Returns the ID of the first chart of the client terminal.
 * @return ( long )
 */
long ChartFirst();

/** Returns the value of a corresponding property of the specified chart. Chart property must be of double type. There are 2 variants of the function calls.
 * 1. Returns the property value directly.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. This value can be one of the ENUM_CHART_PROPERTY_DOUBLE values.
 * @param sub_window  [in]  Number of the chart subwindow. For the first case, the default value is 0 (main chart window). The most of the properties do not require a subwindow number.
 * @return ( bool )
 */
bool ChartGetDouble(long chart_id, int prop_id, int sub_window = 0);

/** Returns the value of a corresponding property of the specified chart. Chart property must be of double type. There are 2 variants of the function calls.
 * 2. Returns true or false, depending on the success of a function. If successful, the value of the property is placed in a target variable double_var passed by reference.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. This value can be one of the ENUM_CHART_PROPERTY_DOUBLE values.
 * @param sub_window  [in]  Number of the chart subwindow. For the first case, the default value is 0 (main chart window). The most of the properties do not require a subwindow number.
 * @param double_var  [out]  Target variable of double type for the requested property.
 * @return ( bool )
 */
bool ChartGetDouble(long chart_id, int prop_id, int sub_window, double &double_var);

/** Returns the value of a corresponding property of the specified chart. Chart property must be of datetime, int or bool type. There are 2 variants of the function calls.
 * 1. Returns the property value directly.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. This value can be one of the  ENUM_CHART_PROPERTY_INTEGER values.
 * @param sub_window  [in]  Number of the chart subwindow. For the first case, the default value is 0 (main chart window). The most of the properties do not require a subwindow number.
 * @return ( bool )
 */
bool ChartGetInteger(long chart_id, int prop_id, int sub_window = 0);

/** Returns the value of a corresponding property of the specified chart. Chart property must be of datetime, int or bool type. There are 2 variants of the function calls.
 * 2. Returns true or false, depending on the success of a function. If successful, the value of the property is placed in a target variable long_var passed by reference.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. This value can be one of the  ENUM_CHART_PROPERTY_INTEGER values.
 * @param sub_window  [in]  Number of the chart subwindow. For the first case, the default value is 0 (main chart window). The most of the properties do not require a subwindow number.
 * @param long_var  [out]  Target variable of long type for the requested property.
 * @return ( bool )
 */
bool ChartGetInteger(long chart_id, int prop_id, int sub_window, long &long_var);

/** Returns the value of a corresponding property of the specified chart. Chart property must be of string type. There are 2 variants of the function call.
 * 1. Returns the property value directly.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. This value can be one of the  ENUM_CHART_PROPERTY_STRING values.
 * @return ( bool )
 */
bool ChartGetString(long chart_id, int prop_id);

/** Returns the value of a corresponding property of the specified chart. Chart property must be of string type. There are 2 variants of the function call.
 * 2. Returns true or false, depending on the success of a function. If successful, the value of the property is placed in a target variable string_var passed by reference.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. This value can be one of the  ENUM_CHART_PROPERTY_STRING values.
 * @param string_var  [out]  Target variable of string type for the requested property.
 * @return ( bool )
 */
bool ChartGetString(long chart_id, int prop_id, string &string_var);

/** Returns the ID of the current chart.
 * @return ( long )
 */
long ChartID();

/** Adds an indicator with the specified handle into a specified chart window. Indicator and chart should be generated on the same symbol and time frame.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param sub_window  [in]  The number of the chart sub-window. 0 means the main chart window. To add an indicator in a new window, the parameter must be one greater than the index of the last existing window, i.e. equal to CHART_WINDOWS_TOTAL. If the value of the parameter is greater than CHART_WINDOWS_TOTAL, a new window will not be created, and the indicator will not be added.
 * @param indicator_handle  [in]  The handle of the indicator.
 * @return ( bool )
 */
bool ChartIndicatorAdd(long chart_id, int sub_window, int indicator_handle);

/** Removes an indicator with a specified name from the specified chart window.
 * @param chart_id  [in]  Chart ID. 0 denotes the current chart.
 * @param sub_window  [in]  Number of the chart subwindow. 0 denotes the main chart subwindow.
 * @param indicator_shortname  [in]  The short name of the indicator which is set in the INDICATOR_SHORTNAME property with the IndicatorSetString() function. To get the short name of an indicator use the ChartIndicatorName() function.
 * @return ( bool )
 */
bool ChartIndicatorDelete(long chart_id, int sub_window, const string indicator_shortname);

/** Returns the handle of the indicator with the specified short name in the specified chart window.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param sub_window  [in]  The number of the chart subwindow. 0 means the main chart window.
 * @param indicator_shortname  [in]  The short name if the indicator, which is set in the INDICATOR_SHORTNAME property using the IndicatorSetString() function. To get the short name of an indicator, use the ChartIndicatorName() function.
 * @return ( int )
 */
int ChartIndicatorGet(long chart_id, int sub_window, const string indicator_shortname);

/** Returns the short name of the indicator by the number in the indicators list on the specified chart window.
 * @param chart_id  [in]  Chart ID. 0 denotes the current chart.
 * @param sub_window  [in]  Number of the chart subwindow. 0 denotes the main chart subwindow.
 * @param index  [in]  the index of the indicator in the list of indicators. The numeration of indicators start with zero, i.e. the first indicator in the list has the 0 index. To obtain the number of indicators in the list use the ChartIndicatorsTotal() function.
 * @return ( string )
 */
string ChartIndicatorName(long chart_id, int sub_window, int index);

/** Returns the number of all indicators applied to the specified chart window.
 * @param chart_id  [in]  Chart ID. 0 denotes the current chart.
 * @param sub_window  [in]  Number of the chart subwindow. 0 denotes the main chart subwindow.
 * @return ( int )
 */
int ChartIndicatorsTotal(long chart_id, int sub_window);

/** Performs shift of the specified chart by the specified number of bars relative to the specified position in the chart.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param position  [in]  Chart position to perform a shift. Can be one of the ENUM_CHART_POSITION values.
 * @param shift  [in]  Number of bars to shift the chart. Positive value means the right shift (to the end of chart), negative value means the left shift (to the beginning of chart). The zero shift can be used to navigate to the beginning or end of chart.
 * @return ( bool )
 */
bool ChartNavigate(long chart_id, ENUM_CHART_POSITION position, int shift = 0);

/** Returns the chart ID of the chart next to the specified one.
 * @param chart_id  [in]  Chart ID. 0 does not mean the current chart. 0 means "return the first chart ID".
 * @return ( long )
 */
long ChartNext(long chart_id);

/** Opens a new chart with the specified symbol and period.
 * @param symbol  [in]  Chart symbol. NULL means the symbol of the  current chart (the Expert Advisor is attached to).
 * @param period  [in]  Chart period (timeframe). Can be one of the ENUM_TIMEFRAMES values. 0 means the current chart period.
 * @return ( long )
 */
long ChartOpen(string symbol, ENUM_TIMEFRAMES period);

/** Converting a symbol code into a one-character string
 * @param char_code  [in]  Code of ANSI symbol.
 * @return ( string )
 */
string CharToString(uchar char_code);

/** Returns the timeframe period of specified chart.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @return ( ENUM_TIMEFRAMES )
 */
ENUM_TIMEFRAMES ChartPeriod(long chart_id = 0);

/** Returns the price coordinate corresponding to the chart point the Expert Advisor or script has been dropped to.
 * @return ( double )
 */
double ChartPriceOnDropped();

/** This function calls a forced redrawing of a specified chart.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 */
void ChartRedraw(long chart_id = 0);

/** Saves current chart settings in a template with a specified name.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param filename  [in]  The filename to save the template. The ".tpl" extension will be added to the filename automatically; there is no need to specify it. The template is saved in data_folder\Profiles\Templates\ and can be used for manual application in the terminal. If a template with the same filename already exists, the contents of this file will be overwritten.
 * @return ( bool )
 */
bool ChartSaveTemplate(long chart_id, const string filename);

/** The function provides a screenshot of the chart in its current state in the GIF, PNG or BMP format depending on specified extension.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param filename  [in]  Screenshot file name. Cannot exceed 63 characters. Screenshot files are placed in the \Files directory.
 * @param width  [in]  Screenshot width in pixels.
 * @param height  [in]  Screenshot height in pixels.
 * @param align_mode  [in]  Output mode of a narrow screenshot. A value of the ENUM_ALIGN_MODE enumeration. ALIGN_RIGHT means align to the right margin (the output from the end). ALIGN_LEFT means Left justify.
 * @return ( bool )
 */
bool ChartScreenShot(long chart_id, string filename, int width, int height, ENUM_ALIGN_MODE align_mode = ALIGN_RIGHT);

/** Sets a value for a corresponding property of the specified chart. Chart property should be of a double type. The command is added to chart messages queue and will be executed after processing of all previous commands.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. Can be one of the ENUM_CHART_PROPERTY_DOUBLE values (except the read-only properties).
 * @param value  [in] Property value.
 * @return ( bool )
 */
bool ChartSetDouble(long chart_id, int prop_id, double value);

/** Sets a value for a corresponding property of the specified chart. Chart property must be datetime, int, color, bool or char. The command is added to chart messages queue and will be executed after processing of all previous commands.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. It can be one of the ENUM_CHART_PROPERTY_INTEGER value (except the read-only properties).
 * @param value  [in]  Property value.
 * @return ( bool )
 */
bool ChartSetInteger(long chart_id, int prop_id, long value);

/** Sets a value for a corresponding property of the specified subwindow. Chart property must be datetime, int, color, bool or char. The command is added to chart messages queue and will be executed after processing of all previous commands.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. It can be one of the ENUM_CHART_PROPERTY_INTEGER value (except the read-only properties).
 * @param sub_window  [in]  Number of the chart subwindow. For the first case, the default value is 0 (main chart window). The most of the properties do not require a subwindow number.
 * @param value  [in]  Property value.
 * @return ( bool )
 */
bool ChartSetInteger(long chart_id, int prop_id, int sub_window, long value);

/** Sets a value for a corresponding property of the specified chart. Chart property must be of the string type. The command is added to chart messages queue and will be executed after processing of all previous commands.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param prop_id  [in]  Chart property ID. Its value can be one of the ENUM_CHART_PROPERTY_STRING values (except the read-only properties).
 * @param str_value  [in]  Property value string. String length cannot exceed 2045 characters (extra characters will be truncated).
 * @return ( bool )
 */
bool ChartSetString(long chart_id, int prop_id, string str_value);

/** Changes the symbol and period of the specified chart. The function is asynchronous, i.e. it sends the command and does not wait for its execution completion. The command is added to chart messages queue and will be executed after processing of all previous commands.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param symbol  [in]  Chart symbol. NULL value means the current chart symbol (Expert Advisor is attached to)
 * @param period  [in]  Chart period (timeframe). Can be one of the ENUM_TIMEFRAMES values. 0 means the current chart period.
 * @return ( bool )
 */
bool ChartSetSymbolPeriod(long chart_id, string symbol, ENUM_TIMEFRAMES period);

/** Returns the symbol name for the specified chart.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @return ( string )
 */
string ChartSymbol(long chart_id = 0);

/** Returns the time coordinate corresponding to the chart point the Expert Advisor or script has been dropped to.
 * @return ( datetime )
 */
datetime ChartTimeOnDropped();

/** Converts the coordinates of a chart from the time/price representation to the X and Y coordinates.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param sub_window  [in]  The number of the chart subwindow. 0 means the main chart window.
 * @param time  [in]  The time value on the chart, for which the value in pixels along the X axis will be received. The origin is in the upper left corner of the main chart window.
 * @param price  [in]   The price value on the chart, for which the value in pixels along the Y axis will be received. The origin is in the upper left corner of the main chart window.
 * @param x  [out]  The variable, into which the conversion of time to X will be received.
 * @param y  [out]  The variable, into which the conversion of price to Y will be received.
 * @return ( bool )
 */
bool ChartTimePriceToXY(long chart_id, int sub_window, datetime time, double price, int &x, int &y);

/** The function returns the number of a subwindow where an indicator is drawn. There are 2 variants of the function.
 * 1. The function searches in the indicated chart for the subwindow with the specified "short name" of the indicator (the short name is displayed in the left top part of the subwindow), and it returns the subwindow number in case of success.
 * @param chart_id  [in]  Chart ID. 0 denotes the current chart.
 * @param indicator_shortname  [in]  Short name of the indicator.
 * @return ( int )
 */
int ChartWindowFind(long chart_id, string indicator_shortname);

/** The function returns the number of a subwindow where an indicator is drawn. There are 2 variants of the function.
 * 2. The function must be called from a custom indicator. It returns the number of the subwindow where the indicator is working.
 * @return ( int )
 */
int ChartWindowFind();

/** Returns the number (index) of the chart subwindow the Expert Advisor or script has been dropped to. 0 means the main chart window.
 * @return ( int )
 */
int ChartWindowOnDropped();

/** Returns the X coordinate of the chart point the Expert Advisor or script has been dropped to.
 * @return ( int )
 */
int ChartXOnDropped();

/** Converts the X and Y coordinates on a chart to the time and price values.
 * @param chart_id  [in]  Chart ID. 0 means the current chart.
 * @param x  [in]  The X coordinate.
 * @param y  [in]  The Y coordinate.
 * @param sub_window  [out]  The variable, into which the chart subwindow number will be written. 0 means the main chart window.
 * @param time  [out]  The time value on the chart, for which the value in pixels along the X axis will be received. The origin is in the upper left corner of the main chart window.
 * @param price  [out]  The price value on the chart, for which the value in pixels along the Y axis will be received. The origin is in the upper left corner of the main chart window.
 * @return ( bool )
 */
bool ChartXYToTimePrice(long chart_id, int x, int y, int &sub_window, datetime &time, double &price);

/** Returns the Y coordinateof the chart point the Expert Advisor or script has been dropped to.
 * @return ( int )
 */
int ChartYOnDropped();

template <typename OBJECT>
/** The function returns the type of the object pointer.
 * @param anyobject  [in]  Object pointer.
 * @return ( ENUM_POINTER_TYPE )
 */
ENUM_POINTER_TYPE CheckPointer(OBJECT *anyobject);

/** Creates an OpenCL buffer and returns its handle.
 * @param context  [in]  A handle to context OpenCL.
 * @param size  [in]  Buffer size in bytes.
 * @param flags  [in]  Buffer properties that are set using a combination of flags: CL_MEM_READ_WRITE, CL_MEM_WRITE_ONLY, CL_MEM_READ_ONLY, CL_MEM_ALLOC_HOST_PTR.
 * @return ( int )
 */
int CLBufferCreate(int context, uint size, uint flags);

/** Deletes an OpenCL buffer.
 * @param buffer  [in]  A handle to an OpenCL buffer.
 */
void CLBufferFree(int buffer);

template <typename VOID>
/** Reads an OpenCL buffer into an array and returns the number of read elements.
 * @param buffer  [in]   A handle of the OpenCL buffer.
 * @param data  [in]  An array for receiving values from the OpenCL buffer. Passed by reference.
 * @param buffer_offset  [in]  An offset in the OpenCL buffer in bytes, from which reading begins. By default, reading start with the very beginning of the buffer.
 * @param data_offset  [in]  The index of the first array element for writing the values of the OpenCL buffer. By default, writing of the read values into an array starts from the zero index.
 * @param data_count  [in]  The number of values that should be read. The whole OpenCL buffer is read by default.
 * @return ( uint )
 */
uint CLBufferRead(int buffer, const VOID (&data)[], uint buffer_offset = 0, uint data_offset = 0, uint data_count = WHOLE_ARRAY);

template <typename VOID>
/** Writes into the OpenCL buffer and returns the number of written elements.
 * @param buffer  [in]  A handle of the OpenCL buffer.
 * @param data  [in]  An array of values that should be written in the OpenCL buffer. Passed by reference.
 * @param buffer_offset  [in]  An offset in the OpenCL buffer in bytes, from which writing begins. By default, writing start with the very beginning of the buffer.
 * @param data_offset  [in]  The index of the first array element, starting from which values from the array are written in the OpenCL buffer. By default, values from the very beginning of the array are taken.
 * @param data_count  [in]  The number of values that should be written. All the values of the array, by default.
 * @return ( uint )
 */
uint CLBufferWrite(int buffer, const VOID (&data)[], uint buffer_offset = 0, uint data_offset = 0, uint data_count = WHOLE_ARRAY);

/** Creates an OpenCL context and returns its handle.
 * @param device  [in]  The ordinal number of the OpenCL-device in the system.
 * @return ( int )
 */
int CLContextCreate(int device);

/** Removes an OpenCL context.
 * @param context  [in]  Handle of the OpenCL context.
 */
void CLContextFree(int context);

/** The function runs an OpenCL program. There are 3 versions of the function:
 * 1. Launching kernel functions using one kernel
 * @param kernel  [in]  Handle to the OpenCL kernel.
 * @return ( bool )
 */
bool CLExecute(int kernel);

/** The function runs an OpenCL program. There are 3 versions of the function:
 * 2. Launching several kernel copies (OpenCL function) with task space description
 * @param kernel  [in]  Handle to the OpenCL kernel.
 * @param work_dim  [in]  Dimension of the tasks space.
 * @param global_work_offset  [in]  Initial offset in the tasks space.
 * @param global_work_size  [in]  The size of a subset of tasks.
 * @return ( bool )
 */
bool CLExecute(int kernel, uint work_dim, const uint (&global_work_offset)[], const uint (&global_work_size)[]);

/** The function runs an OpenCL program. There are 3 versions of the function:
 * 3. Launching several kernel copies (OpenCL function) with task space description and specification of the size of the group's local task subset
 * @param kernel  [in]  Handle to the OpenCL kernel.
 * @param work_dim  [in]  Dimension of the tasks space.
 * @param global_work_offset  [in]  Initial offset in the tasks space.
 * @param global_work_size  [in]  The size of a subset of tasks.
 * @param local_work_size  [in]  The size of the group's local task subset.
 * @return ( bool )
 */
bool CLExecute(int kernel, uint work_dim, const uint (&global_work_offset)[], const uint (&global_work_size)[], const uint (&local_work_size)[]);

/** The function receives device property from OpenCL driver.
 * @param handle  [in]  OpenCL device index or OpenCL handle created by CLContextCreate() function.
 * @param property_id  [in]  ID of the OpenCL device property that should be received. The values can be of one of the predetermined ones listed in the table below.
 * @param data  [out]  The array for receiving data on the requested property.
 * @param size  [out]  Size of the received data in the array data[].
 * @return ( bool )
 */
bool CLGetDeviceInfo(int handle, int property_id, uchar (&data)[], uint &size);

/** Returns the value of an integer property for an OpenCL object or device.
 * @param handle  [in]  A handle to the OpenCL object or number of the OpenCL device. Numbering of OpenCL devices starts with zero.
 * @param prop  [in]  The type of a requested property from the ENUM_OPENCL_PROPERTY_INTEGER enumeration, the value of which you want to obtain.
 * @return ( long )
 */
long CLGetInfoInteger(int handle, ENUM_OPENCL_PROPERTY_INTEGER prop);

/** Returns the type of an OpenCL handle as a value of the ENUM_OPENCL_HANDLE_TYPE enumeration.
 * @param handle  [in]  A handle to an OpenCL object: a context, a kernel or an OpenCL program.
 * @return ( ENUM_OPENCL_HANDLE_TYPE )
 */
ENUM_OPENCL_HANDLE_TYPE CLHandleType(int handle);

/** Creates the OpenCL program kernel and returns its handle.
 * @param program  [in]  Handle to an object of the OpenCL program.
 * @param kernel_name  [in]  The name of the kernel function in the appropriate OpenCL program, in which execution begins.
 * @return ( int )
 */
int CLKernelCreate(int program, const string kernel_name);

/** Removes an OpenCL start function.
 * @param kernel  [in]  Handle of the kernel object.
 */
void CLKernelFree(int kernel);

/** Creates an OpenCL program from a source code.
 * @param context  [in]  Handle of the OpenCL context.
 * @param source  [in]  String with the source code of the OpenCL program.
 * @return ( int )
 */
int CLProgramCreate(int context, const string source);

/** Creates an OpenCL program from a source code.
 * An overloaded function version creates an OpenCL program and writes compiler messages into the passed string.
 * @param context  [in]  Handle of the OpenCL context.
 * @param source  [in]  String with the source code of the OpenCL program.
 * @param build_log  [in]  A string for receiving the OpenCL compiler messages.
 * @return ( int )
 */
int CLProgramCreate(int context, const string source, string &build_log);

/** Removes an OpenCL program.
 * @param program  [in]  Handle of the OpenCL object.
 */
void CLProgramFree(int program);

template <typename VOID>
/** Sets a parameter for the OpenCL function.
 * @param kernel  [in]  Handle to a kernel of the OpenCL program.
 * @param arg_index  [in]  The number of the function argument, numbering starts with zero.
 * @param arg_value  [in]  The value of the function argument.
 * @return ( bool )
 */
bool CLSetKernelArg(int kernel, uint arg_index, VOID arg_value);

/** Sets an OpenCL buffer as a parameter of the OpenCL function.
 * @param kernel  [in]  Handle to a kernel of the OpenCL program.
 * @param arg_index  [in]  The number of the function argument, numbering starts with zero.
 * @param cl_mem_handle  [in]  A handle to an OpenCL buffer.
 * @return ( bool )
 */
bool CLSetKernelArgMem(int kernel, uint arg_index, int cl_mem_handle);

/** The function converts color type into uint type to get ARGB representation of the color. ARGB color format is used to generate a graphical resource, text display, as well as for CCanvas standard library class.
 * @param clr  [in]  Color value in color type variable.
 * @param alpha  [in]  The value of the alpha channel used to receive the color in ARGB format. The value may be set from 0 (a color of a foreground pixel does not change the display of an underlying one) up to 255 (a color of an underlying pixel is completely replaced by the foreground pixel's one). Color transparency in percentage terms is calculated as (1-alpha/255)*100%. In other words, the lesser value of the alpha channel leads to more transparent color.
 * @return ( uint )
 */
uint ColorToARGB(color clr, uchar alpha = 255);

/** It converts color value into string of "R,G,B" form.
 * @param color_value  [in]  Color value in color type variable.
 * @param color_name  [in]  Return color name if it is identical to one of predefined color constants.
 * @return ( string )
 */
string ColorToString(color color_value, bool color_name);

template <typename M>
/** This function outputs a comment defined by a user in the top left corner of a chart.
 * @param any  [in]   Any values, separated by commas. To delimit output information into several lines, a line break symbol "\n" or "\r\n" is used. Number of parameters cannot exceed 64. Total length of the input comment (including invisible symbols) cannot exceed 2045 characters (excess symbols will be cut out during output).
 */
void Comment(M any...);

/** Gets data of a specified buffer of a certain indicator in the necessary quantity.
 * Call by the first position and the number of required elements
 * @param indicator_handle  [in]  The indicator handle, returned by the corresponding indicator function.
 * @param buffer_num  [in]  The indicator buffer number.
 * @param start_pos  [in]  The position of the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param buffer  [out]  Array of double type.
 * @return ( int )
 */
int CopyBuffer(int indicator_handle, int buffer_num, int start_pos, int count, double buffer[]);

/** Gets data of a specified buffer of a certain indicator in the necessary quantity.
 * Call by the start date and the number of required elements
 * @param indicator_handle  [in]  The indicator handle, returned by the corresponding indicator function.
 * @param buffer_num  [in]  The indicator buffer number.
 * @param start_time  [in]  Bar time, corresponding to the first element.
 * @param count  [in]  Data count to copy.
 * @param buffer  [out]  Array of double type.
 * @return ( int )
 */
int CopyBuffer(int indicator_handle, int buffer_num, datetime start_time, int count, double buffer[]);

/** Gets data of a specified buffer of a certain indicator in the necessary quantity.
 * Call by the start and end dates of a required time interval
 * @param indicator_handle  [in]  The indicator handle, returned by the corresponding indicator function.
 * @param buffer_num  [in]  The indicator buffer number.
 * @param start_time  [in]  Bar time, corresponding to the first element.
 * @param stop_time  [in]  Bar time, corresponding to the last element.
 * @param buffer  [out]  Array of double type.
 * @return ( int )
 */
int CopyBuffer(int indicator_handle, int buffer_num, datetime start_time, datetime stop_time, double buffer[]);

/** The function gets into close_array the history data of bar close prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param close_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyClose(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, double close_array[]);

/** The function gets into close_array the history data of bar close prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param close_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyClose(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, double close_array[]);

/** The function gets into close_array the history data of bar close prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param close_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyClose(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, double close_array[]);

/** The function gets into high_array the history data of highest bar prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param high_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyHigh(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, double high_array[]);

/** The function gets into high_array the history data of highest bar prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param high_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyHigh(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, double high_array[]);

/** The function gets into high_array the history data of highest bar prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param high_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyHigh(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, double high_array[]);

/** The function gets into low_array the history data of minimal bar prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param low_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyLow(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, double low_array[]);

/** The function gets into low_array the history data of minimal bar prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  Bar time, corresponding to the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param low_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyLow(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, double low_array[]);

/** The function gets into low_array the history data of minimal bar prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  Bar time, corresponding to the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param low_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyLow(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, double low_array[]);

/** The function gets into open_array the history data of bar open prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param open_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyOpen(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, double open_array[]);

/** The function gets into open_array the history data of bar open prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param open_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyOpen(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, double open_array[]);

/** The function gets into open_array the history data of bar open prices for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  The start time for the last element to copy.
 * @param open_array  [out]  Array of double type.
 * @return ( int )
 */
int CopyOpen(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, double open_array[]);

/** Gets history data of MqlRates structure of a specified symbol-period in specified quantity into the rates_array array. The elements ordering of the copied data is from present to the past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param rates_array  [out]  Array of MqlRates type.
 * @return ( int )
 */
int CopyRates(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, MqlRates rates_array[]);

/** Gets history data of MqlRates structure of a specified symbol-period in specified quantity into the rates_array array. The elements ordering of the copied data is from present to the past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  Bar time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param rates_array  [out]  Array of MqlRates type.
 * @return ( int )
 */
int CopyRates(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, MqlRates rates_array[]);

/** Gets history data of MqlRates structure of a specified symbol-period in specified quantity into the rates_array array. The elements ordering of the copied data is from present to the past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  Bar time for the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param rates_array  [out]  Array of MqlRates type.
 * @return ( int )
 */
int CopyRates(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, MqlRates rates_array[]);

/** The function gets into volume_array the history data of trade volumes for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param volume_array  [out]  Array of  long type.
 * @return ( int )
 */
int CopyRealVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, long volume_array[]);

/** The function gets into volume_array the history data of trade volumes for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param volume_array  [out]  Array of  long type.
 * @return ( int )
 */
int CopyRealVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, long volume_array[]);

/** The function gets into volume_array the history data of trade volumes for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param volume_array  [out]  Array of  long type.
 * @return ( int )
 */
int CopyRealVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, long volume_array[]);

/** The function gets into spread_array the history data of spread values for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param spread_array  [out]  Array of int type.
 * @return ( int )
 */
int CopySpread(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, int spread_array[]);

/** The function gets into spread_array the history data of spread values for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param spread_array  [out]  Array of int type.
 * @return ( int )
 */
int CopySpread(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, int spread_array[]);

/** The function gets into spread_array the history data of spread values for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param spread_array  [out]  Array of int type.
 * @return ( int )
 */
int CopySpread(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, int spread_array[]);

/** The function receives ticks in the MqlTick format into ticks_array. In this case, ticks are indexed from the past to the present, i.e. the 0 indexed tick is the oldest one in the array. For tick analysis, check the flags field, which shows what exactly has changed in the tick.
 * @param symbol_name  [in]  Symbol.
 * @param ticks_array  [out]  An array of the MqlTick type for receiving ticks.
 * @param flags  [in]  A flag to define the type of the requested ticks. COPY_TICKS_INFO – ticks with Bid and/or Ask changes, COPY_TICKS_TRADE – ticks with changes in Last and Volume, COPY_TICKS_ALL – all ticks. For any type of request, the values of the previous tick are added to the remaining fields of the MqlTick structure.
 * @param from  [in]   The date from which you want to request ticks. In milliseconds since 1970.01.01. If from=0, the last count ticks will be returned.
 * @param count  [in]  The number of requested ticks. If the 'from' and 'count' parameters are not specified, all available recent ticks (but not more than 2000) will be written to ticks_array[].
 * @return ( int )
 */
int CopyTicks(string symbol_name, MqlTick (&ticks_array)[], uint flags = COPY_TICKS_ALL, ulong from = 0, uint count = 0);

/** The function gets into volume_array the history data of tick volumes for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param volume_array  [out]  Array of  long type.
 * @return ( int )
 */
int CopyTickVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, long volume_array[]);

/** The function gets into volume_array the history data of tick volumes for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param volume_array  [out]  Array of  long type.
 * @return ( int )
 */
int CopyTickVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, long volume_array[]);

/** The function gets into volume_array the history data of tick volumes for the selected symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  Bar time, corresponding to the last element to copy.
 * @param volume_array  [out]  Array of  long type.
 * @return ( int )
 */
int CopyTickVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, long volume_array[]);

/** The function gets to time_array history data of bar opening time for the specified symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the first position and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_pos  [in]  The start position for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param time_array  [out]  Array of datetime type.
 * @return ( int )
 */
int CopyTime(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos, int count, datetime time_array[]);

/** The function gets to time_array history data of bar opening time for the specified symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start date and the number of required elements
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param count  [in]  Data count to copy.
 * @param time_array  [out]  Array of datetime type.
 * @return ( int )
 */
int CopyTime(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, int count, datetime time_array[]);

/** The function gets to time_array history data of bar opening time for the specified symbol-period pair in the specified quantity. It should be noted that elements ordering is from present to past, i.e., starting position of 0 means the current bar.
 * Call by the start and end dates of a required time interval
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param start_time  [in]  The start time for the first element to copy.
 * @param stop_time  [in]  Bar time corresponding to the last element to copy.
 * @param time_array  [out]  Array of datetime type.
 * @return ( int )
 */
int CopyTime(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time, datetime stop_time, datetime time_array[]);

/** The function returns the cosine of an angle.
 * @param value  [in]  Angle in radians.
 * @return ( double )
 */
double cos(double value);

/** Performs the inverse transformation of the data from array, tranformed by CryptEncode().
 * @param method  [in]  Data transformation method. Can be one of the values of ENUM_CRYPT_METHOD enumeration.
 * @param data  [in]  Source array.
 * @param key  [in]  Key array.
 * @param result  [out]  Destination array.
 * @return ( int )
 */
int CryptDecode(ENUM_CRYPT_METHOD method, const uchar (&data)[], const uchar (&key)[], uchar (&result)[]);

/** Transforms the data from array with the specified method.
 * @param method  [in]  Data transformation method. Can be one of the values of ENUM_CRYPT_METHOD enumeration.
 * @param data  [in]  Source array.
 * @param key  [in]  Key array.
 * @param result  [out]  Destination array.
 * @return ( int )
 */
int CryptEncode(ENUM_CRYPT_METHOD method, const uchar (&data)[], const uchar (&key)[], uchar (&result)[]);

/** Creates a custom symbol with the specified name in the specified group.
 * @param symbol_name  [in]  Custom symbol name. It should not contain groups or subgroups the symbol is located in.
 * @param symbol_path  [in]  The group name a symbol is located in.
 * @param symbol_origin  [in]  Name of a symbol the properties of a created custom symbol are to be copied from. After creating a custom symbol, any property value can be changed to a necessary one using the appropriate functions.
 * @return ( bool )
 */
bool CustomSymbolCreate(const string symbol_name, const string symbol_path = "", const string symbol_origin = NULL);

/** Deletes a custom symbol with the specified name.
 * @param symbol_name  [in]  Custom symbol name. It should not match the name of an already existing symbol.
 * @return ( bool )
 */
bool CustomSymbolDelete(const string symbol_name);

/** Sets the integer type property value for a custom symbol.
 * @param symbol_name  [in]  Custom symbol name.
 * @param property_id  [in]  Symbol property ID. The value can be one of the values of the ENUM_SYMBOL_INFO_INTEGER enumeration.
 * @param property_value  [in]  A long type variable containing the property value.
 * @return ( bool )
 */
bool CustomSymbolSetInteger(const string symbol_name, ENUM_SYMBOL_INFO_INTEGER property_id, long property_value);

/** Sets the real type property value for a custom symbol.
 * @param symbol_name  [in]  Custom symbol name.
 * @param property_id  [in]  Symbol property ID. The value can be one of the values of the ENUM_SYMBOL_INFO_DOUBLE enumeration.
 * @param property_value  [in]  A double type variable containing the property value.
 * @return ( bool )
 */
bool CustomSymbolSetDouble(const string symbol_name, ENUM_SYMBOL_INFO_DOUBLE property_id, double property_value);

/** Sets the string type property value for a custom symbol.
 * @param symbol_name  [in]  Custom symbol name.
 * @param property_id  [in]  Symbol property ID. The value can be one of the values of the ENUM_SYMBOL_INFO_STRING enumeration.
 * @param property_value  [in]  A string type variable containing the property value.
 * @return ( bool )
 */
bool CustomSymbolSetString(const string symbol_name, ENUM_SYMBOL_INFO_STRING property_id, string property_value);

/** Sets the margin rates depending on the order type and direction for a custom symbol.
 * @param symbol_name  [in]  Custom symbol name.
 * @param order_type  [in]  Order type.
 * @param initial_margin_rate  [in] A double type variable with an initial margin rate. Initial margin is a security deposit for 1 lot deal in the appropriate direction. Multiplying the rate by the initial margin, we receive the amount of funds to be reserved on the account when placing an order of the specified type.
 * @param maintenance_margin_rate  [in] A double type variable with a maintenance margin rate. Maintenance margin is a minimum amount for maintaining an open position of 1 lot in the appropriate direction. Multiplying the rate by the maintenance margin, we receive the amount of funds to be reserved on the account after an order of the specified type is activated.
 * @return ( bool )
 */
bool CustomSymbolSetMarginRate(const string symbol_name, ENUM_ORDER_TYPE order_type, double initial_margin_rate, double maintenance_margin_rate);

/** Sets the start and end time of the specified quotation session for the specified symbol and week day.
 * @param symbol_name  [in]  Custom symbol name.
 * @param day_of_week  [in]  Week day, value from the ENUM_DAY_OF_WEEK enumeration.
 * @param session_index  [in]  Index of the session, for which start and end times are to be set. Session indexing starts from 0.
 * @param from  [in]  Session start time in seconds from 00:00, data value in the variable is ignored.
 * @param to  [in]  Session end time in seconds from 00:00, data value in the variable is ignored.
 * @return ( bool )
 */
bool CustomSymbolSetSessionQuote(const string symbol_name, ENUM_DAY_OF_WEEK day_of_week, uint session_index, datetime from, datetime to);

/** Sets the start and end time of the specified trading session for the specified symbol and week day.
 * @param symbol_name  [in]  Custom symbol name.
 * @param day_of_week  [in]  Week day, value from the ENUM_DAY_OF_WEEK enumeration.
 * @param session_index  [in]  Index of the session, for which start and end times are to be set. Session indexing starts from 0.
 * @param from  [in]  Session start time in seconds from 00:00, data value in the variable is ignored.
 * @param to  [in]  Session end time in seconds from 00:00, data value in the variable is ignored.
 * @return ( bool )
 */
bool CustomSymbolSetSessionTrade(const string symbol_name, ENUM_DAY_OF_WEEK day_of_week, uint session_index, datetime from, datetime to);

/** Deletes all bars from the price history of the custom symbol in the specified time interval.
 * @param symbol  [in]  Custom symbol name.
 * @param from  [in]  Time of the first bar in the price history within the specified range to be removed.
 * @param to  [in]  Time of the last bar in the price history within the specified range to be removed.
 * @return ( int )
 */
int CustomRatesDelete(const string symbol, datetime from, datetime to);

/** Fully replaces the price history of the custom symbol within the specified time interval with the data from the MqlRates type array.
 * @param symbol  [in]  Custom symbol name.
 * @param from  [in]  Time of the first bar in the price history within the specified range to be updated.
 * @param to  [in]  Time of the last bar in the price history within the specified range to be updated.
 * @param rates  [in]   Array of the MqlRates type history data for M1.
 * @param count  [in]  Number of the rates[] array elements to be used for replacement. WHOLE_ARRAY means that all rates[] array elements should be used for replacement.
 * @return ( int )
 */
int CustomRatesReplace(const string symbol, datetime from, datetime to, const MqlRates (&rates)[], uint count = WHOLE_ARRAY);

/** Adds missing bars to the custom symbol history and replaces existing data with  the ones from the MqlRates type array.
 * @param symbol  [in]  Custom symbol name.
 * @param rates  [in]  Array of the MqlRates type history data for M1.
 * @param count  [in]  Number of the rates[] array elements to be used for update. WHOLE_ARRAY means that all rates[] array elements should be used.
 * @return ( int )
 */
int CustomRatesUpdate(const string symbol, const MqlRates (&rates)[], uint count = WHOLE_ARRAY);

/** Adds data from an array of the MqlTick type to the price history of a custom symbol. The custom symbol must be selected in the Market Watch window.
 * @param symbol  [in]  The name of the custom symbol.
 * @param ticks  [in]   An array of tick data of the MqlTick type arranged in order of time from earlier data to more recent ones, i.e. ticks[k].time_msc <= ticks[n].time_msc, if k<n.
 * @param count  [in]  Number of the ticks[] array elements to be used for adding. WHOLE_ARRAY means that all ticks[] array elements should be used.
 * @return ( int )
 */
int CustomTicksAdd(const string symbol, const MqlTick (&ticks)[], uint count = WHOLE_ARRAY);

/** Deletes all ticks from the price history of the custom symbol in the specified time interval.
 * @param symbol  [in]  Custom symbol name.
 * @param from_msc  [in]  Time of the first tick in the price history within the specified range to be removed. Time in milliseconds since 01.01.1970.
 * @param to_msc  [in]  Time of the last tick in the price history within the specified range to be removed. Time in milliseconds since 01.01.1970.
 * @return ( int )
 */
int CustomTicksDelete(const string symbol, long from_msc, long to_msc);

/** Fully replaces the price history of the custom symbol within the specified time interval with the data from the MqlTick type array.
 * @param symbol  [in]  Custom symbol name.
 * @param from_msc  [in]  Time of the first tick in the price history within the specified range to be removed. Time in milliseconds since 01.01.1970.
 * @param to_msc  [in]  Time of the last tick in the price history within the specified range to be removed. Time in milliseconds since 01.01.1970.
 * @param ticks  [in]   Array of the MqlTick type tick data ordered in time in ascending order.
 * @param count  [in]  Number of the ticks[] array elements to be used for replacement in the specified time interval. WHOLE_ARRAY means that all ticks[] array elements should be used.
 * @return ( int )
 */
int CustomTicksReplace(const string symbol, long from_msc, long to_msc, const MqlTick (&ticks)[], uint count = WHOLE_ARRAY);

/** Passes the status of the Depth of Market for a custom symbol. The function allows broadcasting the Depth of Market as if the prices arrive from a broker's server.
 * @param symbol  [in]  Custom symbol name.
 * @param books  [in]   The array of MqlBookInfo type data fully describing the Depth of Market status — all buy and sell requests. The passed Depth of Market status completely replaces the previous one.
 * @param count  [in]   The number of 'books' array elements to be passed to the function. The entire array is used by default.
 * @return ( int )
 */
int CustomBookAdd(const string symbol, const MqlBookInfo (&books)[], uint count = WHOLE_ARRAY);

/** Opens or creates a database in a specified file.
 * @param filename  [in]  File name relative to the "MQL5\Files" folder.
 * @param flags  [in]  Combination of flags from the ENUM_DATABASE_OPEN_FLAGS enumeration.
 * @return ( int )
 */
int DatabaseOpen(string filename, uint flags);

/** Closes a database.
 * @param database  [in]  Database handle received in DatabaseOpen().
 */
void DatabaseClose(int database);

/** Imports data from a file into a table.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @param table  [in]  Name of a table the data from a file is to be added to.
 * @param filename  [in]  CSV file or ZIP archive for reading data. The name may contain subdirectories and is set relative to the MQL5\Files folder.
 * @param flags  [in]  Combination of flags.
 * @param separator  [in]  Data separator in CSV file.
 * @param skip_rows  [in]  Number of initial strings to be skipped when reading data from the file.
 * @param skip_comments  [in]  String of characters for designating strings as comments. If any character from skip_comments is detected at the beginning of a string, such a string is considered a comment and is not imported.
 * @return ( long )
 */
long DatabaseImport(int database, const string table, const string filename, uint flags, const string separator, ulong skip_rows, const string skip_comments);

/** Exports a table or an SQL request execution result to a CSV file. The file is created in the UTF-8 encoding.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @param table_or_sql  [in]   A name of a table or a text of an SQL request whose results are to be exported to a specified file.
 * @param filename  [in]  A file name for data export. The path is set relative to the MQL5\Files folder.
 * @param flags  [in]  Combination of flags defining the output to a file.
 * @param separator  [in]  Data separator. If NULL is specified, the '\t' tabulation character is used as a separator.  An empty string "" is considered a valid separator but the obtained CSV file cannot be read as a table – it is considered as a set of strings.
 * @return ( long )
 */
long DatabaseExport(int database, const string table_or_sql, const string filename, uint flags, const string separator);

/** Prints a table or an SQL request execution result in the Experts journal.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @param table_or_sql  [in]  A name of a table or a text of an SQL request whose results are displayed in the Experts journal.
 * @param flags  [in]  Combination of flags defining the output formatting.
 * @return ( long )
 */
long DatabasePrint(int database, const string table_or_sql, uint flags);

/** Checks the presence of the table in a database.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @param table  [in]  Table name.
 * @return ( bool )
 */
bool DatabaseTableExists(int database, string table);

/** Executes a request to a specified database.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @param sql  [in]  SQL request.
 * @return ( bool )
 */
bool DatabaseExecute(int database, string sql);

/** Creates a handle of a request, which can then be executed using DatabaseRead().
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @param sql  [in]  SQL request that may contain automatically substituted parameters named ?1,?2,...
 * @param ...  [in]  Automatically substituted request parameters.
 * @return ( int )
 */
int DatabasePrepare(int database, string sql, ...);

/** Resets a request, like after calling DatabasePrepare().
 * @param request  [in]  The handle of the request obtained in DatabasePrepare().
 * @return ( int )
 */
int DatabaseReset(int request);

template <typename T>
/** Sets a parameter value in a request.
 * @param request  [in]  The handle of a request created in DatabasePrepare().
 * @param index  [in]  The parameter index in the request a value should be set for. The numbering starts with zero.
 * @param value  [in]  The value to be set. Extended types: bool, char, uchar, short, ushart, int, uint, color, datetime, long, ulong, float, double, string.
 * @return ( bool )
 */
bool DatabaseBind(int request, int index, T value);

template <typename T>
/** Sets an array as a parameter value.
 * @param request  [in]  The handle of a request created in DatabasePrepare().
 * @param index  [in]  The parameter index in the request a value should be set for. The numbering starts with zero.
 * @param array  [in]  The array to be set as a request parameter value.
 * @return ( bool )
 */
bool DatabaseBindArray(int request, int index, T (&array)[]);

/** Moves to the next entry as a result of a request.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @return ( bool )
 */
bool DatabaseRead(int request);

template <typename VOID>
/** Moves to the next record and reads data into the structure from it.
 * @param request  [in]  The handle of a request created in DatabasePrepare().
 * @param struct_object  [out]  The reference to the structure the data from the current record is to be read to. The structure should only have numerical types and/or strings (arrays are not allowed) as members and cannot be a descendant.
 * @return ( bool )
 */
bool DatabaseReadBind(int request, VOID &struct_object);

/** Removes a request created in DatabasePrepare().
 * @param request  [in]  Request handle received in DatabasePrepare().
 */
void DatabaseFinalize(int request);

/** Starts transaction execution.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @return ( bool )
 */
bool DatabaseTransactionBegin(int database);

/** Completes transaction execution.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @return ( bool )
 */
bool DatabaseTransactionCommit(int database);

/** Rolls back transactions.
 * @param database  [in]  Database handle received in DatabaseOpen().
 * @return ( bool )
 */
bool DatabaseTransactionRollback(int database);

/** Gets the number of fields in a request.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @return ( int )
 */
int DatabaseColumnsCount(int request);

/** Gets a field name by index.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @param name  [out]  Variable for writing the field name.
 * @return ( bool )
 */
bool DatabaseColumnName(int request, int column, string &name);

/** Gets a field type by index.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @return ( ENUM_DATABASE_FIELD_TYPE )
 */
ENUM_DATABASE_FIELD_TYPE DatabaseColumnType(int request, int column);

/** Gets a field size in bytes.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @return ( int )
 */
int DatabaseColumnSize(int request, int column);

/** Gets a field value as a string from the current record.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @param value  [out]  Reference to the variable for writing the field value.
 * @return ( bool )
 */
bool DatabaseColumnText(int request, int column, string &value);

/** Gets the int type value from the current record.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @param value  [out]  Reference to the variable for writing the field value.
 * @return ( bool )
 */
bool DatabaseColumnInteger(int request, int column, int &value);

/** Gets the long type value from the current record.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @param value  [out]  Reference to the variable for writing the field value.
 * @return ( bool )
 */
bool DatabaseColumnLong(int request, int column, long &value);

/** Gets the double type value from the current record.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @param value  [out]  Reference to the variable for writing the field value.
 * @return ( bool )
 */
bool DatabaseColumnDouble(int request, int column, double &value);

template <typename VOID>
/** Gets a field value as an array from the current record.
 * @param request  [in]  Request handle received in DatabasePrepare().
 * @param column  [in]  Field index in the request. Field numbering starts from zero and cannot exceed DatabaseColumnsCount() - 1.
 * @param data  [out]  Reference to the array for writing the field value.
 * @return ( bool )
 */
bool DatabaseColumnBlob(int request, int column, VOID (&data)[]);

/** It is a program breakpoint in debugging.
 */
void DebugBreak();

/** Returns the number of decimal digits determining the accuracy of price of the current chart symbol.
 * @return ( int )
 */
int Digits();

/**
 * The _Digits variable stores number of digits after a decimal point, which defines the price accuracy of the symbol of the current chart.
 */
int _Digits;

int CHAR_VALUE = 1;
int SHORT_VALUE = 2;
int INT_VALUE = 4;

uint COPY_TICKS_INFO = 0;  // ticks with Bid and/or Ask price changes are returned
uint COPY_TICKS_TRADE = 1; // ticks with the Last price and volume changes are returned
uint COPY_TICKS_ALL = 2;   // all ticks with any change are returned

/** Converting numeric value into text string.
 * @param value  [in]  Value with a floating point.
 * @param digits  [in]  Accuracy format. If the digits value is in the range between 0 and 16, a string presentation of a number with the specified number of digits after the point will be obtained. If the digits value is in the range between -1 and -16, a string representation of a number in the scientific format with the specified number of digits after the decimal point will be obtained. In all other cases the string value will contain 8 digits after the decimal point.
 * @return ( string )
 */
string DoubleToString(double value, int digits = 8);

/** Creates a graphic context for rendering frames of a specified size.
 * @param width  [in]  Frame width in pixels.
 * @param height  [in]  Frame height in pixels.
 * @return ( int )
 */
int DXContextCreate(uint width, uint height);

/** Changes a frame size of a graphic context created in DXContextCreate().
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param width  [in]  Frame width in pixels.
 * @param height  [in]  Frame height in pixels.
 * @return ( bool )
 */
bool DXContextSetSize(int context, uint &width, uint &height);

/** Sets a specified color to all pixels for the rendering buffer.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param color  [in]  Rendering color.
 * @return ( bool )
 */
bool DXContextClearColors(int context, const DXVector &color);

/** Clears the depth buffer.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @return ( bool )
 */
bool DXContextClearDepth(int context);

/** Gets an image of a specified size and offset from a graphic context.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param image  [out]  The array of image_width*image_height pixels in ARGB format.
 * @param image_width  [in]  Image width in pixels.
 * @param image_height  [in]  Image height in pixels.
 * @param image_offset_x  [in]  X offset.
 * @param image_offset_y  [in]  Y offset.
 * @return ( bool )
 */
bool DXContextGetColors(int context, uint (&image)[], int image_width = WHOLE_ARRAY, int image_height = WHOLE_ARRAY, int image_offset_x = 0, int image_offset_y = 0);

/** Gets the depth buffer of a rendered frame.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param image  [out]  Array of the rendered frame depth buffer values.
 * @return ( bool )
 */
bool DXContextGetDepth(int context, float (&image)[]);

template <typename VOID>
/** Creates a buffer of a specified type based on a data array.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param buffer_type  [in]  Buffer type from the ENUM_DX_BUFFER_TYPE enumeration.
 * @param data  [in]  Data for creating a buffer.
 * @param start  [in]  Index of the first element of the array, starting from which the array values are used to create a buffer. By default, the data is taken from the beginning of the array.
 * @param count  [in]  Number of values.  By default, the entire array is used (count=WHOLE_ARRAY).
 * @return ( int )
 */
int DXBufferCreate(int context, ENUM_DX_BUFFER_TYPE buffer_type, const VOID (&data)[], uint start = 0, uint count = WHOLE_ARRAY);

template <typename VOID>
/** Creates a 2D texture out of a rectangle of a specified size cut from a passed image.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param format  [in]  Pixel color format set from the ENUM_DX_FORMAT enumeration.
 * @param width  [in]  Width of an image a texture is based on.
 * @param height  [in]  Height of an image a texture is based on.
 * @param data  [in]  Pixel array of an image a texture is based on.
 * @param data_x  [in]  X coordinate of a rectangle (X offset) used to create a texture.
 * @param data_y  [in]  Y coordinate of a rectangle (Y offset) used to create a texture.
 * @param data_width  [in]  Width of a rectangle used to create a texture.
 * @param data_height  [in]  Height of a rectangle used to create a texture.
 * @return ( int )
 */
int DXTextureCreate(int context, ENUM_DX_FORMAT format, uint width, uint height, const VOID (&data)[], uint data_x, uint data_y, uint data_width, uint data_height);

/** Creates shader inputs.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param input_size  [in]  Size of the parameter structure in bytes.
 * @return ( int )
 */
int DXInputCreate(int context, uint input_size);

template <typename VOID>
/** Sets shader inputs.
 * @param input  [in]  Handle of inputs for a shader obtained in DXInputCreate().
 * @param data  [in]  Data for setting shader inputs.
 * @return ( bool )
 */
bool DXInputSet(int inp, const VOID &data);

/** Creates a shader of a specified type.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param shader_type  [out]  The value from the ENUM_DX_SHADER_TYPE enumeration.
 * @param source  [in]  Shader source code in HLSL 5.
 * @param entry_point  [in]  Entry point – function name in a source code.
 * @param compile_error  [in]  String for receiving compilation errors.
 * @return ( int )
 */
int DXShaderCreate(int context, ENUM_DX_SHADER_TYPE shader_type, const string source, const string entry_point, string &compile_error);

/** Sets vertex layout for the vertex shader.
 * @param shader  [in]  Handle of a vertex shader created in DXShaderCreate().
 * @param layout  [in]  Array of vertex fields description.
 * @return ( bool )
 */
bool DXShaderSetLayout(int shader, const DXVertexLayout (&layout)[]);

/** Sets shader inputs.
 * @param shader  [in]  Handle of a shader created in DXShaderCreate().
 * @param inputs  [in]  Array of input handles created using DXInputCreate().
 * @return ( bool )
 */
bool DXShaderInputsSet(int shader, const int (&inputs)[]);

/** Sets shader textures.
 * @param shader  [in]  Handle of a shader created in DXShaderCreate().
 * @param textures  [in]  Array of texture handles created using DXTextureCreate().
 * @return ( bool )
 */
bool DXShaderTexturesSet(int shader, const int (&textures)[]);

/** Renders the vertices of the vertex buffer set in DXBufferSet().
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param start  [in]  Index of the first vertex for rendering.
 * @param count  [in]  Number of vertices to render.
 * @return ( bool )
 */
bool DXDraw(int context, uint start = 0, uint count = WHOLE_ARRAY);

/** Renders graphic primitives described by the index buffer from DXBufferSet().
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param start  [in]  Index of the first primitive for rendering.
 * @param count  [in]  Number of primitives for rendering.
 * @return ( bool )
 */
bool DXDrawIndexed(int context, uint start = 0, uint count = WHOLE_ARRAY);

/** Sets the type of primitives for rendering using DXDrawIndexed().
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param primitive_topology  [in]  The value from the ENUM_DX_PRIMITIVE_TOPOLOGY enumeration.
 * @return ( bool )
 */
bool DXPrimiveTopologySet(int context, ENUM_DX_PRIMITIVE_TOPOLOGY primitive_topology);

/** Sets a buffer for the current rendering.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param buffer  [in]  Handle of the vertex or index buffer created in DXBufferCreate().
 * @param start  [in]  Index of the buffer first element. The data from the beginning of the buffer is used by default.
 * @param count  [in]  Number of values to be used. The default is all buffer values.
 * @return ( bool )
 */
bool DXBufferSet(int context, int buffer, uint start = 0, uint count = WHOLE_ARRAY);

/** Sets a shader for rendering.
 * @param context  [in]  Handle for a graphic context created in DXContextCreate().
 * @param shader  [in]  Handle of a shader created in DXShaderCreate().
 * @return ( bool )
 */
bool DXShaderSet(int context, int shader);

/** Returns a handle type.
 * @param handle  [in]     Handle.
 * @return ( ENUM_DX_HANDLE_TYPE )
 */
ENUM_DX_HANDLE_TYPE DXHandleType(int handle);

/** Releases a handle.
 * @param handle  [in]  Released handle.
 * @return ( bool )
 */
bool DXRelease(int handle);

template <typename ETS>
/** Converting an enumeration value of any type to a text form.
 * @param value  [in]  Any type enumeration value.
 * @return ( string )
 */
string EnumToString(ETS value);

/** The function generates a custom event for the specified chart.
 * @param chart_id  [in] Chart identifier. 0 means the current chart.
 * @param custom_event_id  [in] ID of the user events. This identifier is automatically added to the value CHARTEVENT_CUSTOM and converted to the integer type.
 * @param lparam  [in] Event parameter of the long type passed to the OnChartEvent function.
 * @param dparam  [in] Event parameter of the double type passed to the OnChartEvent function.
 * @param sparam  [in] Event parameter of the string type passed to the OnChartEvent function. If the string is longer than 63 characters, it is truncated.
 * @return ( bool )
 */
bool EventChartCustom(long chart_id, ushort custom_event_id, long lparam, double dparam, string sparam);

/** Specifies the client terminal that is necessary to stop the generation of events from Timer.
 */
void EventKillTimer();

/** The function indicates to the client terminal that timer events should be generated at intervals less than one second for this Expert Advisor or indicator.
 * @param milliseconds  [in]  Number of milliseconds defining the frequency of timer events.
 * @return ( bool )
 */
bool EventSetMillisecondTimer(int milliseconds);

/** The function indicates to the client terminal, that for this indicator or Expert Advisor, events from the timer must be generated with the specified periodicity.
 * @param seconds  [in] Number of seconds that determine the frequency of the timer event occurrence.
 * @return ( bool )
 */
bool EventSetTimer(int seconds);

/** The function returns the value of e raised to the power of d.
 * @param value  [in]  A number specifying the power.
 * @return ( double )
 */
double exp(double value);

/** The function stops an Expert Advisor and unloads it from a chart.
 */
void ExpertRemove();

/** The function returns the absolute value (modulus) of the specified numeric value.
 * @param value  [in]  Numeric value.
 * @return ( double )
 */
double fabs(double value);

/** Close the file previously opened by FileOpen().
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 */
void FileClose(int file_handle);

/** The function copies the original file from a local or shared folder to another file.
 * @param src_file_name  [in]  File name to copy.
 * @param common_flag  [in]  Flag determining the location of the file. If common_flag = FILE_COMMON, then the file is located in a shared folder for all client terminals \Terminal\Common\Files. Otherwise, the file is located in a local folder (for example, common_flag=0).
 * @param dst_file_name  [in]  Result file name.
 * @param mode_flags  [in]  Access flags. The parameter can contain only 2 flags: FILE_REWRITE and/or FILE_COMMON - other flags are ignored. If the file already exists, and the FILE_REWRITE flag hasn't been specified, then the file will not be rewritten, and the function will return false.
 * @return ( bool )
 */
bool FileCopy(const string src_file_name, int common_flag, const string dst_file_name, int mode_flags);

/** Deletes the specified file in a local folder of the client terminal.
 * @param file_name  [in]  File name.
 * @param common_flag  [in]  Flag determining the file location. If common_flag = FILE_COMMON, then the file is located in a shared folder for all client terminals \Terminal\Common\Files. Otherwise, the file is located in a local folder.
 * @return ( bool )
 */
bool FileDelete(const string file_name, int common_flag = 0);

/** The function closes the search handle.
 * @param search_handle  [in]  Search handle, retrieved by FileFindFirst().
 */
void FileFindClose(long search_handle);

/** The function starts the search of files or subdirectories in a directory in accordance with the specified filter.
 * @param file_filter  [in]  Search filter. A subdirectory (or sequence of nested subdirectories) relative to the \Files directory, in which files should be searched for, can be specified in the filter.
 * @param returned_filename  [out]  The returned parameter, where, in case of success, the name of the first found file or subdirectory is placed. Only the file name is returned (including the extension), the directories and subdirectories are not included no matter if they are specified or not in the search filter.
 * @param common_flag  [in]  Flag determining the location of the file. If common_flag = FILE_COMMON, then the file is located in a shared folder for all client terminals \Terminal\Common\Files. Otherwise, the file is located in a local folder.
 * @return ( long )
 */
long FileFindFirst(const string file_filter, string &returned_filename, int common_flag = 0);

/** The function continues the search started by FileFindFirst().
 * @param search_handle  [in]  Search handle, retrieved by FileFindFirst().
 * @param returned_filename  [out] The name of the next file or subdirectory found. Only the file name is returned (including the extension), the directories and subdirectories are not included no matter if they are specified or not in the search filter.
 * @return ( bool )
 */
bool FileFindNext(long search_handle, string &returned_filename);

/** Writes to a disk all data remaining in the input/output file buffer.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 */
void FileFlush(int file_handle);

/** Gets an integer property of a file. There are two variants of the function.
 * 1. Get a property by the handle of a file.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param property_id  [in]  File property ID. The value can be one of the values of the ENUM_FILE_PROPERTY_INTEGER enumeration. If the second variant of the function is used, you can receive only the values of the following properties: FILE_EXISTS, FILE_CREATE_DATE, FILE_MODIFY_DATE, FILE_ACCESS_DATE and FILE_SIZE.
 * @return ( long )
 */
long FileGetInteger(int file_handle, ENUM_FILE_PROPERTY_INTEGER property_id);

/** Gets an integer property of a file. There are two variants of the function.
 * 2. Get a property by the file name.
 * @param file_name  [in]  File name.
 * @param property_id  [in]  File property ID. The value can be one of the values of the ENUM_FILE_PROPERTY_INTEGER enumeration. If the second variant of the function is used, you can receive only the values of the following properties: FILE_EXISTS, FILE_CREATE_DATE, FILE_MODIFY_DATE, FILE_ACCESS_DATE and FILE_SIZE.
 * @param common_folder  [in]  Points to the file location. If the parameter is false, terminal data folder is viewed. Otherwise it is assumed that the file is in the shared folder of all terminals \Terminal\Common\Files (FILE_COMMON).
 * @return ( long )
 */
long FileGetInteger(const string file_name, ENUM_FILE_PROPERTY_INTEGER property_id, bool common_folder = false);

/** Defines the end of a file in the process of reading.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( bool )
 */
bool FileIsEnding(int file_handle);

/** Checks the existence of a file.
 * @param file_name  [in]  The name of the file being checked
 * @param common_flag  [in]  Flag determining the location of the file. If common_flag = FILE_COMMON, then the file is located in a shared folder for all client terminals \Terminal\Common\Files. Otherwise, the file is located in a local folder.
 * @return ( bool )
 */
bool FileIsExist(const string file_name, int common_flag = 0);

/** Defines the line end in a text file in the process of reading.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( bool )
 */
bool FileIsLineEnding(int file_handle);

/** Moves a file from a local or shared folder to another folder.
 * @param src_file_name  [in]  File name to move/rename.
 * @param common_flag  [in]  Flag determining the location of the file. If common_flag = FILE_COMMON, then the file is located in a shared folder for all client terminals \Terminal\Common\Files. Otherwise, the file is located in a local folder (common_flag=0).
 * @param dst_file_name  [in]  File name after operation
 * @param mode_flags  [in]  Access flags. The parameter can contain only 2 flags: FILE_REWRITE and/or FILE_COMMON - other flags are ignored. If the file already exists and the FILE_REWRITE flag isn't specified, the file will not be rewritten, and the function will return false.
 * @return ( bool )
 */
bool FileMove(const string src_file_name, int common_flag, const string dst_file_name, int mode_flags);

/** The function opens the file with the specified name and flag.
 * @param file_name  [in]  The name of the file can contain subfolders. If the file is opened for writing, these subfolders will be created if there are no such ones.
 * @param open_flags  [in]  combination of flags determining the operation mode for the file. The flags are defined as follows: FILE_READ file is opened for reading FILE_WRITE file is opened for writing FILE_BIN binary read-write mode (no conversion from a string and to a string) FILE_CSV file of csv type (all recorded items are converted to the strings of unicode or ansi type, and are separated by a delimiter) FILE_TXT a simple text file (the same as csv, but the delimiter is not taken into account) FILE_ANSI lines of ANSI type (single-byte symbols)  FILE_UNICODE lines of UNICODE type (double-byte characters) FILE_SHARE_READ shared reading from several programs FILE_SHARE_WRITE shared writing from several programs FILE_COMMON location of the file in a shared folder for all client terminals \Terminal\Common\Files
 * @param delimiter  [in]  value to be used as a separator in txt or csv-file. If the csv-file delimiter is not specified, it defaults to a tab. If the txt-file delimiter is not specified, then no separator is used. If the separator is clearly set to 0, then no separator is used.
 * @param codepage  [in]  The value of the code page. For the most-used code pages provide appropriate constants.
 * @return ( int )
 */
int FileOpen(string file_name, int open_flags, short delimiter = '\t', uint codepage = CP_ACP);

template <typename VOID>
/** Reads from a file of BIN type arrays of any type except string (may be an array of structures, not containing strings, and dynamic arrays).
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param array  [out] An array where the data will be loaded.
 * @param start  [in]  Start position to read from the array.
 * @param count  [in]  Number of elements to read. By default, reads the entire array (count=WHOLE_ARRAY).
 * @return ( uint )
 */
uint FileReadArray(int file_handle, VOID (&array)[], int start = 0, int count = WHOLE_ARRAY);

/** Reads from the file of CSV type string from the current position to a delimiter (or till the end of the text line) and converts the read string to a bool type value.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( bool )
 */
bool FileReadBool(int file_handle);

/** Reads from the file of CSV type a string of one of the formats: "YYYY.MM.DD HH:MI:SS", "YYYY.MM.DD" or "HH:MI:SS" - and converts it into a value of datetime type.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( datetime )
 */
datetime FileReadDatetime(int file_handle);

/** Reads a double-precision floating point number (double) from the current position of the binary file.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( double )
 */
double FileReadDouble(int file_handle);

/** Reads the single-precision floating point number (float) from the current position of the binary file.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( float )
 */
float FileReadFloat(int file_handle);

/** The function reads int, short or char value from the current position of the file pointer depending on the length specified in bytes.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param size  [in]  Number of bytes (up to 4 inclusive) that should be read. The corresponding constants are provided: CHAR_VALUE = 1, SHORT_VALUE = 2 and INT_VALUE = 4, so the function can read the whole value of char, short or int type.
 * @return ( int )
 */
int FileReadInteger(int file_handle, int size = INT_VALUE);

/** The function reads an integer of long type (8 bytes) from the current position of the binary file.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( long )
 */
long FileReadLong(int file_handle);

/** The function reads from the CSV file a string from the current position till a separator (or till the end of a text string) and converts the read string to a value of double type.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( double )
 */
double FileReadNumber(int file_handle);

/** The function reads a string from the current position of a file pointer in a file.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param length  [in]  Number of characters to read.
 * @return ( string )
 */
string FileReadString(int file_handle, int length = -1);

template <typename VOID>
/** The function reads contents into a structure passed as a parameter from a binary-file, starting with the current position of the file pointer.
 * @param file_handle  [in] File descriptor of an open bin-file.
 * @param struct_object  [out]  The object of this structure. The structure should not contain strings, dynamic arrays or virtual functions.
 * @param size  [in]  Number of bytes that should be read. If size is not specified or the indicated value is greater than the size of the structure, the exact size of the specified structure is used.
 * @return ( uint )
 */
uint FileReadStruct(int file_handle, const VOID &struct_object, int size = -1);

/** The function moves the position of the file pointer by a specified number of bytes relative to the specified position.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param offset  [in] The shift in bytes (may take a negative value).
 * @param origin  [in] The starting point for the displacement. Can be one of values of ENUM_FILE_POSITION.
 * @return ( bool )
 */
bool FileSeek(int file_handle, long offset, ENUM_FILE_POSITION origin);

/** The function returns the file size in bytes.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( ulong )
 */
ulong FileSize(int file_handle);

/** The file returns the current position of the file pointer of an open file.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @return ( ulong )
 */
ulong FileTell(int file_handle);

/** The function is intended for writing of data into a CSV file, delimiter being inserted automatically unless it is equal to 0. After writing into the file, the line end character "\r\n" will be added.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param ...  [in] The list of parameters separated by commas, to write to the file. The number of written parameters can be up to 63.
 * @return ( uint )
 */
uint FileWrite(int file_handle, ...);

template <typename VOID>
/** The function writes arrays of any type except for string to a BIN file (can be an array of structures not containing strings or dynamic arrays).
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param array  [out] Array for recording.
 * @param start  [in]  Initial index in the array (number of the first recorded element).
 * @param count  [in]  Number of items to write (WHOLE_ARRAY means that all items starting with the number start until the end of the array will be written).
 * @return ( uint )
 */
uint FileWriteArray(int file_handle, const VOID (&array)[], int start = 0, int count = WHOLE_ARRAY);

/** The function writes the value of a double parameter to a a bin-file, starting from the current position of the file pointer.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param value  [in]   The value of double type.
 * @return ( uint )
 */
uint FileWriteDouble(int file_handle, double value);

/** The function writes the value of the float parameter to a bin-file, starting from the current position of the file pointer.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param value  [in] The value of float type.
 * @return ( uint )
 */
uint FileWriteFloat(int file_handle, float value);

/** The function writes the value of the int parameter to a bin-file, starting from the current position of the file pointer.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param value  [in] Integer value.
 * @param size  [in] Number of bytes (up to 4 inclusive), that should be written. The corresponding constants are provided: CHAR_VALUE=1, SHORT_VALUE=2 and INT_VALUE=4, so the function can write the integer value of char, uchar, short, ushort, int, or uint type.
 * @return ( uint )
 */
uint FileWriteInteger(int file_handle, int value, int size = INT_VALUE);

/** The function writes the value of the long-type parameter to a bin-file, starting from the current position of the file pointer.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param value  [in] Value of type long.
 * @return ( uint )
 */
uint FileWriteLong(int file_handle, long value);

/** The function writes the value of a string-type parameter into a BIN, CSV or TXT file starting from the current position of the file pointer. When writing to a CSV or TXT file: if there is a symbol in the string '\n' (LF) without previous character '\r' (CR), then before '\n' the missing '\r' is added.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param text_string  [in]  String.
 * @param length  [in] The number of characters that you want to write. This option is needed for writing a string into a BIN file. If the size is not specified, then the entire string without the trailer 0 is written. If you specify a size smaller than the length of the string, then a part of the string without the trailer 0 is written. If you specify a size greater than the length of the string, the string is filled by the appropriate number of zeros. For files of CSV and TXT type, this parameter is ignored and the string is written entirely.
 * @return ( uint )
 */
uint FileWriteString(int file_handle, const string text_string, int length = -1);

template <typename VOID>
/** The function writes into a bin-file contents of a structure passed as a parameter, starting from the current position of the file pointer.
 * @param file_handle  [in]  File descriptor returned by FileOpen().
 * @param struct_object  [in] Reference to the object of this structure. The structure should not contain strings, dynamic arrays or virtual functions.
 * @param size  [in] Number of bytes that you want to record. If size is not specified or the specified number of bytes is greater than the size of the structure, the entire structure is written.
 * @return ( uint )
 */
uint FileWriteStruct(int file_handle, const VOID &struct_object, int size = -1);

/** The function returns integer numeric value closest from below.
 * @param val  [in]  Numeric value.
 * @return ( double )
 */
double floor(double value);

/** The function returns the maximal value of two values.
 * @param value1  [in]  First numeric value.
 * @param value2  [in]  Second numeric value.
 * @return ( double )
 */
double fmax(double value1, double value2);

/** The function returns the minimal value of two values.
 * @param value1  [in]  First numeric value.
 * @param value2  [in]  Second numeric value.
 * @return ( double )
 */
double fmin(double value1, double value2);

/** The function returns the real remainder of division of two numbers.
 * @param value  [in]  Dividend value.
 * @param value2  [in]  Divisor value.
 * @return ( double )
 */
double fmod(double value, double value2);

/** The function deletes all files in a specified folder.
 * @param folder_name  [in] The name of the directory where you want to delete all files. Contains the full path to the folder.
 * @param common_flag  [in]  Flag determining the location of the directory. If common_flag = FILE_COMMON, then the directory is in the shared folder for all client terminals \Terminal\Common\Files. Otherwise, the directory is in a local folder(MQL5\Files or MQL5\Tester\Files in case of testing).
 * @return ( bool )
 */
bool FolderClean(string folder_name, int common_flag = 0);

/** Creates a directory in the Files folder (depending on the common_flag value)
 * @param folder_name  [in]  Name of the directory to be created. Contains the relative path to the folder.
 * @param common_flag  [in]  Flag defining the directory location. If common_flag=FILE_COMMON, the directory is located in the common folder of all client terminals \Terminal\Common\Files. Otherwise, the directory is in the local folder (MQL5\Files or MQL5\Tester\Files when testing).
 * @return ( bool )
 */
bool FolderCreate(string folder_name, int common_flag = 0);

/** The function removes the specified directory. If the folder is not empty, then it can't be removed.
 * @param folder_name  [in] The name of the directory you want to delete. Contains the full path to the folder.
 * @param common_flag  [in]  Flag determining the location of the directory. If common_flag=FILE_COMMON, then the directory is in the shared folder for all client terminals \Terminal\Common\Files. Otherwise, the directory is in a local folder (MQL5\Files or MQL5\Tester\Files in the case of testing).
 * @return ( bool )
 */
bool FolderDelete(string folder_name, int common_flag = 0);

/** Adds a frame with data. There are two variants of the function.
 * 1. Adding data from a file
 * @param name  [in]  Public frame label. It can be used for a filter in the FrameFilter() function.
 * @param id  [in]  A public identifier of the frame. It can be used for a filter in the FrameFilter() function.
 * @param value  [in]  A numeric value to write into the frame. It is used to transmit a single pass result like in the OnTester() function.
 * @param filename  [in]  The name of the file that contains data to add to the frame. The file must be locate in the folder MQL5/Files.
 * @return ( bool )
 */
bool FrameAdd(const string name, long id, double value, const string filename);

template <typename VOID>
/** Adds a frame with data. There are two variants of the function.
 * 2. Adding data from an array of any type
 * @param name  [in]  Public frame label. It can be used for a filter in the FrameFilter() function.
 * @param id  [in]  A public identifier of the frame. It can be used for a filter in the FrameFilter() function.
 * @param value  [in]  A numeric value to write into the frame. It is used to transmit a single pass result like in the OnTester() function.
 * @param data  [in]  An array of any type to write into the frame. Passed by reference.
 * @return ( bool )
 */
bool FrameAdd(const string name, long id, double value, const VOID (&data)[]);

/** Sets the frame reading filter and moves the pointer to the beginning.
 * @param name  [in]  Public name/label
 * @param id  [in]  Public ID
 * @return ( bool )
 */
bool FrameFilter(const string name, long id);

/** Moves a pointer of frame reading to the beginning and resets a set filter.
 * @return ( bool )
 */
bool FrameFirst();

/** Receives input parameters, on which the frame with the specified pass number is formed.
 * @param pass  [in]  The number of a pass during optimization in the strategy tester.
 * @param parameters  [out]  A string array with the description of names and parameter values
 * @param parameters_count  [out]  The number of elements in the array parameters[].
 * @return ( bool )
 */
bool FrameInputs(ulong pass, string (&parameters)[], uint &parameters_count);

/** Reads a frame and moves the pointer to the next one. There are two variants of the function.
 * 1. Calling to receive one numeric value
 * @param pass  [out]  The number of a pass during optimization in the strategy tester.
 * @param name  [out]  The name of the identifier.
 * @param id  [out]  The value of the identifier.
 * @param value  [out]  A single numeric value.
 * @return ( bool )
 */
bool FrameNext(ulong &pass, string &name, long &id, double &value);

template <typename VOID>
/** Reads a frame and moves the pointer to the next one. There are two variants of the function.
 * 2. Calling to receive all the data of a frame
 * @param pass  [out]  The number of a pass during optimization in the strategy tester.
 * @param name  [out]  The name of the identifier.
 * @param id  [out]  The value of the identifier.
 * @param value  [out]  A single numeric value.
 * @param data  [out]  An array of any type.
 * @return ( bool )
 */
bool FrameNext(ulong &pass, string &name, long &id, double &value, VOID (&data)[]);

/** Returns the contents of the system variable _LastError.
 * @return ( int )
 */
int GetLastError();

template <typename GP>
/** The function returns the object pointer.
 * @param anyobject  [in]  Object of any class.
 */
void GetPointer(GP anyobject);

/** The GetTickCount() function returns the number of milliseconds that elapsed since the system start.
 * @return ( uint )
 */
uint GetTickCount();

/** Checks the existence of a global variable with the specified name
 * @param name  [in]  Global variable name.
 * @return ( bool )
 */
bool GlobalVariableCheck(string name);

/** Deletes a global variable from the client terminal.
 * @param name  [in]  Global variable name.
 * @return ( bool )
 */
bool GlobalVariableDel(string name);

/** Returns the value of an existing global variable of the client terminal. There are 2 variants of the function.
 * 1. Immediately returns the value of the global variable.
 * @param name  [in]  Global variable name.
 * @return ( double )
 */
double GlobalVariableGet(string name);

/** Returns the value of an existing global variable of the client terminal. There are 2 variants of the function.
 * 2. Returns true or false depending on the success of the function run.  If successful, the global variable of the client terminal is placed in a variable passed by reference in the second parameter.
 * @param name  [in]  Global variable name.
 * @param double_var  [out]  Target variable of the double type, which accepts the value stored in a the global variable of the client terminal.
 * @return ( bool )
 */
bool GlobalVariableGet(string name, double &double_var);

/** Returns the name of a global variable by its ordinal number.
 * @param index  [in]  Sequence number in the list of global variables. It should be greater than or equal to 0 and less than GlobalVariablesTotal().
 * @return ( string )
 */
string GlobalVariableName(int index);

/** Deletes global variables of the client terminal.
 * @param prefix_name  [in] Name prefix global variables to remove. If you specify a prefix NULL or empty string, then all variables that meet the data criterion will be deleted.
 * @param limit_data  [in] Date to select global variables by the time of their last modification. The function removes global variables, which were changed before this date. If the parameter is zero, then all variables that meet the first criterion (prefix) are deleted.
 * @return ( int )
 */
int GlobalVariablesDeleteAll(string prefix_name = NULL, datetime limit_data = 0);

/** Sets a new value for a global variable. If the variable does not exist, the system creates a new global variable.
 * @param name  [in]  Global variable name.
 * @param value  [in]  The new numerical value.
 * @return ( datetime )
 */
datetime GlobalVariableSet(string name, double value);

/** Sets the new value of the existing global variable if the current value equals to the third parameter check_value. If there is no global variable, the function will generate an error ERR_GLOBALVARIABLE_NOT_FOUND (4501) and return false.
 * @param name  [in]  The name of a global variable.
 * @param value  [in]  New value.
 * @param check_value  [in]   The value to check the current value of the global variable.
 * @return ( bool )
 */
bool GlobalVariableSetOnCondition(string name, double value, double check_value);

/** Forcibly saves contents of all global variables to a disk.
 */
void GlobalVariablesFlush();

/** Returns the total number of global variables of the client terminal.
 * @return ( int )
 */
int GlobalVariablesTotal();

/** The function attempts to create a temporary global variable. If the variable doesn't exist, the system creates a new temporary global variable.
 * @param name  [in]  The name of a temporary global variable.
 * @return ( bool )
 */
bool GlobalVariableTemp(string name);

/** Returns the time when the global variable was last accessed.
 * @param name  [in]  Name of the global variable.
 * @return ( datetime )
 */
datetime GlobalVariableTime(string name);

/** Returns the requested property of a deal. The deal property must be of the double type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param ticket_number  [in]  Deal ticket.
 * @param property_id  [in]  Identifier of a deal property. The value can be one of the values of the ENUM_DEAL_PROPERTY_DOUBLE enumeration.
 * @return ( bool )
 */
bool HistoryDealGetDouble(ulong ticket_number, ENUM_DEAL_PROPERTY_DOUBLE property_id);

/** Returns the requested property of a deal. The deal property must be of the double type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param ticket_number  [in]  Deal ticket.
 * @param property_id  [in]  Identifier of a deal property. The value can be one of the values of the ENUM_DEAL_PROPERTY_DOUBLE enumeration.
 * @param double_var  [out]  Variable of the double type that accepts the value of the requested property.
 * @return ( bool )
 */
bool HistoryDealGetDouble(ulong ticket_number, ENUM_DEAL_PROPERTY_DOUBLE property_id, double &double_var);

/** Returns the requested property of a deal. The deal property must be of the datetime, int type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param ticket_number  [in]  Trade ticket.
 * @param property_id  [in]  Identifier of the deal property. The value can be one of the values of the ENUM_DEAL_PROPERTY_INTEGER enumeration.
 * @return ( bool )
 */
bool HistoryDealGetInteger(ulong ticket_number, ENUM_DEAL_PROPERTY_INTEGER property_id);

/** Returns the requested property of a deal. The deal property must be of the datetime, int type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param ticket_number  [in]  Trade ticket.
 * @param property_id  [in]  Identifier of the deal property. The value can be one of the values of the ENUM_DEAL_PROPERTY_INTEGER enumeration.
 * @param long_var  [out]  Variable of the long type that accepts the value of the requested property.
 * @return ( bool )
 */
bool HistoryDealGetInteger(ulong ticket_number, ENUM_DEAL_PROPERTY_INTEGER property_id, long &long_var);

/** Returns the requested property of a deal. The deal property must be of the string type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param ticket_number  [in]  Deal ticket.
 * @param property_id  [in]  Identifier of the deal property. The value can be one of the values of the ENUM_DEAL_PROPERTY_STRING enumeration.
 * @return ( bool )
 */
bool HistoryDealGetString(ulong ticket_number, ENUM_DEAL_PROPERTY_STRING property_id);

/** Returns the requested property of a deal. The deal property must be of the string type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param ticket_number  [in]  Deal ticket.
 * @param property_id  [in]  Identifier of the deal property. The value can be one of the values of the ENUM_DEAL_PROPERTY_STRING enumeration.
 * @param string_var  [out]  Variable of the string type that accepts the value of the requested property.
 * @return ( bool )
 */
bool HistoryDealGetString(ulong ticket_number, ENUM_DEAL_PROPERTY_STRING property_id, string &string_var);

/** The function selects a deal for further processing and returns the deal ticket in history. Prior to calling HistoryDealGetTicket(), first it is necessary to receive the history of deals and orders using the HistorySelect() or HistorySelectByPosition() function.
 * @param index  [in]  Number of a deal in the list of deals
 * @return ( ulong )
 */
ulong HistoryDealGetTicket(int index);

/** Selects a deal in the history for further calling it through appropriate functions. It returns true if the function has been successfully completed. Returns false if the function has failed. For more details on error call GetLastError().
 * @param ticket  [in]  Deal ticket.
 * @return ( bool )
 */
bool HistoryDealSelect(ulong ticket);

/** Returns the number of deal in history. Prior to calling HistoryDealsTotal(), first it is necessary to receive the history of deals and orders using the HistorySelect() or HistorySelectByPosition() function.
 * @return ( int )
 */
int HistoryDealsTotal();

/** Returns the requested order property. The order property must be of the double type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param ticket_number  [in]  Order ticket.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_DOUBLE enumeration.
 * @return ( bool )
 */
bool HistoryOrderGetDouble(ulong ticket_number, ENUM_ORDER_PROPERTY_DOUBLE property_id);

/** Returns the requested order property. The order property must be of the double type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param ticket_number  [in]  Order ticket.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_DOUBLE enumeration.
 * @param double_var  [out]  Variable of the double type that accepts the value of the requested property.
 * @return ( bool )
 */
bool HistoryOrderGetDouble(ulong ticket_number, ENUM_ORDER_PROPERTY_DOUBLE property_id, double &double_var);

/** Returns the requested property of an order. The order property must be of datetime, int type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param ticket_number  [in]  Order ticket.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_INTEGER enumeration.
 * @return ( bool )
 */
bool HistoryOrderGetInteger(ulong ticket_number, ENUM_ORDER_PROPERTY_INTEGER property_id);

/** Returns the requested property of an order. The order property must be of datetime, int type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param ticket_number  [in]  Order ticket.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_INTEGER enumeration.
 * @param long_var  [out]  Variable of the long type that accepts the value of the requested property.
 * @return ( bool )
 */
bool HistoryOrderGetInteger(ulong ticket_number, ENUM_ORDER_PROPERTY_INTEGER property_id, long &long_var);

/** Returns the requested property of an order. The order property must be of the string type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param ticket_number  [in]  Order ticket.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_STRING enumeration.
 * @return ( bool )
 */
bool HistoryOrderGetString(ulong ticket_number, ENUM_ORDER_PROPERTY_STRING property_id);

/** Returns the requested property of an order. The order property must be of the string type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param ticket_number  [in]  Order ticket.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_STRING enumeration.
 * @param string_var  [out]  Variable of the string type.
 * @return ( bool )
 */
bool HistoryOrderGetString(ulong ticket_number, ENUM_ORDER_PROPERTY_STRING property_id, string &string_var);

/** Return the ticket of a corresponding order in the history. Prior to calling HistoryOrderGetTicket(), first it is necessary to receive the history of deals and orders using the HistorySelect() or HistorySelectByPosition() function.
 * @param index  [in]  Number of the order in the list of orders.
 * @return ( ulong )
 */
ulong HistoryOrderGetTicket(int index);

/** Selects an order from the history for further calling it through appropriate functions. It returns true if the function has been successfully completed. Returns false if the function has failed. For more details on error call GetLastError().
 * @param ticket  [in]  Order ticket.
 * @return ( bool )
 */
bool HistoryOrderSelect(ulong ticket);

/** Returns the number of orders in the history. Prior to calling HistoryOrdersTotal(), first it is necessary to receive the history of deals and orders using the HistorySelect() or HistorySelectByPosition() function.
 * @return ( int )
 */
int HistoryOrdersTotal();

/** Retrieves the history of deals and orders for the specified period of server time.
 * @param from_date  [in]  Start date of the request.
 * @param to_date  [in]  End date of the request.
 * @return ( bool )
 */
bool HistorySelect(datetime from_date, datetime to_date);

/** Retrieves the history of deals and orders having the specified position identifier.
 * @param position_id  [in]  Position identifier that is set to every executed order and every deal.
 * @return ( bool )
 */
bool HistorySelectByPosition(long position_id);

/** Returns the number of bars of a corresponding symbol and period, available in history.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @return ( int )
 */
int iBars(const string symbol, ENUM_TIMEFRAMES timeframe);

/** Search bar by time. The function returns the index of the bar corresponding to the specified time.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. PERIOD_CURRENT means the current chart period.
 * @param time  [in]  Time value to search for.
 * @param exact  [in]  A return value, in case the bar with the specified time is not found. If exact=false, iBarShift returns the index of the nearest bar, the Open time of which is less than the specified time (time_open<time). If such a bar is not found (history before the specified time is not available), then the function returns -1. If exact=true, iBarShift does not search for a nearest bar but immediately returns -1.
 * @return ( int )
 */
int iBarShift(const string symbol, ENUM_TIMEFRAMES timeframe, datetime time, bool exact = false);

/** Returns the Close price of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( double )
 */
double iClose(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the High price of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( double )
 */
double iHigh(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the index of the highest value found on the corresponding chart (shift relative to the current bar).
 * @param symbol  [in]  The symbol, on which the search will be performed. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param type  [in]  The identifier of the timeseries, in which the search will be performed. Can be equal to any value from ENUM_SERIESMODE.
 * @param count  [in]  The number of elements in the timeseries (from the current bar towards index increasing direction), among which the search should be performed.
 * @param start  [in]  The index (shift relative to the current bar) of the initial bar, from which search for the highest value begins. Negative values ​​are ignored and replaced with a zero value.
 * @return ( int )
 */
int iHighest(const string symbol, ENUM_TIMEFRAMES timeframe, ENUM_SERIESMODE type, int count = WHOLE_ARRAY, int start = 0);

/** Returns the Low price of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( double )
 */
double iLow(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the index of the smallest value found on the corresponding chart (shift relative to the current bar).
 * @param symbol  [in]  The symbol, on which the search will be performed. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param type  [in]  The identifier of the timeseries, in which the search will be performed. Can be equal to any value from ENUM_SERIESMODE.
 * @param count  [in]  The number of elements in the timeseries (from the current bar towards index increasing direction), among which the search should be performed.
 * @param start  [in]  The index (shift relative to the current bar) of the initial bar, from which search for the lowest value begins. Negative values ​​are ignored and replaced with a zero value.
 * @return ( int )
 */
int iLowest(const string symbol, ENUM_TIMEFRAMES timeframe, ENUM_SERIESMODE type, int count = WHOLE_ARRAY, int start = 0);

/** Returns the Open price of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( double )
 */
double iOpen(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the opening time of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( datetime )
 */
datetime iTime(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the tick volume of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( long )
 */
long iTickVolume(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the real volume of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( long )
 */
long iRealVolume(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the tick volume of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( long )
 */
long iVolume(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** Returns the spread value of the bar (indicated by the 'shift' parameter) on the corresponding chart.
 * @param symbol  [in]  The symbol name of the financial instrument. NULL means the current symbol.
 * @param timeframe  [in]  Period. It can be one of the values of the ENUM_TIMEFRAMES enumeration. 0 means the current chart period.
 * @param shift  [in]  The index of the received value from the timeseries (backward shift by specified number of bars relative to the current bar).
 * @return ( long )
 */
long iSpread(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/** The function creates Accelerator Oscillator in a global cache of the client terminal and returns its handle. It has only one buffer.
 * @param symbol [in]  The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period [in]  The value of the period can be one of the ENUM_TIMEFRAMES enumeration values, 0 means the current timeframe.
 * @return ( int )
 */
int iAC(string symbol, ENUM_TIMEFRAMES period);

/** The function returns the handle of the Accumulation/Distribution indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES enumeration values, 0 means the current timeframe.
 * @param applied_volume  [in]   The volume used. Can be any of ENUM_APPLIED_VOLUME values.
 * @return ( int )
 */
int iAD(string symbol, ENUM_TIMEFRAMES period, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of the Average Directional Movement Index indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param adx_period  [in]  Period to calculate the index.
 * @return ( int )
 */
int iADX(string symbol, ENUM_TIMEFRAMES period, int adx_period);

/** The function returns the handle of Average Directional Movement Index by Welles Wilder.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param adx_period  [in]  Period to calculate the index.
 * @return ( int )
 */
int iADXWilder(string symbol, ENUM_TIMEFRAMES period, int adx_period);

/** The function returns the handle of the Alligator indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param jaw_period  [in]  Averaging period for the blue line (Alligator's Jaw)
 * @param jaw_shift  [in] The shift of the blue line relative to the price chart.
 * @param teeth_period  [in]   Averaging period for the red line (Alligator's Teeth).
 * @param teeth_shift  [in] The shift of the red line relative to the price chart.
 * @param lips_period  [in]  Averaging period for the green line (Alligator's lips).
 * @param lips_shift  [in] The shift of the green line relative to the price chart.
 * @param ma_method  [in]  The method of averaging. Can be any of the ENUM_MA_METHOD values.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iAlligator(string symbol, ENUM_TIMEFRAMES period, int jaw_period, int jaw_shift, int teeth_period, int teeth_shift, int lips_period, int lips_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Adaptive Moving Average indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ama_period  [in]  The calculation period, on which the efficiency coefficient is calculated.
 * @param fast_ma_period  [in]  Fast period for the smoothing coefficient calculation for a rapid market.
 * @param slow_ma_period  [in]  Slow period for the smoothing coefficient calculation in the absence of trend.
 * @param ama_shift  [in]  Shift of the indicator relative to the price chart.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iAMA(string symbol, ENUM_TIMEFRAMES period, int ama_period, int fast_ma_period, int slow_ma_period, int ama_shift, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Awesome Oscillator indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @return ( int )
 */
int iAO(string symbol, ENUM_TIMEFRAMES period);

/** The function returns the handle of the Average True Range indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  The value of the averaging period for the indicator calculation.
 * @return ( int )
 */
int iATR(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/** The function returns the handle of the Bollinger Bands® indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param bands_period  [in]  The averaging period of the main line of the indicator.
 * @param bands_shift  [in] The shift the indicator relative to the price chart.
 * @param deviation  [in]  Deviation from the main line.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iBands(string symbol, ENUM_TIMEFRAMES period, int bands_period, int bands_shift, double deviation, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Bears Power indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  The value of the averaging period for the indicator calculation.
 * @return ( int )
 */
int iBearsPower(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/** The function returns the handle of the Bulls Power indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  The averaging period for the indicator calculation.
 * @return ( int )
 */
int iBullsPower(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/** The function returns the handle of the Market Facilitation Index indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param applied_volume  [in]  The volume used. Can be one of the constants of ENUM_APPLIED_VOLUME.
 * @return ( int )
 */
int iBWMFI(string symbol, ENUM_TIMEFRAMES period, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of the Commodity Channel Index indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]   The averaging period for the indicator calculation.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iCCI(string symbol, ENUM_TIMEFRAMES period, int ma_period, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Chaikin Oscillator indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param fast_ma_period  [in] Fast averaging period for calculations.
 * @param slow_ma_period  [in] Slow averaging period for calculations.
 * @param ma_method  [in]  Smoothing type. Can be one of the averaging constants of ENUM_MA_METHOD.
 * @param applied_volume  [in]  The volume used. Can be one of the constants of ENUM_APPLIED_VOLUME.
 * @return ( int )
 */
int iChaikin(string symbol, ENUM_TIMEFRAMES period, int fast_ma_period, int slow_ma_period, ENUM_MA_METHOD ma_method, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of a specified custom indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param name  [in]  Custom indicator name. If the name starts with the reverse slash '\', the EX5 indicator file is searched for relative to the MQL5\Indicators indicator root directory. Thus, when calling iCustom(Symbol(), Period(), "\FirstIndicator"...), the indicator is downloaded as MQL5\Indicators\FirstIndicator.ex5. If the path contains no file, the error 4802 (ERR_INDICATOR_CANNOT_CREATE) occurs.
 * @param ...  [in] input-parameters of a custom indicator, separated by commas.
 * @return ( int )
 */
int iCustom(string symbol, ENUM_TIMEFRAMES period, string name, ...);

/** The function returns the handle of the Double Exponential Moving Average indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Averaging period (bars count) for calculations.
 * @param ma_shift  [in]  Shift of the indicator relative to the price chart.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iDEMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the DeMarker indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Averaging period (bars count) for calculations.
 * @return ( int )
 */
int iDeMarker(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/** The function returns the handle of the Envelopes indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Averaging period for the main line.
 * @param ma_shift  [in] The shift of the indicator relative to the price chart.
 * @param ma_method  [in]  Smoothing type. Can be one of the values of ENUM_MA_METHOD.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @param deviation  [in]  The deviation from the main line (in percents).
 * @return ( int )
 */
int iEnvelopes(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price, double deviation);

/** The function returns the handle of the Force Index indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Averaging period for the indicator calculations.
 * @param ma_method  [in]  Smoothing type. Can be one of the values of ENUM_MA_METHOD.
 * @param applied_volume  [in]  The volume used. Can be one of the values of ENUM_APPLIED_VOLUME.
 * @return ( int )
 */
int iForce(string symbol, ENUM_TIMEFRAMES period, int ma_period, ENUM_MA_METHOD ma_method, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of the Fractals indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @return ( int )
 */
int iFractals(string symbol, ENUM_TIMEFRAMES period);

/** The function returns the handle of the Fractal Adaptive Moving Average indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Period (bars count) for the indicator calculations.
 * @param ma_shift  [in]  Shift of the indicator in the price chart.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iFrAMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Gator indicator. The Oscillator shows the difference between the blue and red lines of Alligator (upper histogram) and difference between red and green lines (lower histogram).
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param jaw_period  [in]  Averaging period for the blue line (Alligator's Jaw).
 * @param jaw_shift  [in] The shift of the blue line relative to the price chart. It isn't directly connected with the visual shift of the indicator histogram.
 * @param teeth_period  [in]   Averaging period for the red line (Alligator's Teeth).
 * @param teeth_shift  [in] The shift of the red line relative to the price chart. It isn't directly connected with the visual shift of the indicator histogram.
 * @param lips_period  [in]  Averaging period for the green line (Alligator's lips).
 * @param lips_shift  [in] The shift of the green line relative to the price charts. It isn't directly connected with the visual shift of the indicator histogram.
 * @param ma_method  [in]  Smoothing type. Can be one of the values of ENUM_MA_METHOD.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iGator(string symbol, ENUM_TIMEFRAMES period, int jaw_period, int jaw_shift, int teeth_period, int teeth_shift, int lips_period, int lips_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Ichimoku Kinko Hyo indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param tenkan_sen  [in] Averaging period for Tenkan Sen.
 * @param kijun_sen  [in] Averaging period for Kijun Sen.
 * @param senkou_span_b  [in] Averaging period for Senkou Span B.
 * @return ( int )
 */
int iIchimoku(string symbol, ENUM_TIMEFRAMES period, int tenkan_sen, int kijun_sen, int senkou_span_b);

/** The function returns the handle of the Moving Average indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Averaging period for the calculation of the moving average.
 * @param ma_shift  [in]  Shift of the indicator relative to the price chart.
 * @param ma_method  [in]  Smoothing type. Can be one of the ENUM_MA_METHOD values.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Moving Averages Convergence/Divergence indicator. In systems where OsMA is called MACD Histogram, this indicator is shown as two lines. In the client terminal the Moving Averages Convergence/Divergence looks like a histogram.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param fast_ema_period  [in]  Period for Fast Moving Average calculation.
 * @param slow_ema_period  [in]  Period for Slow Moving Average calculation.
 * @param signal_period  [in]  Period for Signal line calculation.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iMACD(string symbol, ENUM_TIMEFRAMES period, int fast_ema_period, int slow_ema_period, int signal_period, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Money Flow Index indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in] Averaging period (bars count) for the calculation.
 * @param applied_volume  [in]  The volume used. Can be any of the ENUM_APPLIED_VOLUME values.
 * @return ( int )
 */
int iMFI(string symbol, ENUM_TIMEFRAMES period, int ma_period, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of the Momentum indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param mom_period  [in]  Averaging period (bars count) for the calculation of the price change.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iMomentum(string symbol, ENUM_TIMEFRAMES period, int mom_period, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of a specified technical indicator created based on the array of parameters of MqlParam type.
 * @param symbol  [in] Name of a symbol, on data of which the indicator is calculated. NULL means the current symbol.
 * @param period  [in]  The value of the timeframe can be one of values of the ENUM_TIMEFRAMES enumeration, 0 means the current timeframe.
 * @param indicator_type  [in]  Indicator type, can be one of values of the ENUM_INDICATOR enumeration.
 * @param parameters_cnt  [in] The number of parameters passed in the parameters_array[] array. The array elements have a special structure type MqlParam. By default, zero - parameters are not passed. If you specify a non-zero number of parameters, the parameter parameters_array is obligatory. You can pass no more than 64 parameters.
 * @param parameters_array  [in]  An array of MqlParam type, whose elements contain the type and value of each input parameter of a technical indicator.
 * @return ( int )
 */
int IndicatorCreate(string symbol, ENUM_TIMEFRAMES period, ENUM_INDICATOR indicator_type, int parameters_cnt = 0, const MqlParam (&parameters_array)[] = NULL);

/** Based on the specified handle, returns the number of input parameters of the indicator, as well as the values and types of the parameters.
 * @param indicator_handle  [in]  The handle of the indicator, for which you need to know the number of parameters its is calculated on.
 * @param indicator_type  [out]  A variable if the ENUM_INDICATOR type, into which the indicator type will be written.
 * @param parameters  [out]  A dynamic array for receiving values of the MqlParam type, into which the list of indicator parameters will be written. The array size is returned by the IndicatorParameters() function.
 * @return ( int )
 */
int IndicatorParameters(int indicator_handle, ENUM_INDICATOR &indicator_type, MqlParam (&parameters)[]);

/** The function removes an indicator handle and releases the calculation block of the indicator, if it's not used by anyone else.
 * @param indicator_handle  [in]  indicator handle.
 * @return ( bool )
 */
bool IndicatorRelease(int indicator_handle);

/** The function sets the value of the corresponding indicator property. Indicator property must be of the double type. There are two variants of the function.
 * Call with specifying the property identifier.
 * @param prop_id  [in]  Identifier of the indicator property. The value can be one of the values of the ENUM_CUSTOMIND_PROPERTY_DOUBLE enumeration.
 * @param prop_value  [in]  Value of property.
 * @return ( bool )
 */
bool IndicatorSetDouble(int prop_id, double prop_value);

/** The function sets the value of the corresponding indicator property. Indicator property must be of the double type. There are two variants of the function.
 * Call with specifying the property identifier and modifier.
 * @param prop_id  [in]  Identifier of the indicator property. The value can be one of the values of the ENUM_CUSTOMIND_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. Only level properties require a modifier. Numbering of levels starts from 0. It means that in order to set property for the second level you need to specify 1 (1 less than when using compiler directive).
 * @param prop_value  [in]  Value of property.
 * @return ( bool )
 */
bool IndicatorSetDouble(int prop_id, int prop_modifier, double prop_value);

/** The function sets the value of the corresponding indicator property. Indicator property must be of the int or color type. There are two variants of the function.
 * Call with specifying the property identifier.
 * @param prop_id  [in]  Identifier of the indicator property. The value can be one of the values of the ENUM_CUSTOMIND_PROPERTY_INTEGER enumeration.
 * @param prop_value  [in]  Value of property.
 * @return ( bool )
 */
bool IndicatorSetInteger(int prop_id, int prop_value);

/** The function sets the value of the corresponding indicator property. Indicator property must be of the int or color type. There are two variants of the function.
 * Call with specifying the property identifier and modifier.
 * @param prop_id  [in]  Identifier of the indicator property. The value can be one of the values of the ENUM_CUSTOMIND_PROPERTY_INTEGER enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. Only level properties require a modifier.
 * @param prop_value  [in]  Value of property.
 * @return ( bool )
 */
bool IndicatorSetInteger(int prop_id, int prop_modifier, int prop_value);

/** The function sets the value of the corresponding indicator property. Indicator property must be of the string type. There are two variants of the function.
 * Call with specifying the property identifier.
 * @param prop_id  [in]  Identifier of the indicator property. The value can be one of the values of the ENUM_CUSTOMIND_PROPERTY_STRING enumeration.
 * @param prop_value  [in]  Value of property.
 * @return ( bool )
 */
bool IndicatorSetString(int prop_id, string prop_value);

/** The function sets the value of the corresponding indicator property. Indicator property must be of the string type. There are two variants of the function.
 * Call with specifying the property identifier and modifier.
 * @param prop_id  [in]  Identifier of the indicator property. The value can be one of the values of the ENUM_CUSTOMIND_PROPERTY_STRING enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. Only level properties require a modifier.
 * @param prop_value  [in]  Value of property.
 * @return ( bool )
 */
bool IndicatorSetString(int prop_id, int prop_modifier, string prop_value);

/** This function converts value of integer type into a string of a specified length and returns the obtained string.
 * @param number  [in]  Number for conversion.
 * @param str_len  [in]  String length. If the resulting string length is larger than the specified one, the string is not cut off. If it is smaller, filler symbols will be added to the left.
 * @param fill_symbol  [in]  Filler symbol. By default it is a space.
 * @return ( string )
 */
string IntegerToString(long number, int str_len = 0, ushort fill_symbol = ' ');

/** The function returns the handle of the On Balance Volume indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param applied_volume  [in]  The volume used. Can be any of the ENUM_APPLIED_VOLUME values.
 * @return ( int )
 */
int iOBV(string symbol, ENUM_TIMEFRAMES period, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of the Moving Average of Oscillator indicator. The OsMA oscillator shows the difference between values of MACD and its signal line. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param fast_ema_period  [in]  Period for Fast Moving Average calculation.
 * @param slow_ema_period  [in]  Period for Slow Moving Average calculation.
 * @param signal_period  [in]  Averaging period for signal line calculation.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iOsMA(string symbol, ENUM_TIMEFRAMES period, int fast_ema_period, int slow_ema_period, int signal_period, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Relative Strength Index indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  Averaging period for the RSI calculation.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iRSI(string symbol, ENUM_TIMEFRAMES period, int ma_period, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Relative Vigor Index indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  Averaging period for the RVI calculation.
 * @return ( int )
 */
int iRVI(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/** The function returns the handle of the Parabolic Stop and Reverse system indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param step  [in]  The step of price increment, usually  0.02.
 * @param maximum  [in]  The maximum step, usually 0.2.
 * @return ( int )
 */
int iSAR(string symbol, ENUM_TIMEFRAMES period, double step, double maximum);

/** Checks the forced shutdown of an mql5 program.
 * @return ( bool )
 */
bool IsStopped();

/** The function returns the handle of the Standard Deviation indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  Averaging period for the indicator calculations.
 * @param ma_shift  [in]  Shift of the indicator relative to the price chart.
 * @param ma_method  [in]  Type of averaging. Can be any of the ENUM_MA_METHOD values.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iStdDev(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Stochastic Oscillator indicator.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param Kperiod  [in]  Averaging period (bars count) for the %K line calculation.
 * @param Dperiod  [in]  Averaging period (bars count) for the %D line calculation.
 * @param slowing  [in]  Slowing value.
 * @param ma_method  [in]  Type of averaging. Can be any of the ENUM_MA_METHOD values.
 * @param price_field  [in]  Parameter of price selection for calculations. Can be one of the ENUM_STO_PRICE values.
 * @return ( int )
 */
int iStochastic(string symbol, ENUM_TIMEFRAMES period, int Kperiod, int Dperiod, int slowing, ENUM_MA_METHOD ma_method, ENUM_STO_PRICE price_field);

/** The function returns the handle of the Triple Exponential Moving Average indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  Averaging period (bars count) for calculation.
 * @param ma_shift  [in]  Shift of indicator relative to the price chart.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iTEMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Triple Exponential Moving Averages Oscillator indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param ma_period  [in]  Averaging period (bars count) for calculations.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iTriX(string symbol, ENUM_TIMEFRAMES period, int ma_period, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Variable Index Dynamic Average indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param cmo_period  [in]  Period (bars count) for the Chande Momentum Oscillator calculation.
 * @param ema_period  [in]   EMA period (bars count) for smoothing factor calculation.
 * @param ma_shift  [in]  Shift of the indicator relative to the price chart.
 * @param applied_price  [in]  The price used. Can be any of the price constants ENUM_APPLIED_PRICE or a handle of another indicator.
 * @return ( int )
 */
int iVIDyA(string symbol, ENUM_TIMEFRAMES period, int cmo_period, int ema_period, int ma_shift, ENUM_APPLIED_PRICE applied_price);

/** The function returns the handle of the Volumes indicator.  It has an only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param applied_volume  [in]   The volume used. Can be any of the ENUM_APPLIED_VOLUME values.
 * @return ( int )
 */
int iVolumes(string symbol, ENUM_TIMEFRAMES period, ENUM_APPLIED_VOLUME applied_volume);

/** The function returns the handle of the Larry Williams' Percent Range indicator. It has only one buffer.
 * @param symbol  [in] The symbol name of the security, the data of which should be used to calculate the indicator. The NULL value means the current symbol.
 * @param period  [in] The value of the period can be one of the ENUM_TIMEFRAMES values, 0 means the current timeframe.
 * @param calc_period  [in]  Period (bars count) for the indicator calculation.
 * @return ( int )
 */
int iWPR(string symbol, ENUM_TIMEFRAMES period, int calc_period);

/** The function returns a natural logarithm.
 * @param value  [in]  Value logarithm of which is to be found.
 * @return ( double )
 */
double log(double value);

/** Returns the logarithm of a number by base 10.
 * @param value  [in]  Numeric value the common logarithm of which is to be calculated.
 * @return ( double )
 */
double log10(double value);

/** Provides opening of Depth of Market for a selected symbol, and subscribes for receiving notifications of the DOM changes.
 * @param symbol  [in] The name of a symbol, whose Depth of Market is to be used in the Expert Advisor or script.
 * @return ( bool )
 */
bool MarketBookAdd(string symbol);

/** Returns a structure array MqlBookInfo containing records of the Depth of Market of a specified symbol.
 * @param symbol  [in] Symbol name.
 * @param book  [in] Reference to an array of Depth of Market records. The array can be pre-allocated for a sufficient number of records. If a dynamic array hasn't been pre-allocated in the operating memory, the client terminal will distribute the array itself.
 * @return ( bool )
 */
bool MarketBookGet(string symbol, MqlBookInfo (&book)[]);

/** Provides closing of Depth of Market for a selected symbol, and cancels the subscription for receiving notifications of the DOM changes.
 * @param symbol  [in] Symbol name.
 * @return ( bool )
 */
bool MarketBookRelease(string symbol);

/** The function returns the absolute value (modulus) of the specified numeric value.
 * @param value  [in]  Numeric value.
 * @return ( double )
 */
double MathAbs(double value);

/** The function returns the arccosine of x within the range 0 to π in radians.
 * @param val  [in]  The val value between -1 and 1, the arc cosine of which is to be calculated.
 * @return ( double )
 */
double MathArccos(double val);

/** The function returns the arc sine of x within the range of -π/2 to π/2 radians.
 * @param val  [in]   The val value between -1 and 1, the arc sine of which is to be calculated.
 * @return ( double )
 */
double MathArcsin(double val);

/** The function returns the arc tangent of x. If x is equal to 0, the function returns 0.
 * @param value  [in]  A number representing a tangent.
 * @return ( double )
 */
double MathArctan(double value);

/** The function returns integer numeric value closest from above.
 * @param value  [in]  Numeric value.
 * @return ( double )
 */
double MathCeil(double value);

/** The function returns the cosine of an angle.
 * @param value  [in]  Angle in radians.
 * @return ( double )
 */
double MathCos(double value);

/** The function returns the value of e raised to the power of d.
 * @param value  [in]  A number specifying the power.
 * @return ( double )
 */
double MathExp(double value);

/** The function returns integer numeric value closest from below.
 * @param value  [in]  Numeric value.
 * @return ( double )
 */
double MathFloor(double value);

/** It checks the correctness of a real number.
 * @param number  [in]  Checked numeric value.
 * @return ( bool )
 */
bool MathIsValidNumber(double number);

/** The function returns a natural logarithm.
 * @param value  [in]  Value logarithm of which is to be found.
 * @return ( double )
 */
double MathLog(double value);

/** Returns the logarithm of a number by base 10.
 * @param val  [in]  Numeric value the common logarithm of which is to be calculated.
 * @return ( double )
 */
double MathLog10(double val);

/** The function returns the maximal value of two values.
 * @param value1  [in]  First numeric value.
 * @param value2  [in]  Second numeric value.
 * @return ( double )
 */
double MathMax(double value1, double value2);

/** The function returns the minimal value of two values.
 * @param value1  [in]  First numeric value.
 * @param value2  [in]  Second numeric value.
 * @return ( double )
 */
double MathMin(double value1, double value2);

/** The function returns the real remainder of division of two numbers.
 * @param value  [in]  Dividend value.
 * @param value2  [in]  Divisor value.
 * @return ( double )
 */
double MathMod(double value, double value2);

/** The function raises a base to a specified power.
 * @param base  [in]  Base.
 * @param exponent  [in]  Exponent value.
 * @return ( double )
 */
double MathPow(double base, double exponent);

/** Returns a pseudorandom integer within the range of 0 to 32767.
 * @return ( int )
 */
int MathRand();

/** The function returns a value rounded off to the nearest integer of the specified numeric value.
 * @param value  [in]  Numeric value before rounding.
 * @return ( double )
 */
double MathRound(double value);

/** Returns the sine of a specified angle.
 * @param value  [in]  Angle in radians.
 * @return ( double )
 */
double MathSin(double value);

/** Returns the square root of a number.
 * @param value  [in]  Positive numeric value.
 * @return ( double )
 */
double MathSqrt(double value);

/** Sets the starting point for generating a series of pseudorandom integers.
 * @param seed  [in]  Starting number for the sequence of random numbers.
 */
void MathSrand(int seed);

/** The function returns a tangent of a number.
 * @param rad  [in]  Angle in radians.
 * @return ( double )
 */
double MathTan(double rad);

/** It creates and shows a message box and manages it. A message box contains a message and header, any combination of predefined signs and command buttons.
 * @param text  [in]  Text, containing message to output.
 * @param caption  [in]  Optional text to be displayed in the box header. If the parameter is empty, Expert Advisor name is shown in the box header.
 * @param flags  [in]  Optional flags defining appearance and behavior of a message box. Flags can be a combination of a special group of flags.
 * @return ( int )
 */
int MessageBox(string text, string caption = NULL, int flags = 0);

/** Returns the value of a corresponding property of a running mql5 program.
 * @param property_id  [in] Identifier of a property. Can be one of values of the ENUM_MQL_INFO_INTEGER enumeration.
 * @return ( int )
 */
int MQLInfoInteger(int property_id);

/** Returns the value of a corresponding property of a running mql5 program.
 * @param property_id  [in] Identifier of a property. Can be one of the ENUM_MQL_INFO_STRING enumeration.
 * @return ( string )
 */
string MQLInfoString(int property_id);

/** Rounding floating point number to a specified accuracy.
 * @param value  [in] Value with a floating point.
 * @param digits  [in]  Accuracy format, number of digits after point (0-8).
 * @return ( double )
 */
double NormalizeDouble(double value, int digits);

template <typename OC>
/** The function creates an object with the specified name, type, and the initial coordinates in the specified chart subwindow. During creation up to 30 coordinates can be specified.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object. The name must be unique within a chart, including its subwindows.
 * @param type  [in]  Object type. The value can be one of the values of the ENUM_OBJECT enumeration.
 * @param sub_window  [in]  Number of the chart subwindow. 0 means the main chart window. The specified subwindow must exist, otherwise the function returns false.
 * @param time_price  [in]  The coordinates of the time and price anchor point, separated by commas.
 * @return ( bool )
 */
bool ObjectCreate(long chart_id, string name, ENUM_OBJECT type, int sub_window, OC time_price...);

/** The function removes the object with the specified name from the specified chart.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of object to be deleted.
 * @return ( bool )
 */
bool ObjectDelete(long chart_id, string name);

/** The function searches for an object with the specified name in the chart with the specified ID.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  The name of the searched object.
 * @return ( int )
 */
int ObjectFind(long chart_id, string name);

/** The function returns the value of the corresponding object property. The object property must be of the double type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. For the first variant, the default modifier value is equal to 0. Most properties do not require a modifier.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @return ( bool )
 */
bool ObjectGetDouble(long chart_id, string name, ENUM_OBJECT_PROPERTY_DOUBLE prop_id, int prop_modifier = 0);

/** The function returns the value of the corresponding object property. The object property must be of the double type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function.If successful, the property value is placed to a receiving variable passed by reference by the last parameter.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. For the first variant, the default modifier value is equal to 0. Most properties do not require a modifier.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @param double_var  [out]  Variable of the double type that received the value of the requested property.
 * @return ( bool )
 */
bool ObjectGetDouble(long chart_id, string name, ENUM_OBJECT_PROPERTY_DOUBLE prop_id, int prop_modifier, double &double_var);

/** The function returns the value of the corresponding object property. The object property must be of the datetime, int, color, bool or char type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. For the first variant, the default modifier value is equal to 0. Most properties do not require a modifier.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @return ( bool )
 */
bool ObjectGetInteger(long chart_id, string name, ENUM_OBJECT_PROPERTY_INTEGER prop_id, int prop_modifier = 0);

/** The function returns the value of the corresponding object property. The object property must be of the datetime, int, color, bool or char type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function.If successful, the property value is placed to a receiving variable passed by reference by the last parameter.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. For the first variant, the default modifier value is equal to 0. Most properties do not require a modifier.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @param long_var  [out]  Variable of the long type that receives the value of the requested property.
 * @return ( bool )
 */
bool ObjectGetInteger(long chart_id, string name, ENUM_OBJECT_PROPERTY_INTEGER prop_id, int prop_modifier, long &long_var);

/** The function returns the value of the corresponding object property. The object property must be of the string type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_STRING enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. For the first variant, the default modifier value is equal to 0. Most properties do not require a modifier.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @return ( bool )
 */
bool ObjectGetString(long chart_id, string name, ENUM_OBJECT_PROPERTY_STRING prop_id, int prop_modifier = 0);

/** The function returns the value of the corresponding object property. The object property must be of the string type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function.If successful, the property value is placed to a receiving variable passed by reference by the last parameter.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_STRING enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. For the first variant, the default modifier value is equal to 0. Most properties do not require a modifier.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @param string_var  [out]  Variable of the string type that receives the value of the requested properties.
 * @return ( bool )
 */
bool ObjectGetString(long chart_id, string name, ENUM_OBJECT_PROPERTY_STRING prop_id, int prop_modifier, string &string_var);

/** The function returns the time value for the specified price value of the specified object.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param value  [in]  Price value.
 * @param line_id  [in]  Line identifier.
 * @return ( datetime )
 */
datetime ObjectGetTimeByValue(long chart_id, string name, double value, int line_id);

/** The function returns the price value for the specified time value of the specified object.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param time  [in]  Time value.
 * @param line_id  [in]  Line ID.
 * @return ( double )
 */
double ObjectGetValueByTime(long chart_id, string name, datetime time, int line_id);

/** The function changes coordinates of the specified anchor point of the object.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param point_index  [in]  Index of the anchor point. The number of anchor points depends on the type of object.
 * @param time  [in]  Time coordinate of the selected anchor point.
 * @param price  [in]  Price coordinate of the selected anchor point.
 * @return ( bool )
 */
bool ObjectMove(long chart_id, string name, int point_index, datetime time, double price);

/** The function returns the name of the corresponding object in the specified chart, in the specified subwindow, of the specified type.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param pos  [in]  Ordinal number of the object according to the specified filter by the number and type of the subwindow.
 * @param sub_window  [in]  Number of the chart subwindow. 0 means the main chart window, -1 means all the subwindows of the chart, including the main window.
 * @param type  [in]  Type of the object. The value can be one of the values of the ENUM_OBJECT enumeration. -1 means all types.
 * @return ( string )
 */
string ObjectName(long chart_id, int pos, int sub_window = -1, int type = -1);

/** Removes all objects from the specified chart, specified chart subwindow, of the specified type.
 * Removes all objects from the specified chart, specified chart subwindow, of the specified type.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param sub_window  [in] Number of the chart subwindow. 0 means the main chart window, -1 means all the subwindows of the chart, including the main window.
 * @param type  [in]  Type of the object. The value can be one of the values of the ENUM_OBJECT enumeration. -1 means all types.
 * @return ( int )
 */
int ObjectsDeleteAll(long chart_id, int sub_window = -1, int type = -1);

/** Removes all objects from the specified chart, specified chart subwindow, of the specified type.
 * Removes all objects of the specified type using prefix in object names.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param prefix  [in]  Prefix in object names. All objects whose names start with this set of characters will be removed from chart. You can specify prefix as 'name' or 'name*' – both variants will work the same. If an empty string is specified as the prefix, objects with all possible names will be removed.
 * @param sub_window  [in] Number of the chart subwindow. 0 means the main chart window, -1 means all the subwindows of the chart, including the main window.
 * @param type  [in]  Type of the object. The value can be one of the values of the ENUM_OBJECT enumeration. -1 means all types.
 * @return ( int )
 */
int ObjectsDeleteAll(long chart_id, const string prefix, int sub_window = -1, int type = -1);

/** The function sets the value of the corresponding object property. The object property must be of the double type. There are 2 variants of the function.
 * Setting property value, without modifier
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @return ( bool )
 */
bool ObjectSetDouble(long chart_id, string name, ENUM_OBJECT_PROPERTY_DOUBLE prop_id, double prop_value);

/** The function sets the value of the corresponding object property. The object property must be of the double type. There are 2 variants of the function.
 * Setting a property value indicating the modifier
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool ObjectSetDouble(long chart_id, string name, ENUM_OBJECT_PROPERTY_DOUBLE prop_id, int prop_modifier, double prop_value);

/** The function sets the value of the corresponding object property. The object property must be of the datetime, int, color, bool or char type. There are 2 variants of the function.
 * Setting property value, without modifier
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_INTEGER enumeration.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool ObjectSetInteger(long chart_id, string name, ENUM_OBJECT_PROPERTY_INTEGER prop_id, long prop_value);

/** The function sets the value of the corresponding object property. The object property must be of the datetime, int, color, bool or char type. There are 2 variants of the function.
 * Setting a property value indicating the modifier
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool ObjectSetInteger(long chart_id, string name, ENUM_OBJECT_PROPERTY_INTEGER prop_id, int prop_modifier, long prop_value);

/** The function sets the value of the corresponding object property. The object property must be of the string type. There are 2 variants of the function.
 * Setting property value, without modifier
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_STRING enumeration.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool ObjectSetString(long chart_id, string name, ENUM_OBJECT_PROPERTY_STRING prop_id, string prop_value);

/** The function sets the value of the corresponding object property. The object property must be of the string type. There are 2 variants of the function.
 * Setting a property value indicating the modifier
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param name  [in]  Name of the object.
 * @param prop_id  [in]  ID of the object property. The value can be one of the values of the ENUM_OBJECT_PROPERTY_STRING enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property.  It denotes the number of the level in Fibonacci tools and in the graphical object Andrew's pitchfork. The numeration of levels starts from zero.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool ObjectSetString(long chart_id, string name, ENUM_OBJECT_PROPERTY_STRING prop_id, int prop_modifier, string prop_value);

/** The function returns the number of objects in the specified chart, specified subwindow, of the specified type.
 * @param chart_id  [in]  Chart identifier. 0 means the current chart.
 * @param sub_window  [in]  Number of the chart subwindow. 0 means the main chart window, -1 means all the subwindows of the chart, including the main window.
 * @param type  [in]  Type of the object. The value can be one of the values of the ENUM_OBJECT enumeration. -1 means all types.
 * @return ( int )
 */
int ObjectsTotal(long chart_id, int sub_window = -1, int type = -1);

template <typename VOID>
/** The function is called in scripts and services when the Start event occurs. The function is intended for one-time execution of actions implemented in a program. There are two function types.
 * The version that returns the result
 * @return ( int )
 */
int OnStart(VOID);

template <typename VOID>
/** The function is called in scripts and services when the Start event occurs. The function is intended for one-time execution of actions implemented in a program. There are two function types.
 * The version without a result return is left only for compatibility with old codes. It is not recommended for use.
 */
void OnStart(VOID);

template <typename VOID>
/** The function is called in indicators and EAs when the Init event occurs. It is used to initialize a running MQL5 program. There are two function types.
 * The version that returns the result
 * @return ( int )
 */
int OnInit(VOID);

template <typename VOID>
/** The function is called in indicators and EAs when the Init event occurs. It is used to initialize a running MQL5 program. There are two function types.
 * The version without a result return is left only for compatibility with old codes. It is not recommended for use.
 */
void OnInit(VOID);

/** The function is called in indicators and EAs when the Deinit event occurs. It is used to deinitialize a running MQL5 program.
 * @param reason  [in]  Deinitialization reason code.
 */
void OnDeinit(const int reason);

template <typename VOID>
/** The NewTick event is generated only for EAs upon receiving a new tick for a symbol of the chart the EA is attached to.
 */
void OnTick(VOID);

/** The function is called in the indicators when the Calculate event occurs for processing price data changes. There are two function types. Only one of them can be used within a single indicator.
 * Calculation based on data array
 * @param rates_total  [in]  Size of the price[] array or input series available to the indicator for calculation. In the second function type, the parameter value corresponds to the number of bars on the chart it is launched at.
 * @param prev_calculated  [in] Contains the value returned by the OnCalculate() function during the previous call. It is designed to skip the bars that have not changed since the previous launch of this function.
 * @param begin  [in]  Index value in the price[] array meaningful data starts from. It allows you to skip missing or initial data, for which there are no correct values.
 * @param price  [in]  Array of values for calculations. One of the price timeseries or a calculated indicator buffer can be passed as the price[] array. Type of data passed for calculation can be defined using the _AppliedTo predefined variable.
 * @return ( int )
 */
int OnCalculate(const int rates_total, const int prev_calculated, const int begin, const double (&price)[]);

/** The function is called in the indicators when the Calculate event occurs for processing price data changes. There are two function types. Only one of them can be used within a single indicator.
 * Calculations based on the current timeframe timeseries
 * @param rates_total  [in]  Size of the price[] array or input series available to the indicator for calculation. In the second function type, the parameter value corresponds to the number of bars on the chart it is launched at.
 * @param prev_calculated  [in] Contains the value returned by the OnCalculate() function during the previous call. It is designed to skip the bars that have not changed since the previous launch of this function.
 * @param time  [in]  Array with bar open time values.
 * @param open  [in]  Array with Open price values.
 * @param high  [in]  Array with High price values.
 * @param low  [in]  Array with Low price values.
 * @param close  [in]  Array with Close price values.
 * @param tick_volume  [in]  Array with tick volume values.
 * @param volume  [in]  Array with trade volume values.
 * @param spread  [in]  Array with spread values for bars.
 * @return ( int )
 */
int OnCalculate(const int rates_total, const int prev_calculated, const datetime (&time)[], const double (&open)[], const double (&high)[], const double (&low)[], const double (&close)[], const long (&tick_volume)[], const long (&volume)[], const int (&spread)[]);

/** The Timer event is periodically generated by the client terminal for an EA, which activated the timer using the EventSetTimer() function.
 */
void OnTimer(void);

/** OnTrade() is called only for Expert Advisors. It is not used in indicators and scripts even if you add there a function with the same name and type.
 */
void OnTrade(void);

/** The function is called in EAs when the TradeTransaction event occurs. The function is meant for handling trade request execution results.
 * @param trans  [in]  MqlTradeTransaction type variable describing a transaction made on a trading account.
 * @param request  [in]  MqlTradeRequest type variable describing a trade request that led to a transaction. It contains the values for TRADE_TRANSACTION_REQUEST type transaction only.
 * @param result  [in]  MqlTradeResult type variable containing an execution result of a trade request that led to a transaction. It contains the values for TRADE_TRANSACTION_REQUEST type transaction only.
 */
void OnTradeTransaction(const MqlTradeTransaction &trans, const MqlTradeRequest &request, const MqlTradeResult &result);

/** The function is called in indicators and EAs when the BookEvent event occurs. It is meant for handling Depth of Market changes.
 * @param symbol  [in]  Name of a symbol the BookEvent has arrived for
 */
void OnBookEvent(const string &symbol);

/** The function is called in indicators and EAs when the ChartEvent event occurs. The function is meant for handling chart changes made by a user or an MQL5 program.
 * @param id  [in]  Event ID from the ENUM_CHART_EVENT enumeration.
 * @param lparam  [in]  long type event parameter
 * @param dparam  [in]  double type event parameter
 * @param sparam  [in]  string type event parameter
 */
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam);

/** The function is called in Expert Advisors when the Tester event occurs to perform necessary actions after testing.
 * @return ( double )
 */
double OnTester(void);

template <typename VOID>
/** The function is called in EAs when the TesterInit event occurs to perform necessary actions before optimization in the strategy tester. There are two function types.
 * The version that returns the result
 * @return ( int )
 */
int OnTesterInit(VOID);

template <typename VOID>
/** The function is called in EAs when the TesterInit event occurs to perform necessary actions before optimization in the strategy tester. There are two function types.
 * The version without a result return is left only for compatibility with old codes. Not recommended for use
 */
void OnTesterInit(VOID);

/** The function is called in EAs when the TesterDeinit event occurs after EA optimization.
 */
void OnTesterDeinit(void);

/** The function is called in EAs when the TesterPass event occurs for handling a new data frame during EA optimization.
 */
void OnTesterPass(void);

/** The function calculates the margin required for the specified order type, on the current account, in the current market environment not taking into account current pending orders and open positions. It allows the evaluation of margin for the trade operation planned. The value is returned in the account currency.
 * @param action  [in]  The order type, can be one of the values of the ENUM_ORDER_TYPE enumeration.
 * @param symbol  [in]  Symbol name.
 * @param volume  [in]  Volume of the trade operation.
 * @param price  [in]  Open price.
 * @param margin  [out]  The variable, to which the value of the required margin will be written in case the function is successfully executed. The calculation is performed as if there were no pending orders and open positions on the current account. The margin value depends on many factors, and can differ in different market environments.
 * @return ( bool )
 */
bool OrderCalcMargin(ENUM_ORDER_TYPE action, string symbol, double volume, double price, double &margin);

/** The function calculates the profit for the current account, in the current market conditions, based on the parameters passed. The function is used for pre-evaluation of the result of a trade operation. The value is returned in the account currency.
 * @param action  [in]  Type of the order, can be one of the two values of the ENUM_ORDER_TYPE enumeration: ORDER_TYPE_BUY or ORDER_TYPE_SELL.
 * @param symbol  [in]  Symbol name.
 * @param volume  [in]  Volume of the trade operation.
 * @param price_open  [in]  Open price.
 * @param price_close  [in]  Close price.
 * @param profit  [out]  The variable, to which the calculated value of the profit will be written in case the function is successfully executed. The estimated profit value depends on many factors, and can differ in different market environments.
 * @return ( bool )
 */
bool OrderCalcProfit(ENUM_ORDER_TYPE action, string symbol, double volume, double price_open, double price_close, double &profit);

/** The OrderCheck() function checks if there are enough money to execute a required trade operation. The check results are placed to the fields of the MqlTradeCheckResult structure.
 * @param request  [in]  Pointer to the structure of the MqlTradeRequest type, which describes the required trade action.
 * @param result  [in,out]  Pointer to the structure of the MqlTradeCheckResult type, to which the check result will be placed.
 * @return ( bool )
 */
bool OrderCheck(MqlTradeRequest &request, MqlTradeCheckResult &result);

/** Returns the requested property of an order, pre-selected using OrderGetTicket or OrderSelect. The order property must be of the double type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_DOUBLE enumeration.
 * @return ( bool )
 */
bool OrderGetDouble(ENUM_ORDER_PROPERTY_DOUBLE property_id);

/** Returns the requested property of an order, pre-selected using OrderGetTicket or OrderSelect. The order property must be of the double type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of a function. If successful, the value of the property is placed in a target variable passed by reference by the last parameter.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_DOUBLE enumeration.
 * @param double_var  [out]  Variable of the double type that accepts the value of the requested property.
 * @return ( bool )
 */
bool OrderGetDouble(ENUM_ORDER_PROPERTY_DOUBLE property_id, double &double_var);

/** Returns the requested order property, pre-selected using OrderGetTicket or OrderSelect. Order property must be of the datetime, int type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_INTEGER enumeration.
 * @return ( bool )
 */
bool OrderGetInteger(ENUM_ORDER_PROPERTY_INTEGER property_id);

/** Returns the requested order property, pre-selected using OrderGetTicket or OrderSelect. Order property must be of the datetime, int type. There are 2 variants of the function.
 * 2. Returns true or false depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_INTEGER enumeration.
 * @param long_var  [out]  Variable of the long type that accepts the value of the requested property.
 * @return ( bool )
 */
bool OrderGetInteger(ENUM_ORDER_PROPERTY_INTEGER property_id, long &long_var);

/** Returns the requested order property, pre-selected using OrderGetTicket or OrderSelect. The order property must be of the string type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_STRING enumeration.
 * @return ( bool )
 */
bool OrderGetString(ENUM_ORDER_PROPERTY_STRING property_id);

/** Returns the requested order property, pre-selected using OrderGetTicket or OrderSelect. The order property must be of the string type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function. If successful, the value of the property is placed into a target variable passed by reference by the last parameter.
 * @param property_id  [in]  Identifier of the order property. The value can be one of the values of the ENUM_ORDER_PROPERTY_STRING enumeration.
 * @param string_var  [out]  Variable of the string type that accepts the value of the requested property.
 * @return ( bool )
 */
bool OrderGetString(ENUM_ORDER_PROPERTY_STRING property_id, string &string_var);

/** Returns ticket of a corresponding order and automatically selects the order for further working with it using functions.
 * @param index  [in]  Number of an order in the list of current orders.
 * @return ( ulong )
 */
ulong OrderGetTicket(int index);

/** Selects an order to work with. Returns true if the function has been successfully completed. Returns false if the function completion has failed. For more information about an error call GetLastError().
 * @param ticket  [in]  Order ticket.
 * @return ( bool )
 */
bool OrderSelect(ulong ticket);

/** The OrderSend() function is used for executing trade operations by sending requests to a trade server.
 * @param request  [in]  Pointer to a structure of MqlTradeRequest type describing the trade activity of the client.
 * @param result  [in,out]  Pointer to a structure of MqlTradeResult type describing the result of trade operation in case of a successful completion (if true is returned).
 * @return ( bool )
 */
bool OrderSend(MqlTradeRequest &request, MqlTradeResult &result);

/** The OrderSendAsync() function is used for conducting asynchronous trade operations without waiting for the trade server's response to a sent request. The function is designed for high-frequency trading, when under the terms of the trading algorithm it is unacceptable to waste time waiting for a response from the server.
 * @param request  [in]  A pointer to a structure of the MqlTradeRequest type that describes the trade action of the client.
 * @param result  [in,out]  A pointer to a structure of the MqlTradeResult type that describes the result of a trade operation in case of successful execution of the function (if true is returned).
 * @return ( bool )
 */
bool OrderSendAsync(MqlTradeRequest &request, MqlTradeResult &result);

/** Returns the number of current orders.
 * @return ( int )
 */
int OrdersTotal();

/** Receives data on the values range and the change step for an input variable when optimizing an Expert Advisor in the Strategy Tester. There are 2 variants of the function.
 * 1. Receiving data for the integer type input parameter
 * @param name  [in]  input variable ID. These variables are external parameters of an application. Their values can be specified when launching on a chart or during a single test.
 * @param enable  [out]  Flag that this parameter can be used to enumerate the values during the optimization in the Strategy Tester.
 * @param value  [out]  Parameter value.
 * @param start  [out]  Initial parameter value during the optimization.
 * @param step  [out]  Parameter change step when enumerating its values.
 * @param stop  [out]  Final parameter value during the optimization.
 * @return ( bool )
 */
bool ParameterGetRange(const string name, bool &enable, long &value, long &start, long &step, long &stop);

/** Receives data on the values range and the change step for an input variable when optimizing an Expert Advisor in the Strategy Tester. There are 2 variants of the function.
 * 2. Receiving data for the real type input parameter
 * @param name  [in]  input variable ID. These variables are external parameters of an application. Their values can be specified when launching on a chart or during a single test.
 * @param enable  [out]  Flag that this parameter can be used to enumerate the values during the optimization in the Strategy Tester.
 * @param value  [out]  Parameter value.
 * @param start  [out]  Initial parameter value during the optimization.
 * @param step  [out]  Parameter change step when enumerating its values.
 * @param stop  [out]  Final parameter value during the optimization.
 * @return ( bool )
 */
bool ParameterGetRange(const string name, bool &enable, double &value, double &start, double &step, double &stop);

/** Specifies the use of input variable when optimizing an Expert Advisor in the Strategy Tester: value, change step, initial and final values. There are 2 variants of the function.
 * 1. Specifying the values for the integer type input parameter
 * @param name  [in]  input or sinput variable ID. These variables are external parameters of an application. Their values can be specified when launching the program.
 * @param enable  [in]  Enable this parameter to enumerate the values during the optimization in the Strategy Tester.
 * @param value  [in]  Parameter value.
 * @param start  [in]  Initial parameter value during the optimization.
 * @param step  [in]  Parameter change step when enumerating its values.
 * @param stop  [in]  Final parameter value during the optimization.
 * @return ( bool )
 */
bool ParameterSetRange(const string name, bool enable, long value, long start, long step, long stop);

/** Specifies the use of input variable when optimizing an Expert Advisor in the Strategy Tester: value, change step, initial and final values. There are 2 variants of the function.
 * 2. Specifying the values for the real type input parameter
 * @param name  [in]  input or sinput variable ID. These variables are external parameters of an application. Their values can be specified when launching the program.
 * @param enable  [in]  Enable this parameter to enumerate the values during the optimization in the Strategy Tester.
 * @param value  [in]  Parameter value.
 * @param start  [in]  Initial parameter value during the optimization.
 * @param step  [in]  Parameter change step when enumerating its values.
 * @param stop  [in]  Final parameter value during the optimization.
 * @return ( bool )
 */
bool ParameterSetRange(const string name, bool enable, double value, double start, double step, double stop);

/** Returns the current chart timeframe.
 * @return ( ENUM_TIMEFRAMES )
 */
ENUM_TIMEFRAMES Period();

/** This function returns number of seconds in a period.
 * @param period  [in]  Value of a chart period from the enumeration ENUM_TIMEFRAMES. If the parameter isn't specified, it returns the number of seconds of the current chart period, at which the program runs.
 * @return ( int )
 */
int PeriodSeconds(ENUM_TIMEFRAMES period);

/** It plays a sound file.
 * @param filename  [in]  Path to a sound file. If filename=NULL, the playback is stopped.
 * @return ( bool )
 */
bool PlaySound(string filename);

/** The function sets the value of the corresponding property of the corresponding indicator line. The indicator property must be of the int, color, bool or char type. There are 2 variants of the function.
 * Call indicating identifier of the property.
 * @param plot_index  [in]  Index of the graphical plotting
 * @param prop_id  [in] The value can be one of the values of the ENUM_PLOT_PROPERTY_INTEGER enumeration.
 * @return ( int )
 */
int PlotIndexGetInteger(int plot_index, int prop_id);

/** The function sets the value of the corresponding property of the corresponding indicator line. The indicator property must be of the int, color, bool or char type. There are 2 variants of the function.
 * Call indicating the identifier and modifier of the property.
 * @param plot_index  [in]  Index of the graphical plotting
 * @param prop_id  [in] The value can be one of the values of the ENUM_PLOT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. Only color index properties require a modifier.
 * @return ( int )
 */
int PlotIndexGetInteger(int plot_index, int prop_id, int prop_modifier);

/** The function sets the value of the corresponding property of the corresponding indicator line. The indicator property must be of the double type.
 * @param plot_index  [in]  Index of the graphical plotting
 * @param prop_id  [in] The value can be one of the values of the ENUM_PLOT_PROPERTY_DOUBLE enumeration.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool PlotIndexSetDouble(int plot_index, int prop_id, double prop_value);

/** The function sets the value of the corresponding property of the corresponding indicator line. The indicator property must be of the int, char, bool or color type. There are 2 variants of the function.
 * Call indicating identifier of the property.
 * @param plot_index  [in]  Index of the graphical plotting
 * @param prop_id  [in] The value can be one of the values of the ENUM_PLOT_PROPERTY_INTEGER enumeration.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool PlotIndexSetInteger(int plot_index, int prop_id, int prop_value);

/** The function sets the value of the corresponding property of the corresponding indicator line. The indicator property must be of the int, char, bool or color type. There are 2 variants of the function.
 * Call indicating the identifier and modifier of the property.
 * @param plot_index  [in]  Index of the graphical plotting
 * @param prop_id  [in] The value can be one of the values of the ENUM_PLOT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier  [in]  Modifier of the specified property. Only color index properties require a modifier.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool PlotIndexSetInteger(int plot_index, int prop_id, int prop_modifier, int prop_value);

/** The function sets the value of the corresponding property of the corresponding indicator line. The indicator property must be of the string type.
 * @param plot_index  [in]  Index of graphical plot
 * @param prop_id  [in] The value can be one of the values of the ENUM_PLOT_PROPERTY_STRING enumeration.
 * @param prop_value  [in]  The value of the property.
 * @return ( bool )
 */
bool PlotIndexSetString(int plot_index, int prop_id, string prop_value);

/** Returns the point size of the current symbol in the quote currency.
 * @return ( double )
 */
double Point();

/**
 * The _Point variable contains the point size of the current symbol in the quote currency.
 */
double _Point;

/** The function returns the requested property of an open position, pre-selected using PositionGetSymbol or PositionSelect. The position property must be of the double type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param property_id  [in]  Identifier of a position property. The value can be one of the values of the ENUM_POSITION_PROPERTY_DOUBLE enumeration.
 * @return ( bool )
 */
bool PositionGetDouble(ENUM_POSITION_PROPERTY_DOUBLE property_id);

/** The function returns the requested property of an open position, pre-selected using PositionGetSymbol or PositionSelect. The position property must be of the double type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function execution. If successful, the value of the property is placed in a receiving variable passed by reference by the last parameter.
 * @param property_id  [in]  Identifier of a position property. The value can be one of the values of the ENUM_POSITION_PROPERTY_DOUBLE enumeration.
 * @param double_var  [out]  Variable of the double type, accepting the value of the requested property.
 * @return ( bool )
 */
bool PositionGetDouble(ENUM_POSITION_PROPERTY_DOUBLE property_id, double &double_var);

/** The function returns the requested property of an open position, pre-selected using PositionGetSymbol or PositionSelect. The position property should be of datetime, int type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param property_id  [in]  Identifier of a position property. The value can be one of the values of the ENUM_POSITION_PROPERTY_INTEGER enumeration.
 * @return ( bool )
 */
bool PositionGetInteger(ENUM_POSITION_PROPERTY_INTEGER property_id);

/** The function returns the requested property of an open position, pre-selected using PositionGetSymbol or PositionSelect. The position property should be of datetime, int type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function execution. If successful, the value of the property is placed in a receiving variables passed by reference by the last parameter.
 * @param property_id  [in]  Identifier of a position property. The value can be one of the values of the ENUM_POSITION_PROPERTY_INTEGER enumeration.
 * @param long_var  [out]  Variable of the long type accepting the value of the requested property.
 * @return ( bool )
 */
bool PositionGetInteger(ENUM_POSITION_PROPERTY_INTEGER property_id, long &long_var);

/** The function returns the requested property of an open position, pre-selected using PositionGetSymbol or PositionSelect. The position property should be of the string type. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param property_id  [in]  Identifier of a position property. The value can be one of the values of the ENUM_POSITION_PROPERTY_STRING enumeration.
 * @return ( bool )
 */
bool PositionGetString(ENUM_POSITION_PROPERTY_STRING property_id);

/** The function returns the requested property of an open position, pre-selected using PositionGetSymbol or PositionSelect. The position property should be of the string type. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of the function execution. If successful, the value of the property is placed in a receiving variables passed by reference by the last parameter.
 * @param property_id  [in]  Identifier of a position property. The value can be one of the values of the ENUM_POSITION_PROPERTY_STRING enumeration.
 * @param string_var  [out]  Variable of the string type accepting the value of the requested property.
 * @return ( bool )
 */
bool PositionGetString(ENUM_POSITION_PROPERTY_STRING property_id, string &string_var);

/** Returns the symbol corresponding to the open position and automatically selects the position for further working with it using functions PositionGetDouble, PositionGetInteger, PositionGetString.
 * @param index  [in]  Number of the position in the list of open positions.
 * @return ( string )
 */
string PositionGetSymbol(int index);

/** The function returns the ticket of a position with the specified index in the list of open positions and automatically selects the position to work with using functions PositionGetDouble, PositionGetInteger, PositionGetString.
 * @param index  [in]  The index of a position in the list of open positions, numeration starts with 0.
 * @return ( ulong )
 */
ulong PositionGetTicket(int index);

/** Chooses an open position for further working with it. Returns true if the function is successfully completed. Returns false in case of failure. To obtain information about the error, call GetLastError().
 * @param symbol  [in]  Name of the financial security.
 * @return ( bool )
 */
bool PositionSelect(string symbol);

/** Selects an open position to work with based on the ticket number specified in the position. If successful, returns true. Returns false if the function failed. Call GetLastError() for error details.
 * @param ticket  [in]  Position ticket.
 * @return ( bool )
 */
bool PositionSelectByTicket(ulong ticket);

/** Returns the number of open positions.
 * @return ( int )
 */
int PositionsTotal();

/** The function raises a base to a specified power.
 * @param base  [in]  Base.
 * @param exponent  [in]  Exponent value.
 * @return ( double )
 */
double pow(double base, double exponent);

template <typename P>
/** It enters a message in the Expert Advisor log. Parameters can be of any type.
 * @param any  [in]  Any values separated by commas. The number of parameters cannot exceed 64.
 */
void Print(P any, ...);

/** It formats and enters sets of symbols and values in the Expert Advisor log in accordance with a preset format.
 * @param format_string  [in]  A format string consists of simple symbols, and if the format string is followed by arguments, it also contains format specifications.
 * @param ...  [in]  Any values of simple types separated by commas. Total number of parameters can't exceed 64 including the format string.
 */
void PrintFormat(string format_string, ...);

/** Форматирует и печатает наборы символов и значений в журнал экспертов в соответствии с заданным форматом.
 * @param format_string  [in]  Строка формата состоит из обычных символов и, если за строкой формата следуют аргументы, еще и спецификации формата.
 * @param ...  [in]  Любые значения простых типов, разделенные запятыми. Общее количество параметров не может превышать 64, включая форматную строку.
 */
void printf(string format_string, ...);

/** Returns a pseudorandom integer within the range of 0 to 32767.
 * @return ( int )
 */
int rand();

/** Sets the value of the predefined variable _LastError into zero.
 */
void ResetLastError();

/** Creates an image resource based on a data set. There are two variants of the function:
 * Creating a resource based on a file
 * @param resource_name  [in]  Resource name.
 * @param path  [in]  Relative path to the file containing the data for the resource.
 * @return ( bool )
 */
bool ResourceCreate(const string resource_name, const string path);

/** Creates an image resource based on a data set. There are two variants of the function:
 * Creating a resource based on the array of pixels
 * @param resource_name  [in]  Resource name.
 * @param data  [in]  A one-dimensional or two-dimensional array for creating a complete image.
 * @param img_width  [in]  The width of the rectangular image area in pixels to be placed in the resource in the form of an image. It cannot be greater than the data_width value.
 * @param img_height  [in]  The height of the rectangular image area in pixels to be placed in the resource in the form of an image.
 * @param data_xoffset  [in]  The horizontal rightward offset of the rectangular area of the image.
 * @param data_yoffset  [in]  The vertical downward offset of the rectangular area of the image.
 * @param data_width  [in]  Required only for one-dimensional arrays. It denotes the full width of the image from the data set. If data_width=0, it is assumed to be equal to img_width. For two-dimensional arrays the parameter is ignored and is assumed to be equal to the second dimension of the data[] array.
 * @param color_format  [in]  Color processing method, from a value from the ENUM_COLOR_FORMAT enumeration.
 * @return ( bool )
 */
bool ResourceCreate(const string resource_name, const uint (&data)[], uint img_width, uint img_height, uint data_xoffset, uint data_yoffset, uint data_width, ENUM_COLOR_FORMAT color_format);

/** The function deletes dynamically created resource (freeing the memory allocated for it).
 * @param resource_name  [in]  Resource name should start with "::".
 * @return ( bool )
 */
bool ResourceFree(const string resource_name);

/** The function reads data from the graphical resource created by ResourceCreate() function or saved in EX5 file during compilation.
 * @param resource_name  [in]  Name of the graphical resource containing an image. To gain access to its own resources, the name is used in brief form "::resourcename". If we download a resource from a compiled EX5 file, the full name should be used with the path relative to MQL5 directory, file and resource names – "path\filename.ex5::resourcename".
 * @param data  [in]  One- or two-dimensional array for receiving data from the graphical resource.
 * @param width  [out]  Graphical resource image width in pixels.
 * @param height  [out]  Graphical resource image height in pixels.
 * @return ( bool )
 */
bool ResourceReadImage(const string resource_name, uint &data[], uint &width, uint &height);

/** Saves a resource into the specified file.
 * @param resource_name  [in]  The name of the resource, must start with "::".
 * @param file_name  [in]  The name of the file relative to MQL5\Files.
 * @return ( bool )
 */
bool ResourceSave(const string resource_name, const string file_name);

/** The function returns a value rounded off to the nearest integer of the specified numeric value.
 * @param value  [in]  Numeric value before rounding.
 * @return ( double )
 */
double round(double value);

/** Sends a file at the address, specified in the setting window of the "FTP" tab.
 * @param filename  [in]   Name of sent file.
 * @param ftp_path  [in]   FTP catalog. If a directory is not specified, directory described in settings is used.
 * @return ( bool )
 */
bool SendFTP(string filename, string ftp_path = NULL);

/** Sends an email at the address specified in the settings window of the "Email" tab.
 * @param subject  [in]  Email header.
 * @param some_text  [in]  Email body.
 * @return ( bool )
 */
bool SendMail(string subject, string some_text);

/** Sends push notifications to the mobile terminals, whose MetaQuotes IDs are specified in the "Notifications" tab.
 * @param text  [in]   The text of the notification. The message length should not exceed 255 characters.
 * @return ( bool )
 */
bool SendNotification(string text);

/** Returns information about the state of historical data. There are 2 variants of function calls.
 * Directly returns the property value.
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param prop_id  [in]  Identifier of the requested property, value of the ENUM_SERIES_INFO_INTEGER enumeration.
 * @return ( bool )
 */
bool SeriesInfoInteger(string symbol_name, ENUM_TIMEFRAMES timeframe, ENUM_SERIES_INFO_INTEGER prop_id);

/** Returns information about the state of historical data. There are 2 variants of function calls.
 * Returns true or false depending on the success of the function run.
 * @param symbol_name  [in]  Symbol name.
 * @param timeframe  [in]  Period.
 * @param prop_id  [in]  Identifier of the requested property, value of the ENUM_SERIES_INFO_INTEGER enumeration.
 * @param long_var  [out]  Variable to which the value of the requested property is placed.
 * @return ( bool )
 */
bool SeriesInfoInteger(string symbol_name, ENUM_TIMEFRAMES timeframe, ENUM_SERIES_INFO_INTEGER prop_id, long &long_var);

/** The function binds a specified indicator buffer with one-dimensional dynamic array of the double type.
 * @param index  [in] Number of the indicator buffer. The numbering starts with 0. The number must be less than the value declared in #property indicator_buffers.
 * @param buffer  [in]  An array declared in the custom indicator program.
 * @param data_type  [in] Type of data stored in the indicator array. By default it is INDICATOR_DATA (values of the calculated indicator). It may also take the value of INDICATOR_COLOR_INDEX; in this case this buffer is used for storing color indexes for the previous indicator buffer. You can specify up to 64 colors in the #property indicator_colorN line. The INDICATOR_CALCULATIONS value means that the buffer is used in intermediate calculations of the indicator and is not intended for drawing.
 * @return ( bool )
 */
bool SetIndexBuffer(int index, double buffer[], ENUM_INDEXBUFFER_TYPE data_type = INDICATOR_DATA);

/** Sets the predefined variable _LastError into the value equal to ERR_USER_ERROR_FIRST + user_error
 * @param user_error  [in]  Error number set by a user.
 */
void SetUserError(ushort user_error);

/** It copies part of array into a returned string.
 * @param array  [in]  Array of ushort type (analog of wchar_t type).
 * @param start  [in] Position, from which copying starts, Default - 0.
 * @param count  [in]  Number of array elements to copy. Defines the length of a resulting string. Default value is -1, which means copying up to the array end, or till terminal 0.
 * @return ( string )
 */
string ShortArrayToString(ushort array[], int start = 0, int count = -1);

/** It converts the symbol code (unicode) into one-symbol string and returns resulting string.
 * @param symbol_code  [in]  Symbol code. Instead of a symbol code you can use literal string containing a symbol or a literal string with 2-byte hexadecimal code corresponding to the symbol from the Unicode table.
 * @return ( string )
 */
string ShortToString(ushort symbol_code);

/** Returns the value of double type property for selected signal.
 * @param property_id  [in]  Signal property identifier. The value can be one of the values of the ENUM_SIGNAL_BASE_DOUBLE enumeration.
 * @return ( double )
 */
double SignalBaseGetDouble(ENUM_SIGNAL_BASE_DOUBLE property_id);

/** Returns the value of integer type property for selected signal.
 * @param property_id  [in]  Signal property identifier. The value can be one of the values of the ENUM_SIGNAL_BASE_INTEGER enumeration.
 * @return ( long )
 */
long SignalBaseGetInteger(ENUM_SIGNAL_BASE_INTEGER property_id);

/** Returns the value of string type property for selected signal.
 * @param property_id  [in]  Signal property identifier. The value can be one of the values of the ENUM_SIGNAL_BASE_STRING enumeration.
 * @return ( string )
 */
string SignalBaseGetString(ENUM_SIGNAL_BASE_STRING property_id);

/** Selects a signal from signals, available in terminal for further working with it.
 * @param index  [in]  Signal index in base of trading signals.
 * @return ( bool )
 */
bool SignalBaseSelect(int index);

/** Returns the total amount of signals, available in terminal.
 * @return ( int )
 */
int SignalBaseTotal();

/** Returns the value of double type property of signal copy settings.
 * @param property_id  [in]  Signal copy settings property identifier. The value can be one of the values of the ENUM_SIGNAL_INFO_DOUBLE enumeration.
 * @return ( double )
 */
double SignalInfoGetDouble(ENUM_SIGNAL_INFO_DOUBLE property_id);

/** Returns the value of integer type property of signal copy settings.
 * @param property_id  [in]  Signal copy settings property identifier. The value can be one of the values of the ENUM_SIGNAL_INFO_INTEGER enumeration.
 * @return ( long )
 */
long SignalInfoGetInteger(ENUM_SIGNAL_INFO_INTEGER property_id);

/** Returns the value of string type property of signal copy settings.
 * @param property_id  [in]  Signal copy settings property identifier. The value can be one of the values of the ENUM_SIGNAL_INFO_STRING enumeration.
 * @return ( string )
 */
string SignalInfoGetString(ENUM_SIGNAL_INFO_STRING property_id);

/** Sets the value of double type property of signal copy settings.
 * @param property_id  [in]  Signal copy settings property identifier. The value can be one of the values of the ENUM_SIGNAL_INFO_DOUBLE enumeration.
 * @param value  [in]  The value of signal copy settings property.
 * @return ( bool )
 */
bool SignalInfoSetDouble(ENUM_SIGNAL_INFO_DOUBLE property_id, double value);

/** Sets the value of integer type property of signal copy settings.
 * @param property_id  [in]  Signal copy settings property identifier. The value can be one of the values of the ENUM_SIGNAL_INFO_INTEGER enumeration.
 * @param value  [in]  The value of signal copy settings property.
 * @return ( bool )
 */
bool SignalInfoSetInteger(ENUM_SIGNAL_INFO_INTEGER property_id, long value);

/** Subscribes to the trading signal.
 * @param signal_id  [in]  Signal identifier.
 * @return ( bool )
 */
bool SignalSubscribe(long signal_id);

/** Cancels subscription.
 * @return ( bool )
 */
bool SignalUnsubscribe();

/** Returns the sine of a specified angle.
 * @param value  [in]  Angle in radians.
 * @return ( double )
 */
double sin(double value);

/** The function suspends execution of the current Expert Advisor or script within a specified interval.
 * @param milliseconds  [in]  Delay interval in milliseconds.
 */
void Sleep(int milliseconds);

/** Create a socket with specified flags and return its handle.
 * @param flags  [in]  Combination of flags defining the mode of working with a socket. Currently, only one flag is supported — SOCKET_DEFAULT.
 * @return ( int )
 */
int SocketCreate(uint flags);

/** Close a socket.
 * @param socket  [in]  Handle of a socket to be closed. The handle is returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @return ( bool )
 */
bool SocketClose(const int socket);

/** Connect to the server with timeout control.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @param server  [in]  Domain name of the server you want to connect to or its IP address.
 * @param port  [in]  Connection port number.
 * @param timeout_receive_ms  [in]  Connection timeout in milliseconds. If connection is not established within that time interval, attempts are stopped.
 * @return ( bool )
 */
bool SocketConnect(int socket, const string server, uint port, uint timeout_receive_ms);

/** Checks if the socket is currently connected.
 * @param socket  [in]  Socket handle returned by the SocketCreate() function. When an incorrect handle is passed to _LastError, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @return ( bool )
 */
bool SocketIsConnected(const int socket);

/** Get a number of bytes that can be read from a socket.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed to _LastError, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @return ( uint )
 */
uint SocketIsReadable(const int socket);

/** Check whether data can be written to a socket at the current time.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @return ( bool )
 */
bool SocketIsWritable(const int socket);

/** Set timeouts for receiving and sending data for a socket system object.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @param timeout_send_ms  [in]  Data sending timeout in milliseconds.
 * @param timeout_receive_ms  [in]  Data obtaining timeout in milliseconds.
 * @return ( bool )
 */
bool SocketTimeouts(int socket, uint timeout_send_ms, uint timeout_receive_ms);

/** Read data from a socket.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed to _LastError, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @param buffer  [out]  Reference to the uchar type array the data is read in. Dynamic array size is increased by the number of read bytes. The array size cannot exceed INT_MAX (2147483647).
 * @param buffer_maxlen  [in]  Number of bytes to read to the buffer[] array. Data not fitting into the array remain in the socket. They can be received by the next SocketRead call. buffer_maxlen cannot exceed INT_MAX (2147483647).
 * @param timeout_ms  [in]  Data reading timeout in milliseconds. If data is not obtained within this time, attempts are stopped and the function returns -1.
 * @return ( int )
 */
int SocketRead(int socket, uchar (&buffer)[], uint buffer_maxlen, uint timeout_ms);

/** Write data to a socket.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @param buffer  [in]  Reference to the uchar type array with the data to be sent to the socket.
 * @param buffer_len  [in]  'buffer' array size.
 * @return ( int )
 */
int SocketSend(int socket, const uchar (&buffer)[], uint buffer_len);

/** Initiate secure TLS (SSL) connection to a specified host via TLS Handshake protocol. During Handshake, a client and a server agree on connection parameters: applied protocol version and data encryption method.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @param host  [in]  Address of a host a secure connection is established with.
 * @return ( bool )
 */
bool SocketTlsHandshake(int socket, const string host);

/** Get data on the certificate used to secure network connection.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @param subject  [in]  Certificate owner name. Corresponds to the Subject field.
 * @param issuer  [in]  Certificate issuer name. Corresponds to the Issuer field.
 * @param serial  [in]  Certificate serial number. Corresponds to the SerialNumber field.
 * @param thumbprint  [in]  Certificate print. Corresponds to the SHA-1 hash from the entire certificate file (all fields including the issuer signature).
 * @param expiration  [in]  Certificate expiration date in the datetime format.
 * @return ( int )
 */
int SocketTlsCertificate(int socket, string &subject, string &issuer, string &serial, string &thumbprint, datetime &expiration);

/** Read data from secure TLS connection.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed to _LastError, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @param buffer  [out]  Reference to the uchar type array the data is read in. Dynamic array size is increased by the number of read bytes. The array size cannot exceed INT_MAX (2147483647).
 * @param buffer_maxlen  [in]  Number of bytes to read to the buffer[] array. Data not fitting into the array remain in the socket. They can be received by the next SocketTLSRead call. buffer_maxlen cannot exceed INT_MAX (2147483647).
 * @return ( int )
 */
int SocketTlsRead(int socket, uchar (&buffer)[], uint buffer_maxlen);

/** Read all available data from secure TLS connection.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed to _LastError, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @param buffer  [out]  Reference to the uchar type array the data is read in. Dynamic array size is increased by the number of read bytes. The array size cannot exceed INT_MAX (2147483647).
 * @param buffer_maxlen  [in]  Number of bytes to read to the buffer[] array. Data not fitting into the array remain in the socket. They can be received by the next SocketTlsReadAvailable or  SocketTlsRead call. buffer_maxlen cannot exceed INT_MAX (2147483647).
 * @return ( int )
 */
int SocketTlsReadAvailable(int socket, uchar (&buffer)[], const uint buffer_maxlen);

/** Send data via secure TLS connection.
 * @param socket  [in]  Socket handle returned by the SocketCreate function. When an incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @param buffer  [in]  Reference to the uchar type array with the data to be sent.
 * @param buffer_len  [in]  'buffer' array size.
 * @return ( int )
 */
int SocketTlsSend(int socket, const uchar (&buffer)[], uint buffer_len);

/** Returns the square root of a number.
 * @param value  [in]  Positive numeric value.
 * @return ( double )
 */
double sqrt(double value);

/** Sets the starting point for generating a series of pseudorandom integers.
 * @param seed  [in]  Starting number for the sequence of random numbers.
 */
void srand(int seed);

/** The function adds a substring to the end of a string.
 * @param string_var  [in][out]  String, to which another one is added.
 * @param add_substring  [in]  String that is added to the end of a  source string.
 * @return ( bool )
 */
bool StringAdd(string &string_var, string add_substring);

/** The function returns the size of buffer allocated for the string.
 * @param string_var  [in]  String.
 * @return ( int )
 */
int StringBufferLen(string string_var);

/** The function compares two strings and returns the comparison result in form of an integer.
 * @param string1  [in]  The first string.
 * @param string2  [in]  The second string.
 * @param case_sensitive  [in]  Case sensitivity mode selection. If it is true, then "A">"a". If it is false, then "A"="a". By default the value is equal to true.
 * @return ( int )
 */
int StringCompare(const string &string1, const string &string2, bool case_sensitive = true);

/** The function forms a string of passed parameters and returns the size of the formed string. Parameters can be of any type. Number of parameters can't be less than 2 or more than 64.
 * @param string_var  [out]  String that will be formed as a result of concatenation.
 * @param ...  [in]  Any comma separated values. From 2 to 63 parameters of any simple type.
 * @return ( int )
 */
int StringConcatenate(string &string_var, ...);

/** It fills out a selected string by specified symbols.
 * @param string_var  [in][out]  String, that will be filled out by the selected symbol.
 * @param character  [in]  Symbol, by which the string will be filled out.
 * @return ( bool )
 */
bool StringFill(string &string_var, ushort character);

/** Search for a substring in a string.
 * @param string_value  [in]  String, in which search is made.
 * @param match_substring  [in]  Searched substring.
 * @param start_pos  [in]  Position in the string from which search is started.
 * @return ( int )
 */
int StringFind(string string_value, string match_substring, int start_pos = 0);

/** The function formats obtained parameters and returns a string.
 * @param format  [in]  String containing method of formatting. Formatting rules are the same as for the PrintFormat function.
 * @param ...  [in]  Parameters, separated by a comma.
 * @return ( string )
 */
string StringFormat(string format, ...);

/** Returns value of a symbol, located in the specified position of a string.
 * @param string_value  [in]  String.
 * @param pos  [in]  Position of a symbol in the string. Can be from 0 to StringLen(text) -1.
 * @return ( ushort )
 */
ushort StringGetCharacter(string string_value, int pos);

/** Initializes a string by specified symbols and provides the specified string size.
 * @param string_var  [in][out]  String that should be initialized and deinitialized.
 * @param new_len  [in]  String length after initialization. If length=0, it deinitializes the string, i.e. the string buffer is cleared and the buffer address is zeroed.
 * @param character  [in]  Symbol to fill the string.
 * @return ( bool )
 */
bool StringInit(string &string_var, int new_len = 0, ushort character = 0);

/** Returns the number of symbols in a string.
 * @param string_value  [in]  String to calculate length.
 * @return ( int )
 */
int StringLen(string string_value);

/** It replaces all the found substrings of a string by a set sequence of symbols.
 * @param str  [in][out]  The string in which you are going to replace substrings.
 * @param find  [in]  The desired substring to replace.
 * @param replacement  [in]  The string that will be inserted instead of the found one.
 * @return ( int )
 */
int StringReplace(string &str, const string find, const string replacement);

/** Returns copy of a string with a changed character in a specified position.
 * @param string_var  [in][out]  String.
 * @param pos  [in]  Position of a character in a string. Can be from 0 to StringLen(text).
 * @param character  [in]  Symbol code Unicode.
 * @return ( bool )
 */
bool StringSetCharacter(string &string_var, int pos, ushort character);

/** Gets substrings by a specified separator from the specified string, returns the number of substrings obtained.
 * @param string_value  [in]  The string from which you need to get substrings. The string will not change.
 * @param separator  [in]  The code of the separator character. To get the code, you can use the StringGetCharacter() function.
 * @param result  [out]  An array of strings where the obtained substrings are located.
 * @return ( int )
 */
int StringSplit(const string string_value, const ushort separator, string result[]);

/** Extracts a substring from a text string starting from the specified position.
 * @param string_value  [in]  String to extract a substring from.
 * @param start_pos  [in]  Initial position of a substring. Can be from 0 to StringLen(text) -1.
 * @param length  [in] Length of an extracted substring. If the parameter value is equal to -1 or parameter isn't set, the substring will be extracted from the indicated position till the string end.
 * @return ( string )
 */
string StringSubstr(string string_value, int start_pos, int length = -1);

/** Symbol-wise copies a string converted from Unicode to ANSI, to a selected place of array of uchar type. It returns the number of copied elements.
 * @param text_string  [in]  String to copy.
 * @param array  [out]  Array of uchar type.
 * @param start  [in]  Position from which copying starts. Default - 0.
 * @param count  [in]  Number of array elements to copy. Defines length of a resulting string. Default value is -1, which means copying up to the array end, or till terminal 0. Terminal 0 will also be copied to the recipient array, in this case the size of a dynamic array can be increased if necessary to the size of the string. If the size of the dynamic array exceeds the length of the string, the size of the array will not be reduced.
 * @param codepage  [in]  The value of the code page. For the most-used code pages provide appropriate constants.
 * @return ( int )
 */
int StringToCharArray(string text_string, uchar (&array)[], int start = 0, int count = -1, uint codepage = CP_ACP);

/** Converting "R,G,B" string or string with color name into color type value.
 * @param color_string  [in]  String representation of a color of "R,G,B" type or name of one of predefined Web-colors.
 * @return ( color )
 */
color StringToColor(string color_string);

/** The function converts string containing a symbol representation of number into number of double type.
 * @param value  [in]  String containing a symbol representation of a number.
 * @return ( double )
 */
double StringToDouble(string value);

/** The function converts string containing a symbol representation of number into number of long (integer) type.
 * @param value  [in]  String containing a number.
 * @return ( long )
 */
long StringToInteger(string value);

/** Transforms all symbols of a selected string into lowercase.
 * @param string_var  [in][out]  String.
 * @return ( bool )
 */
bool StringToLower(string &string_var);

/** The function symbol-wise copies a string into a specified place of an array of ushort type. It returns the number of copied elements.
 * @param text_string  [in]  String to copy
 * @param array  [out]  Array of ushort type (analog of wchar_t type).
 * @param start  [in]  Position, from which copying starts. Default - 0.
 * @param count  [in]  Number of array elements to copy. Defines length of a resulting string. Default value is -1, which means copying up to the array end, or till terminal 0.Terminal 0 will also be copied to the recipient array, in this case the size of a dynamic array can be increased if necessary to the size of the string. If the size of the dynamic array exceeds the length of the string, the size of the array will not be reduced.
 * @return ( int )
 */
int StringToShortArray(string text_string, ushort (&array)[], int start = 0, int count = -1);

/** Transforms the string containing time and/or date in the "yyyy.mm.dd [hh:mi]" format into the datetime type number.
 * @param time_string  [in]  String in one of the specified formats:
 * @return ( datetime )
 */
datetime StringToTime(const string time_string);

/** Transforms all symbols of a selected string into capitals.
 * @param string_var  [in][out]  String.
 * @return ( bool )
 */
bool StringToUpper(string &string_var);

/** The function cuts line feed characters, spaces and tabs in the left part of the string till the first meaningful symbol. The string is modified at place.
 * @param string_var  [in][out]  String that will be cut from the left.
 * @return ( int )
 */
int StringTrimLeft(string &string_var);

/** The function cuts line feed characters, spaces and tabs in the right part of the string after the last meaningful symbol. The string is modified at place.
 * @param string_var  [in][out]  String that will be cut from the right.
 * @return ( int )
 */
int StringTrimRight(string &string_var);

/** Converts a structure variable MqlDateTime into a value of datetime type and returns the resulting value.
 * @param dt_struct  [in] Variable of structure type MqlDateTime.
 * @return ( datetime )
 */
datetime StructToTime(MqlDateTime &dt_struct);

/** Returns the name of a symbol of the current chart.
 * @return ( string )
 */
string Symbol();

/**
 * The _Symbol variable contains the symbol name of the current chart.
 */
string _Symbol;

/** Returns the corresponding property of a specified symbol. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param name  [in] Symbol name.
 * @param prop_id  [in] Identifier of a symbol property. The value can be one of the values of the ENUM_SYMBOL_INFO_DOUBLE enumeration.
 * @return ( bool )
 */
bool SymbolInfoDouble(string name, ENUM_SYMBOL_INFO_DOUBLE prop_id);

/** Returns the corresponding property of a specified symbol. There are 2 variants of the function.
 * 2. Returns true or false depending on whether a function is successfully performed. In case of success, the value of the property is placed into a recipient variable, passed by reference by the last parameter.
 * @param name  [in] Symbol name.
 * @param prop_id  [in] Identifier of a symbol property. The value can be one of the values of the ENUM_SYMBOL_INFO_DOUBLE enumeration.
 * @param double_var  [out] Variable of double type receiving the value of the requested property.
 * @return ( bool )
 */
bool SymbolInfoDouble(string name, ENUM_SYMBOL_INFO_DOUBLE prop_id, double &double_var);

/** Returns the corresponding property of a specified symbol. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param name  [in] Symbol name.
 * @param prop_id  [in] Identifier of a symbol property. The value can be one of the values of the ENUM_SYMBOL_INFO_INTEGER enumeration.
 * @return ( bool )
 */
bool SymbolInfoInteger(string name, ENUM_SYMBOL_INFO_INTEGER prop_id);

/** Returns the corresponding property of a specified symbol. There are 2 variants of the function.
 * 2. Returns true or false depending on whether a function is successfully performed. In case of success, the value of the property is placed into a recipient variable, passed by reference by the last parameter.
 * @param name  [in] Symbol name.
 * @param prop_id  [in] Identifier of a symbol property. The value can be one of the values of the ENUM_SYMBOL_INFO_INTEGER enumeration.
 * @param long_var  [out] Variable of the long type receiving the value of the requested property.
 * @return ( bool )
 */
bool SymbolInfoInteger(string name, ENUM_SYMBOL_INFO_INTEGER prop_id, long &long_var);

/** Returns the margin rates depending on the order type and direction.
 * @param name  [in] Symbol name.
 * @param order_type  [in] Order type.
 * @param initial_margin_rate  [in] A double type variable for receiving an initial margin rate. Initial margin is a security deposit for 1 lot deal in the appropriate direction. Multiplying the rate by the initial margin, we receive the amount of funds to be reserved on the account when placing an order of the specified type.
 * @param maintenance_margin_rate  [out] A double type variable for receiving a maintenance margin rate. Maintenance margin is a minimum amount for maintaining an open position of 1 lot in the appropriate direction. Multiplying the rate by the maintenance margin, we receive the amount of funds to be reserved on the account after an order of the specified type is activated.
 * @return ( bool )
 */
bool SymbolInfoMarginRate(string name, ENUM_ORDER_TYPE order_type, double &initial_margin_rate, double &maintenance_margin_rate);

/** Allows receiving time of beginning and end of the specified quoting sessions for a specified symbol and day of week.
 * @param name  [in]  Symbol name.
 * @param day_of_week  [in]  Day of the week, value of enumeration ENUM_DAY_OF_WEEK.
 * @param session_index  [in]  Ordinal number of a session, whose beginning and end time we want to receive. Indexing of sessions starts with 0.
 * @param from  [out]  Session beginning time in seconds from 00 hours 00 minutes, in the returned value date should be ignored.
 * @param to  [out]  Session end time in seconds from 00 hours 00 minutes, in the returned value date should be ignored.
 * @return ( bool )
 */
bool SymbolInfoSessionQuote(string name, ENUM_DAY_OF_WEEK day_of_week, uint session_index, datetime &from, datetime &to);

/** Allows receiving time of beginning and end of the specified trading sessions for a specified symbol and day of week.
 * @param name  [in]  Symbol name.
 * @param day_of_week  [in]  Day of the week, value of enumeration ENUM_DAY_OF_WEEK.
 * @param session_index  [in]  Ordinal number of a session, whose beginning and end time we want to receive. Indexing of sessions starts with 0.
 * @param from  [out]  Session beginning time in seconds from 00 hours 00 minutes, in the returned value date should be ignored.
 * @param to  [out]  Session end time in seconds from 00 hours 00 minutes, in the returned value date should be ignored.
 * @return ( bool )
 */
bool SymbolInfoSessionTrade(string name, ENUM_DAY_OF_WEEK day_of_week, uint session_index, datetime &from, datetime &to);

/** Returns the corresponding property of a specified symbol. There are 2 variants of the function.
 * 1. Immediately returns the property value.
 * @param name  [in] Symbol name.
 * @param prop_id  [in] Identifier of a symbol property. The value can be one of the values of the ENUM_SYMBOL_INFO_STRING enumeration.
 * @return ( bool )
 */
bool SymbolInfoString(string name, ENUM_SYMBOL_INFO_STRING prop_id);

/** Returns the corresponding property of a specified symbol. There are 2 variants of the function.
 * 2. Returns true or false, depending on the success of a function. If successful, the value of the property is placed in a placeholder variable passed by reference in the last parameter.
 * @param name  [in] Symbol name.
 * @param prop_id  [in] Identifier of a symbol property. The value can be one of the values of the ENUM_SYMBOL_INFO_STRING enumeration.
 * @param string_var  [out] Variable of the string type receiving the value of the requested property.
 * @return ( bool )
 */
bool SymbolInfoString(string name, ENUM_SYMBOL_INFO_STRING prop_id, string &string_var);

/** The function returns current prices of a specified symbol in a variable of the MqlTick type.
 * @param symbol  [in]  Symbol name.
 * @param tick  [out]  Link to the structure of the MqlTick type, to which the current prices and time of the last price update will be placed.
 * @return ( bool )
 */
bool SymbolInfoTick(string symbol, MqlTick &tick);

/** The function checks whether data of a selected symbol in the terminal are synchronized with data on the trade server.
 * @param name  [in]  Symbol name.
 * @return ( bool )
 */
bool SymbolIsSynchronized(string name);

/** Returns the name of a symbol.
 * @param pos  [in] Order number of a symbol.
 * @param selected  [in] Request mode. If the value is true, the symbol is taken from the list of symbols selected in MarketWatch. If the value is false, the symbol is taken from the general list.
 * @return ( string )
 */
string SymbolName(int pos, bool selected);

/** Selects a symbol in the Market Watch window or removes a symbol from the window.
 * @param name  [in] Symbol name.
 * @param select  [in] Switch. If the value is false, a symbol should be removed from MarketWatch, otherwise a symbol should be selected in this window. A symbol can't be removed if the symbol chart is open, or there are open positions for this symbol.
 * @return ( bool )
 */
bool SymbolSelect(string name, bool select);

/** Returns the number of available (selected in Market Watch or all) symbols.
 * @param selected  [in] Request mode. Can be true or false.
 * @return ( int )
 */
int SymbolsTotal(bool selected);

/** The function returns a tangent of a number.
 * @param rad  [in]  Angle in radians.
 * @return ( double )
 */
double tan(double rad);

/** The function commands the terminal to complete operation.
 * @param ret_code  [in]  Return code, returned by the process of the client terminal at the operation completion.
 * @return ( bool )
 */
bool TerminalClose(int ret_code);

/** Returns the value of a corresponding property of the mql5 program environment.
 * @param property_id  [in] Identifier of a property. Can be one of the values of the ENUM_TERMINAL_INFO_DOUBLE enumeration.
 * @return ( double )
 */
double TerminalInfoDouble(int property_id);

/** Returns the value of a corresponding property of the mql5 program environment.
 * @param property_id  [in] Identifier of a property. Can be one of the values of the ENUM_TERMINAL_INFO_INTEGER enumeration.
 * @return ( int )
 */
int TerminalInfoInteger(int property_id);

/** Returns the value of a corresponding property of the mql5 program environment. The property must be of string type.
 * @param property_id  [in] Identifier of a property. Can be one of the values of the ENUM_TERMINAL_INFO_STRING enumeration.
 * @return ( string )
 */
string TerminalInfoString(int property_id);

/** The function returns the value of the specified statistical parameter calculated based on testing results.
 * @param statistic_id  [in]   The ID of the statistical parameter from the ENUM_STATISTICS enumeration.
 * @return ( double )
 */
double TesterStatistics(ENUM_STATISTICS statistic_id);

/** The function returns the line width and height at the current font settings.
 * @param text  [in]  String, for which length and width should be obtained.
 * @param width  [out]  Input parameter for receiving width.
 * @param height  [out]  Input parameter for receiving height.
 * @return ( bool )
 */
bool TextGetSize(const string text, uint &width, uint &height);

/** The function displays a text in a custom array (buffer) and returns the result of that operation. The array is designed to create the graphical resource.
 * @param text  [in]  Displayed text that will be written to the buffer. Only one-lined text is displayed.
 * @param x  [in]  X coordinate of the anchor point of the displayed text.
 * @param y  [in]  Y coordinate of the anchor point of the displayed text.
 * @param anchor  [in]  The value out of the 9 pre-defined methods of the displayed text's anchor point location. The value is set by a combination of two flags – flags of horizontal and vertical text align. Flag names are listed in the Note below.
 * @param data  [in]  Buffer, in which text is displayed. The buffer is used to create the graphical resource.
 * @param width  [in]  Buffer width in pixels.
 * @param height  [in]  Buffer height in pixels.
 * @param color  [in]  Text color.
 * @param color_format  [in]  Color format is set by ENUM_COLOR_FORMAT enumeration value.
 * @return ( bool )
 */
bool TextOut(const string text, int x, int y, uint anchor, uint (&data)[], uint width, uint height, uint color, ENUM_COLOR_FORMAT color_format);

/** The function sets the font for displaying the text using drawing methods and returns the result of that operation. Arial font with the size -120 (12 pt) is used by default.
 * @param name  [in]  Font name in the system or the name of the resource containing the font or the path to font file on the disk.
 * @param size  [in]  The font size that can be set using positive and negative values. In case of positive values, the size of a displayed text does not depend on the operating system's font size settings. In case of negative values, the value is set in tenths of a point and the text size depends on the operating system settings ("standard scale" or "large scale"). See the Note below for more information about the differences between the modes.
 * @param flags  [in]  Combination of flags describing font style.
 * @param orientation  [in]  Text's horizontal inclination to X axis, the unit of measurement is 0.1 degrees. It means that orientation=450 stands for inclination equal to 45 degrees.
 * @return ( bool )
 */
bool TextSetFont(const string name, int size, uint flags, int orientation = 0);

/** Returns the last known server time, time of the last quote receipt for one of the symbols selected in the "Market Watch" window. In the OnTick() handler, this function returns the time of the received handled tick. In other cases (for example, call in handlers OnInit(), OnDeinit(), OnTimer() and so on) this is the time of the last quote receipt for any symbol available in the "Market Watch" window, the time shown in the title of this window. The time value is formed on a trade server and does not depend on the time settings on your computer. There are 2 variants of the function.
 * Call without parameters
 * @return ( datetime )
 */
datetime TimeCurrent();

/** Returns the last known server time, time of the last quote receipt for one of the symbols selected in the "Market Watch" window. In the OnTick() handler, this function returns the time of the received handled tick. In other cases (for example, call in handlers OnInit(), OnDeinit(), OnTimer() and so on) this is the time of the last quote receipt for any symbol available in the "Market Watch" window, the time shown in the title of this window. The time value is formed on a trade server and does not depend on the time settings on your computer. There are 2 variants of the function.
 * Call with MqlDateTime type parameter
 * @param dt_struct  [out]  MqlDateTime structure type variable.
 * @return ( datetime )
 */
datetime TimeCurrent(MqlDateTime &dt_struct);

/** Returns correction for daylight saving time in seconds, if the switch to summer time has been made. It depends on the time settings of your computer.
 * @return ( int )
 */
int TimeDaylightSavings();

/** Returns the GMT, which is calculated taking into account the DST switch by the local time on the computer where the client terminal is running. There are 2 variants of the function.
 * Call without parameters
 * @return ( datetime )
 */
datetime TimeGMT();

/** Returns the GMT, which is calculated taking into account the DST switch by the local time on the computer where the client terminal is running. There are 2 variants of the function.
 * Call with MqlDateTime type parameter
 * @param dt_struct  [out]  Variable of structure type MqlDateTime.
 * @return ( datetime )
 */
datetime TimeGMT(MqlDateTime &dt_struct);

/** Returns the current difference between GMT time and the local computer time in seconds, taking into account switch to winter or summer time. Depends on the time settings of your computer.
 * @return ( int )
 */
int TimeGMTOffset();

/** Returns the local time of a computer, where the client terminal is running. There are 2 variants of the function.
 * Call without parameters
 * @return ( datetime )
 */
datetime TimeLocal();

/** Returns the local time of a computer, where the client terminal is running. There are 2 variants of the function.
 * Call with MqlDateTime type parameter
 * @param dt_struct  [out]  Variable of structure type MqlDateTime.
 * @return ( datetime )
 */
datetime TimeLocal(MqlDateTime &dt_struct);

/** Converting a value containing time in seconds elapsed since 01.01.1970 into a string of "yyyy.mm.dd hh:mi" format.
 * @param value  [in]  Time in seconds from 00:00 1970/01/01.
 * @param mode  [in] Additional data input mode. Can be one or combined flag:  TIME_DATE gets result as "yyyy.mm.dd",  TIME_MINUTES gets result as "hh:mi",  TIME_SECONDS gets results as "hh:mi:ss".
 * @return ( string )
 */
string TimeToString(datetime value, int mode = TIME_DATE | TIME_MINUTES);

/** Converts a value of datetime type (number of seconds since 01.01.1970) into a structure variable MqlDateTime.
 * @param dt  [in]  Date value to convert.
 * @param dt_struct  [out]  Variable of structure type MqlDateTime.
 * @return ( bool )
 */
bool TimeToStruct(datetime dt, MqlDateTime &dt_struct);

/** Returns the calculated current time of the trade server. Unlike TimeCurrent(), the calculation of the time value is performed in the client terminal and depends on the time settings on your computer. There are 2 variants of the function.
 * Call without parameters
 * @return ( datetime )
 */
datetime TimeTradeServer();

/** Returns the calculated current time of the trade server. Unlike TimeCurrent(), the calculation of the time value is performed in the client terminal and depends on the time settings on your computer. There are 2 variants of the function.
 * Call with MqlDateTime type parameter
 * @param dt_struct  [out]  Variable of structure type MqlDateTime.
 * @return ( datetime )
 */
datetime TimeTradeServer(MqlDateTime &dt_struct);

/** Returns the code of a reason for deinitialization.
 * @return ( int )
 */
int UninitializeReason();

/** The function sends an HTTP request to a specified server. The function has two versions:
 * 1.Sending simple requestsof type "key=value" using the header Content-Type: application/x-www-form-urlencoded.
 * @param method  [in]  HTTP method.
 * @param url  [in]  URL.
 * @param cookie  [in]  Cookie value.
 * @param referer  [in]  Value of the Referer header of the HTTP request.
 * @param timeout  [in]  Timeout in milliseconds.
 * @param data  [in]  Data array of the HTTP message body.
 * @param data_size  [in]  Size of the data[] array.
 * @param result  [out]  An array containing server response data.
 * @param result_headers  [out] Server response headers.
 * @return ( int )
 */
int WebRequest(const string method, const string url, const string cookie, const string referer, int timeout, const char (&data)[], int data_size, char (&result)[], string &result_headers);

/** The function sends an HTTP request to a specified server. The function has two versions:
 * 2.Sending a request of any typespecifying the customset of headers for a more flexible interaction with various Web services.
 * @param method  [in]  HTTP method.
 * @param url  [in]  URL.
 * @param headers  [in]  Request headers of type "key: value", separated by a line break "\r\n".
 * @param timeout  [in]  Timeout in milliseconds.
 * @param data  [in]  Data array of the HTTP message body.
 * @param result  [out]  An array containing server response data.
 * @param result_headers  [out] Server response headers.
 * @return ( int )
 */
int WebRequest(const string method, const string url, const string headers, int timeout, const char (&data)[], char (&result)[], string &result_headers);

template <typename VOID>
/** The function resets a variable passed to it by reference.
 * @param variable  [in] [out]  Variable passed by reference, you want to reset (initialize by zero values).
 */
void ZeroMemory(VOID &variable);

class vector
{
public:
    /**
     * Compute activation function values and write them to the passed vector/matrix.
     * @param vect_out [in] Vector to get the computed values of the activation function.
     * @param activation [in] Activation function from the ENUM_ACTIVATION_FUNCTION enumeration.
     * @param any [in] Additional parameters required for some activation functions. If no parameters are specified, default values are used.
     * @return (bool)
     */
    template <typename... x>
    bool Activation(vector &vect_out, ENUM_ACTIVATION_FUNCTION activation, x... any);

    /**
     * Returns the index of the maximum value.
     */
    ulong ArgMax();

    /**
     * Returns the index of the minimum value.
     */
    ulong ArgMin();

    /**
     * Indirect sorting of a vector.
     * @param compare_func [in] Comparator. You can specify one of the values from the ENUM_SORT_MODE enumeration or your own comparison function. If no function is specified, ascending sorting is used.
     * @param context [in] Additional optional parameter that can be passed to a custom sort function.
     * @return (vector)
     */
    template <typename func_name, typename T>
    vector Sort(func_name compare_func = NULL, T context);

    /**
     * Copies a vector with automatic cast.
     * @param vec [in] The vector from which the values are copied.
     * @return (bool)
     */
    bool Assign(const vector &vec);

    /**
     * Copies an array with automatic cast.
     * @param array [in] The array from which the values are copied.
     * @return (bool)
     */
    template <typename VOID>
    bool Assign(const VOID (&array)[]);

    /**
     * Compute the weighted mean of vector values.
     * @param weigts [in] The weight vector.
     * @return (double)
     */
    double Average(const vector &weigts);

    /**
     * Limits the elements of the vector to the specified range of valid values.
     * @param min_value [in] The minimum value.
     * @param max_value [in] The maximum value.
     * @return (bool)
     */
    bool Clip(const double min_value, const double max_value);

    /**
     * Compares the elements of two vectors with the specified precision.
     * @param vec [in] The vector to compare.
     * @param epsilon [in] The comparison precision.
     * @return (ulong)
     */
    ulong Compare(const vector &vec, const double epsilon);

    /**
     * Compare the elements of two vectors with the significant digits precision.
     * @param vec [in] The vector to compare.
     * @param digits [in] The number of significant digits for comparison.
     * @return (ulong)
     */
    ulong CompareByDigits(const vector &vec, const int digits);

    /**
     * Returns the discrete linear convolution of two vectors.
     * @param v [in]  Second vector.
     * @param mode [in] The 'mode' parameter determines the linear convolution calculation mode ENUM_VECTOR_CONVOLVE.
     * @return (vector)
     */
    vector Convolve(const vector &v, ENUM_VECTOR_CONVOLVE mode);

    /**
     * Creates a copy of the given vector.
     * @param v [in] The vector to copy.
     * @return (bool)
     */
    bool Copy(const vector &v);

    /**
     * Get the data of the specified indicator buffer in the specified quantity to a vector. There are 3 variations of the function:
     * 1. Access by the initial position and the number of required elements.
     * @param indicator_handle [in] The indicator handle obtained by the relevant indicator function.
     * @param buffer_index [in] The index of the indicator buffer.
     * @param start_pos [in] The number of the first copied element.
     * @param count [in] The number of copied elements.
     * @return (bool)
     */
    bool CopyIndicatorBuffer(long indicator_handle, ulong buffer_index, ulong start_pos, ulong count);

    /**
     * Get the data of the specified indicator buffer in the specified quantity to a vector. There are 3 variations of the function:
     * 2. Access by the start date and the number of required elements.
     * @param indicator_handle [in] The indicator handle obtained by the relevant indicator function.
     * @param buffer_index [in] The index of the indicator buffer.
     * @param start_time [in] Bar time corresponding to the first element.
     * @param count [in] The number of copied elements.
     * @return (bool)
     */
    bool CopyIndicatorBuffer(long indicator_handle, ulong buffer_index, datetime start_time, ulong count);

    /**
     * Get the data of the specified indicator buffer in the specified quantity to a vector. There are 3 variations of the function:
     * 3. Access by the initial and final dates of the required time interval.
     * @param indicator_handle [in] The indicator handle obtained by the relevant indicator function.
     * @param buffer_index [in] The index of the indicator buffer.
     * @param start_time [in] Bar time corresponding to the first element.
     * @param stop_time [in] The bar time corresponding to the last element.
     * @return (bool)
     */
    bool CopyIndicatorBuffer(long indicator_handle, ulong buffer_index, datetime start_time, datetime stop_time);

    /**
     * Gets the historical series of the MqlRates structure of the specified symbol-period in the specified amount into a matrix or vector. There are 3 variations of the method:
     * 1. Access by the initial position and the number of required elements.
     * @param symbol [in] The symbol.
     * @param period [in] The period.
     * @param rates_mask [in] The ENUM_COPY_RATES enumeration combination of flags specifying the type of requested series.  When copying to a vector, only one value from the ENUM_COPY_RATES enumeration can be specified, otherwise an error occurs.
     * @param start [in] First copied element index.
     * @param count [in] Number of copied elements.
     * @return (bool)
     */
    bool CopyRates(string symbol, ENUM_TIMEFRAMES period, ulong rates_mask, ulong start, ulong count);

    /**
     * Gets the historical series of the MqlRates structure of the specified symbol-period in the specified amount into a matrix or vector. There are 3 variations of the method:
     * 2. Access by the initial date and the number of required elements.
     * @param symbol [in] The symbol.
     * @param period [in] The period.
     * @param rates_mask [in] The ENUM_COPY_RATES enumeration combination of flags specifying the type of requested series.  When copying to a vector, only one value from the ENUM_COPY_RATES enumeration can be specified, otherwise an error occurs.
     * @param from [in] Bar time corresponding to the first element.
     * @param count [in] Number of copied elements.
     * @return (bool)
     */
    bool CopyRates(string symbol, ENUM_TIMEFRAMES period, ulong rates_mask, datetime from, ulong count);

    /**
     * Gets the historical series of the MqlRates structure of the specified symbol-period in the specified amount into a matrix or vector. There are 3 options for the method:
     * 3. Access by the initial and final dates of the required time interval.
     * @param symbol [in] Symbol.
     * @param period [in] Period.
     * @param rates_mask [in] The ENUM_COPY_RATES enumeration combination of flags specifying the type of requested series.  When copying to a vector, only one value from the ENUM_COPY_RATES enumeration can be specified, otherwise an error occurs.
     * @param from [in] Bar time corresponding to the first element.
     * @param to [in] Bar time corresponding to the last element.
     * @return (bool)
     */
    bool CopyRates(string symbol, ENUM_TIMEFRAMES period, ulong rates_mask, datetime from, datetime to);

    /**
     * Get ticks from an MqlTick structure into a matrix or a vector.
     * @param symbol [in] Symbol.
     * @param ticks_mask [in] A combination of flags from the ENUM_COPY_TICKS enumeration indicating the contents of the requested data. When copying to a vector, you can specify only one value from the ENUM_COPY_TICKS enumeration, otherwise an error will occur.
     * @param flags [in]  A flag defining the type of the requested ticks.
     * @param from_msc [in] Time starting from which ticks are requested.
     * @param count [in] Number of requested ticks.
     * @return (bool)
     */
    bool CopyTicks(string symbol, ulong ticks_mask, uint flags = COPY_TICKS_ALL, ulong from_msc = 0, ulong count = 0);

    /**
     * Get ticks from an MqlTick structure into a matrix or a vector within the specified date range.
     * @param symbol [in] Symbol.
     * @param ticks_mask [in]  A combination of flags from the ENUM_COPY_TICKS enumeration indicating the contents of the requested data. When copying to a vector, you can specify only one value from the ENUM_COPY_TICKS enumeration, otherwise an error will occur.
     * @param flags [in] A flag defining the type of the requested ticks.
     * @param from_msc [in] Time starting from which ticks are requested.
     * @param to_msc [in]  Time up to which ticks are requested.
     * @return (bool)
     */
    bool CopyTicksRange(string symbol, ulong ticks_mask, uint flags = COPY_TICKS_ALL, ulong from_msc = 0, ulong to_msc = 0);

    /**
     * Compute the Pearson correlation coefficient (linear correlation coefficient).
     * @param b [in] Second vector.
     * @return (scalar)
     */
    scalar CorrCoef(const vector &b);

    /**
     * Compute the cross-correlation of two vectors.
     * @param v [in] Second vector.
     * @param mode [in] The 'mode' parameter determines the linear convolution calculation mode. Value from the ENUM_VECTOR_CONVOLVE enumeration.
     * @return (vector)
     */
    vector Correlate(const vector &v, ENUM_VECTOR_CONVOLVE mode);

    /**
     * Compute the covariance matrix.
     * @param b [in] Second vector.
     * @return (matrix)
     */
    matrix Cov(const vector &b);

    /**
     * Return the cumulative product of matrix/vector elements, including those along the given axis.
     * @return (vector)
     */
    vector CumProd();

    /**
     * Return the cumulative sum of matrix/vector elements, including those along the given axis.
     * @return (vector)
     */
    vector CumSum();

    /**
     * Compute activation function derivative values and write them to the passed vector/matrix
     * @param vect_out [out] Vector or matrix to get the computed values of the derivative of the activation function.
     * @param activation [in] Activation function from the ENUM_ACTIVATION_FUNCTION enumeration.
     * @param any [in]  Additional parameters are the same as that of the activation functions.
     * @return (bool)
     */
    template <typename... x>
    bool Derivative(vector &vect_out, ENUM_ACTIVATION_FUNCTION activation, x... any);

    /**
     * Dot product of two vectors.
     * @param b [in] Second vector.
     * @return (double)
     */
    double Dot(const vector &b);

    /**
     * Fill an existing matrix or vector with the specified value.
     * @param value [in] Value to fill all the matrix elements.
     */
    void Fill(const double value);

    /**
     * The static function creates and returns a new matrix filled with given value.
     * @param size [in] Vector size.
     * @param value [in] Value to fill all the matrix elements.
     * @return ( matrix )
     */
    static vector Full(const ulong size, const double value);

    /**
     * The GeMM (General Matrix Multiply) method implements the general multiplication of two matrices.
     * Multiplying a vector by a matrix.
     * @param A [in] Horizontal vector.
     * @param B [in] Matrix.
     * @param alpha [in]  Alpha multiplier for product AB.
     * @param beta [in]  Beta multiplier for vector C.
     * @param flags [in]  ENUM_GEMM enumeration value that determines whether matrix A is transposed.
     * @return ( bool )
     */
    bool GeMM(const vector &A, const matrix &B, double alpha, double beta, uint flags);

    /**
     * The GeMM (General Matrix Multiply) method implements the general multiplication of two matrices.
     * Multiplying a matrix by a vector.
     * @param A [in] Matrix.
     * @param B [in] Vertical vector.
     * @param alpha [in]  Alpha multiplier for product AB.
     * @param beta [in]  Beta multiplier for vector C.
     * @param flags [in]  ENUM_GEMM enumeration value that determines whether matrix B is transposed.
     * @return
     */
    bool GeMM(const matrix &A, const vector &B, double alpha, double beta, uint flags);

    /**
     * Return the number of NaN values in a vector.
     * @return ( ulong )
     */
    ulong HasNan();

    /**
     * Initialize a matrix.
     * @param size [in] Vector size.
     * @param init_func [in]  Init function placed in some scope or static method of class
     * @param any [in]  Parameters of the initializing function.
     */
    template <typename func_name, typename... x>
    void Init(const ulong size, func_name init_func = NULL, x... any);

    /**
     * Return Kronecker product of vector and matrix.
     * @param b [in] Matrix.
     * @return ( matrix )
     */
    matrix Kron(const matrix &b);

    /**
     * Return Kronecker product of two vectors.
     * @param b [in] Second vector.
     * @return ( matrix )
     */
    matrix Kron(const vector &b);

    /**
     * Calculate a vector/matrix with calculated linear regression values.
     * @return ( vector )
     */
    vector LinearRegression();

    /**
     * Compute the value of the loss function.
     * @param vect_true [in] Vector of true values.
     * @param loss [in] Loss function from the ENUM_LOSS_FUNCTION enumeration.
     * @param  any [in]  Additional parameter 'delta' can only be used by the Hubert loss function (LOSS_HUBER)
     * @return ( double )
     */
    template <typename... x>
    double Loss(const vector &vect_true, ENUM_LOSS_FUNCTION loss, x... any);

    /**
     * The MatMul method, which enables the multiplication of matrices and vectors, has several overloads.
     * Multiplying a vector by a matrix.
     * @param b [in] Matrix.
     * @return (vector)
     */
    vector MatMul(const matrix &b);

    /**
     * The MatMul method, which enables the multiplication of matrices and vectors, has several overloads.
     * Scalar vector multiplication.
     * @param b [in] Second vector.
     * @return (vector)
     */
    scalar MatMul(const vector &b);

    /**
     * Returns the maximum value in the vector.
     * @return (double)
     */
    double Max();

    /**
     * Compute the arithmetic mean of element values.
     * @return (double)
     */
    double Mean();

    /**
     * Compute the median of the vector elements.
     * @return (double)
     */
    double Median();

    /**
     * Returns the minimum value in the vector.
     * @return (double)
     */
    double Min();

    /**
     * Return matrix or vector norm.
     * @param norm [in] Vector norm.
     * @param norm_p [in] number of p-norm in case of VECTOR_NORM_P.
     * @return (double)
     */
    double Norm(const ENUM_VECTOR_NORM norm, const int norm_p = 2);

    /**
     * This is a static function that creates and returns a new matrix filled with ones.
     * @param size [in] Vector size.
     * @return (matrix)
     */
    static vector Ones(const ulong size);

    /**
     * Compute the outer product of two matrices or two vectors.
     * @param b [in] Second vector.
     * @return (matrix)
     */
    matrix Outer(const vector &b);

    /**
     * Return the specified percentile of values of matrix/vector elements or elements along the specified axis.
     * @param percent [in] Percentiles to compute, which must be between 0 and 100 inclusive.
     * @return (double)
     */
    double Percentile(const int percent);

    /**
     * Return the product of the matrix/vector elements which can also be performed for the given axis.
     * @param initial [in] Initial multiplier.
     * @return (double)
     */
    double Prod(const double initial = 1);

    /**
     * Return the range of values of a matrix/vector or of the given matrix axis, equivalent to Max() - Min(). Ptp - Peak to peak.
     * @return (double)
     */
    double Ptp();

    /**
     * Return the specified quantile of values of matrix/vector elements or elements along the specified axis.
     * @param quantile [in] Quantile to compute, which must be between 0 and 1 inclusive.
     * @return (double)
     */
    double Quantile(const double quantile);

    /**
     * Compute the regression metric to evaluate the quality of the predicted data compared to the true data
     * @param vector_true [in] Vector of true values.
     * @param metric [in]  Metric type from the ENUM_REGRESSION_METRIC enumeration.
     * @return (double)
     */
    double RegressionMetric(const vector &vector_true, ENUM_REGRESSION_METRIC metric);

    /**
     * Return a new matrix with a changed shape and size.
     * @param size [in] New size.
     * @param reserve [in] Reserve amount in items.
     * @return (matrix)
     */
    bool Resize(const ulong size, const ulong reserve = 0);

    /**
     * Sets the value for a vector element by the specified index.
     * @param index [in]  Index of the element the value needs to be set for.
     * @param value [in]  Value.
     * @return (bool)
     */
    bool Set(ulong index, double value);

    /**
     * Return the size of vector.
     * @return (ulong)
     */
    ulong Size();

    /**
     * Sort a matrix or vector in place.
     * @param compare_func [in] Comparator. You can specify one of the values of the ENUM_SORT_MODE enumeration or your own comparison function. If no function is specified, ascending sort is used.
     * @param context [in] Parameter for the custom sort function.
     */
    template <typename func_name, typename T>
    void Sort(func_name compare_func = NULL, T context);

    /**
     * Return the standard deviation of values of matrix/vector elements or of elements along the given axis.
     * @return (double)
     */
    double Std();

    /**
     * Return the sum of the matrix/vector elements which can also be performed for the given axis (axes).
     * @return (double)
     */
    double Sum();

    /**
     * Compute the variance of values of matrix/vector elements.
     * @return (double)
     */
    double Var();

    /**
     * This is a static function that creates and returns a new matrix filled with zeros.
     * @param size [in] Vector size.
     * @return (vector)
     */
    static vector Zeros(const ulong size);
};

class matrix
{
public:
    /**
     * Compute activation function values and write them to the passed vector/matrix.
     * @param matrix_out [in] Matrix to get the computed values of the activation function.
     * @param activation [in] Activation function from the ENUM_ACTIVATION_FUNCTION enumeration.
     * @return (bool)
     */
    bool Activation(matrix &matrix_out, ENUM_ACTIVATION_FUNCTION activation);

    /**
     * Compute activation function values and write them to the passed vector/matrix.
     * @param matrix_out [in] Matrix to get the computed values of the activation function.
     * @param activation [in] Activation function from the ENUM_ACTIVATION_FUNCTION enumeration.
     * @param axis [in] ENUM_MATRIX_AXIS enumeration value (AXIS_HORZ — horizontal axis, AXIS_VERT — vertical axis).
     * @param any [in] Additional parameters required for some activation functions. If no parameters are specified, default values are used.
     * @return (bool)
     */
    template <typename... x>
    bool Activation(matrix &matrix_out, ENUM_ACTIVATION_FUNCTION activation, ENUM_MATRIX_AXIS axis, x... any);

    /**
     * Return the index of the maximum value.
     * @return (ulong)
     */
    ulong ArgMax();

    /**
     * Return the index of the maximum value.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (ulong)
     */
    ulong ArgMax(const int axis);

    /**
     * Return the index of the minimum value.
     * @return (ulong)
     */
    ulong ArgMin();

    /**
     * Return the index of the minimum value.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (ulong)
     */
    ulong ArgMin(const int axis);

    /**
     * Indirect sort of a matrix.
     * @param compare_func [in] Comparator. You can specify one of the values of the ENUM_SORT_MODE enumeration or your own comparison function. If no function is specified, ascending sort is used.
     * @param context [in] Additional optional parameter that can be passed to a custom sort function.
     * @return (matrix)
     */
    template <typename func_name, typename T>
    matrix Sort(func_name compare_func = NULL, T context);

    /**
     * Indirect sort of a matrix.
     * @param axis [in] The axing along which to sort: 0 is horizontal, 1 is vertical.
     * @param compare_func [in] Comparator. You can specify one of the values of the ENUM_SORT_MODE enumeration or your own comparison function. If no function is specified, ascending sort is used.
     * @param context [in] Additional optional parameter that can be passed to a custom sort function.
     * @return (matrix)
     */
    template <typename func_name, typename T>
    matrix Sort(const int axis, func_name compare_func = NULL, T context);

    /**
     * Copies a matrix, vector or array with auto cast.
     * @param mat [in] The matrix, vector or array the values are copied from.
     * @return (bool)
     */
    bool Assign(const matrix &mat);

    /**
     * Copies a matrix, vector or array with auto cast.
     * @param array [in] The matrix, vector or array the values are copied from.
     * @return
     */
    template <typename VOID>
    bool Assign(const VOID (&array)[]);

    /**
     * Compute the weighted mean of matrix/vector values.
     * @param weights [in] Weight matrix.
     * @return (double)
     */
    double Average(const matrix &weights);

    /**
     * Compute the weighted mean of matrix/vector values.
     * @param weights [in] Weight matrix.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Average(const matrix &weights, const int axis);

    /**
     * Compute the Cholesky decomposition.
     * @param L [out] Lower triangular matrix.
     * @return (bool)
     */
    bool Cholesky(matrix &L);

    /**
     * Limit the elements of a matrix/vector to a specified range of valid values.
     * @param min_value [in] Minimum value.
     * @param max_value [in] Maximum value.
     * @return (bool)
     */
    bool Clip(const double min_value, const double max_value);

    /**
     * Return a column vector. Write a vector to the specified column.
     * @param ncol [in] Column number.
     * @return (vector)
     */
    vector Col(const ulong ncol);

    /**
     * Return a column vector. Write a vector to the specified column.
     * @param v [in] Column vector.
     * @param ncol [in] Column number.
     */
    void Col(const vector v, const ulong ncol);

    /**
     * Return the number of columns in a matrix.
     * @return (int)
     */
    ulong Cols();

    /**
     * Compare the elements of two matrices/vectors with the specified precision.
     * @param mat [in] Vector to compare.
     * @param epsilon [in] Comparison precision.
     * @return (ulong)
     */
    ulong Compare(const matrix &mat, const double epsilon);

    /**
     * Compare the elements of two matrices/vectors with the significant digits precision.
     * @param mat [in] Matrix to compare.
     * @param digits [in] Number of significant digits to compare.
     * @return (ulong)
     */
    ulong CompareByDigits(const matrix &mat, const int digits);

    /**
     * Compute the condition number of a matrix.
     * @param norm [in] Order of the norm from ENUM_MATRIX_NORM
     * @return (double)
     */
    double Cond(const ENUM_MATRIX_NORM norm);

    /**
     * Create a copy of the given matrix/vector.
     * @param m [in] Matrix to copied.
     * @return (bool)
     */
    bool Copy(const matrix &m);

    /**
     * Gets the historical series of the MqlRates structure of the specified symbol-period in the specified amount into a matrix or vector. There are 3 variations of the method:
     * 1. Access by the initial position and the number of required elements.
     * @param symbol [in] The symbol.
     * @param period [in] The period.
     * @param rates_mask [in] The ENUM_COPY_RATES enumeration combination of flags specifying the type of requested series.  When copying to a vector, only one value from the ENUM_COPY_RATES enumeration can be specified, otherwise an error occurs.
     * @param start [in] First copied element index.
     * @param count [in] Number of copied elements.
     * @return (bool)
     */
    bool CopyRates(string symbol, ENUM_TIMEFRAMES period, ulong rates_mask, ulong start, ulong count);

    /**
     * Gets the historical series of the MqlRates structure of the specified symbol-period in the specified amount into a matrix or vector. There are 3 variations of the method:
     * 2. Access by the initial date and the number of required elements.
     * @param symbol [in] The symbol.
     * @param period [in] The period.
     * @param rates_mask [in] The ENUM_COPY_RATES enumeration combination of flags specifying the type of requested series.  When copying to a vector, only one value from the ENUM_COPY_RATES enumeration can be specified, otherwise an error occurs.
     * @param from [in] Bar time corresponding to the first element.
     * @param count [in] Number of copied elements.
     * @return (bool)
     */
    bool CopyRates(string symbol, ENUM_TIMEFRAMES period, ulong rates_mask, datetime from, ulong count);

    /**
     * Gets the historical series of the MqlRates structure of the specified symbol-period in the specified amount into a matrix or vector. There are 3 options for the method:
     * 3. Access by the initial and final dates of the required time interval.
     * @param symbol [in] Symbol.
     * @param period [in] Period.
     * @param rates_mask [in] The ENUM_COPY_RATES enumeration combination of flags specifying the type of requested series.  When copying to a vector, only one value from the ENUM_COPY_RATES enumeration can be specified, otherwise an error occurs.
     * @param from [in] Bar time corresponding to the first element.
     * @param to [in] Bar time corresponding to the last element.
     * @return (bool)
     */
    bool CopyRates(string symbol, ENUM_TIMEFRAMES period, ulong rates_mask, datetime from, datetime to);

    /**
     * Get ticks from an MqlTick structure into a matrix or a vector.
     * @param symbol [in] Symbol.
     * @param ticks_mask [in] A combination of flags from the ENUM_COPY_TICKS enumeration indicating the contents of the requested data. When copying to a vector, you can specify only one value from the ENUM_COPY_TICKS enumeration, otherwise an error will occur.
     * @param flags [in] A flag defining the type of the requested ticks.
     * @param from_msc [in] Time starting from which ticks are requested.
     * @param count [in] The number of requested ticks.
     * @return (bool)
     */
    bool CopyTicks(string symbol, ulong ticks_mask, uint flags = COPY_TICKS_ALL, ulong from_msc = 0, ulong count = 0);

    /**
     * Get ticks from an MqlTick structure into a matrix or a vector within the specified date range.
     * @param symbol [in] Symbol.
     * @param ticks_mask [in] A combination of flags from the ENUM_COPY_TICKS enumeration indicating the contents of the requested data. When copying to a vector, you can specify only one value from the ENUM_COPY_TICKS enumeration, otherwise an error will occur.
     * @param flags [in] A flag defining the type of the requested ticks.
     * @param from_msc [in] Time starting from which ticks are requested.
     * @param to_msc [in] Time up to which ticks are requested.
     * @return (bool)
     */
    bool CopyTicksRange(string symbol, ulong ticks_mask, uint flags = COPY_TICKS_ALL, ulong from_msc = 0, ulong to_msc = 0);

    /**
     * Compute the Pearson correlation coefficient (linear correlation coefficient).
     * @param rowvar [in]  rows or cols vectors of observations.
     * @return ( matrix )
     */
    matrix CorrCoef(const bool rowvar = true);

    /**
     * Compute the covariance matrix.
     * @param rowvar [in]  rows or cols vectors of observations.
     * @return ( matrix )
     */
    matrix Cov(const bool rowvar = true);

    /**
     * Return the cumulative product of matrix/vector elements, including those along the given axis.
     * @return ( vector )
     */
    vector CumProd();

    /**
     * Return the cumulative product of matrix/vector elements, including those along the given axis.
     * @param axis [in]  Axis. 0 — horizontal axis for each column (i.e., over the rows), 1 — vertical axis for each row (i.e. over the columns)
     * @return ( matrix )
     */
    matrix CumProd(const int axis);

    /**
     * Return the cumulative sum of matrix/vector elements, including those along the given axis.
     * @return ( vector )
     */
    vector CumSum();

    /**
     * Return the cumulative sum of matrix/vector elements, including those along the given axis.
     * @param axis [in]  Axis. 0 — horizontal axis, 1 — vertical axis.
     * @return ( matrix )
     */
    matrix CumSum(const int axis);

    /**
     * Compute activation function derivative values and write them to the passed vector/matrix
     * @param matrix_out  [out]  Matrix to get the computed values of the derivative of the activation function.
     * @param activation  [in]  Activation function from the ENUM_ACTIVATION_FUNCTION enumeration.
     * @return ( bool )
     */
    bool Derivative(matrix &matrix_out, ENUM_ACTIVATION_FUNCTION activation);

    /**
     * Compute activation function derivative values and write them to the passed vector/matrix
     * @param matrix_out [out]  Matrix to get the computed values of the derivative of the activation function.
     * @param activation [in]  Activation function from the ENUM_ACTIVATION_FUNCTION enumeration.
     * @param axis [in]  ENUM_MATRIX_AXIS enumeration value (AXIS_HORZ — horizontal axis, AXIS_VERT — vertical axis).
     * @param any  [in]  Additional parameters are the same as that of the activation functions.
     * @return ( bool )
     */
    template <typename... x>
    bool Derivative(matrix &matrix_out, ENUM_ACTIVATION_FUNCTION activation, ENUM_MATRIX_AXIS axis, x... any);

    /**
     * Compute the determinant of a square invertible matrix.
     * @return ( double )
     */
    double Det();

    /**
     * Extract a diagonal or construct a diagonal matrix.
     * @param ndiag [in]  Diagonal in question. The default is 0. Use ndiag>0 for diagonals above the main diagonal, and ndiag<0 for diagonals below the main diagonal.
     * @return ( vector )
     */
    vector Diag(const int ndiag = 0);

    /**
     * Extract a diagonal or construct a diagonal matrix.
     * @param v [in]  A vector whose elements will be contained in the corresponding diagonal (ndiag=0 is the main diagonal).
     * @param ndiag [in]  Diagonal in question. The default is 0. Use ndiag>0 for diagonals above the main diagonal, and ndiag<0 for diagonals below the main diagonal.
     */
    void Diag(const vector v, const int ndiag = 0);

    /**
     * Compute the eigenvalues and right eigenvectors of a square matrix.
     * @param eigen_vectors [out]  Matrix of vertical eigenvectors.
     * @param eigen_values [out]   Vector of eigenvalues.
     * @return ( bool )
     */
    bool Eig(matrix &eigen_vectors, vector &eigen_values);

    /**
     * Compute the eigenvalues of a general matrix.
     * @param [out]  Vector of right eigenvalues.
     * @return ( bool )
     */
    bool EigVals(vector &eigen_values);

    /**
     * A static function. Constructs a matrix having a specified size with ones on the main diagonal and zeros elsewhere. Returns a matrix with ones on the diagonal and zeros elsewhere.
     * @param rows [in]  Number of rows in the output.
     * @param cols [in]  Number of columns in the output.
     * @param ndiag [in]  Index of the diagonal: 0 (the default) refers to the main diagonal, a positive value refers to an upper diagonal, and a negative value to a lower diagonal.
     * @return ( matrix )
     */
    static matrix Eye(const ulong rows, const ulong cols, const int ndiag = 0);

    /**
     * Fill an existing matrix or vector with the specified value.
     * @param value [in]  Value to fill all the matrix elements.
     */
    void Fill(const double value);

    /**
     * Allows addressing a matrix element through one index instead of two.
     * @param index [in]  Flat index
     * @param value [in]  Value to set by given index.
     * @return ( bool )
     */
    bool Flat(const ulong index, const double value);

    /**
     * Allows addressing a matrix element through one index instead of two.
     * @param index [in]  Flat index
     * @return ( double )
     */
    double Flat(const ulong index);

    /**
     * The static function creates and returns a new matrix filled with given value.
     * @param rows [in]  Number of rows.
     * @param cols [in]  Number of columns.
     * @param value [in]  Value to fill all the matrix elements.
     * @return ( matrix )
     */
    static matrix Full(const ulong rows, const ulong cols, const double value);

    /**
     * The GeMM (General Matrix Multiply) method implements the general multiplication of two matrices.
     * Multiplying a matrix by a matrix.
     * @param A [in]  First matrix.
     * @param B [in]  Second matrix.
     * @param alpha [in]  Alpha multiplier for the AB product..
     * @param beta [in]  Beta multiplier for the resulting C matrix.
     * @param flags [in]  The ENUM_GEMM enumeration value that determines whether matrices A, B and C are transposed.
     * @return ( bool )
     */
    bool GeMM(const matrix &A, const matrix &B, double alpha, double beta, uint flags);

    /**
     * The GeMM (General Matrix Multiply) method implements the general multiplication of two matrices.
     * Multiplying a vector by a vector.
     * @param A [in]  First vector.
     * @param B [in]  Second vector.
     * @param alpha [in]  Alpha multiplier for the AB product..
     * @param beta [in]  Beta multiplier for the resulting C matrix.
     * @param flags [in]  The ENUM_GEMM enumeration value that determines whether matrices A, B and C are transposed.
     * @return ( bool )
     */
    bool GeMM(const vector &A, const vector &B, double alpha, double beta, uint flags);

    /**
     * Return the number of NaN values in a matrix/vector.
     * @return ( ulong )
     */
    ulong HasNan();

    /**
     * Split a matrix horizontally into multiple submatrices. Same as Split with axis=0
     * @param parts [in]  The number of submatrices to divide the matrix into
     * @param splitted [out]  Array of resulting submatrices.
     * @return ( bool )
     */
    bool Hsplit(const ulong parts, matrix (&splitted)[]);

    /**
     * Split a matrix horizontally into multiple submatrices. Same as Split with axis=0
     * @param parts [in]  Sizes of submatrices
     * @param splitted [out]  Array of resulting submatrices.
     */
    void Hsplit(const ulong (&parts)[], matrix (&splitted)[]);

    /**
     * It is a static function which creates an identity matrix of the specified size (not necessarily square).
     * @param rows [in]  Number of rows
     * @param cols [in]  Number of columns
     * @return ( matrix )
     */
    static matrix Identity(const ulong rows, const ulong cols);

    /**
     * It is a static function which creates an identity matrix of the specified size (not necessarily square).
     * The static function converts an existing matrix into a unit matrix.
     */
    void Identity();

    /**
     * Initialize a matrix.
     * @param rows [in]  Number of rows.
     * @param cols [in]   Number of columns.
     * @param init_func [in]  Initializing function.
     * @param any [in]  Parameters of the initializing function.
     */
    template <typename func_name, typename... x>
    void Init(const ulong rows, const ulong cols, func_name init_func = NULL, x... any);

    /**
     * Inner product of two matrices.
     * @param b [in]  Matrix.
     * @return ( matrix )
     */
    matrix Inner(const matrix &b);

    /**
     * Compute the multiplicative inverse of a square invertible matrix by the Jordan-Gauss method.
     * @return ( matrix )
     */
    matrix Inv();

    /**
     * Return Kronecker product of two matrices, matrix and vector, vector and matrix or two vectors.
     * @param b [in]  Second matrix.
     * @return ( matrix )
     */
    matrix Kron(const matrix &b);

    /**
     * Return Kronecker product of two matrices, matrix and vector, vector and matrix or two vectors.
     * @param b [in]  Vector.
     */
    matrix Kron(const vector &b);

    /**
     * Calculate a vector/matrix with calculated linear regression values.
     * @param axis [in]  Specifying the axis along which the regression is calculated. ENUM_MATRIX_AXIS enumeration value (AXIS_HORZ — horizontal axis, AXIS_VERT — vertical axis).
     * @return
     */
    matrix LinearRegression(ENUM_MATRIX_AXIS axis = AXIS_NONE);

    /**
     * Compute the value of the loss function.
     * @param matrix_true [in]  Matrix of true values
     * @param loss [in]  Loss function from the ENUM_LOSS_FUNCTION enumeration.
     * @return ( double )
     */
    double Loss(const matrix &matrix_true, ENUM_LOSS_FUNCTION loss);

    /**
     * Compute the value of the loss function.
     * @param matrix_true [in]  Matrix of true values
     * @param loss [in]  Loss function from the ENUM_LOSS_FUNCTION enumeration.
     * @param axis [in]  ENUM_MATRIX_AXIS enumeration value (AXIS_HORZ — horizontal axis, AXIS_VERT — vertical axis).
     * @param any [in]   Additional parameter 'delta' can only be used by the Hubert loss function (LOSS_HUBER)
     * @return ( double )
     */
    template <typename... x>
    double Loss(const matrix &matrix_true, ENUM_LOSS_FUNCTION loss, ENUM_MATRIX_AXIS axis, x... any);

    /**
     * Return the least-squares solution of linear algebraic equations (for non-square or degenerate matrices).
     * @param b [in]   Ordinate or 'dependent variable' values. (Vector of free terms)
     * @return ( vector )
     */
    vector LstSq(const vector b);

    /**
     * LU factorization of a matrix as the product of a lower triangular matrix and an upper triangular matrix.
     * @param L [out]  Lower triangular matrix.
     * @param U [out]  Upper triangular matrix.
     * @return ( bool )
     */
    bool LU(matrix &L, matrix &U);

    /**
     * LUP factorization with partial pivoting, which refers to LU decomposition with row permutations only: PA=LU.
     * @param L [out]  Lower triangular matrix.
     * @param U [out]  Upper triangular matrix.
     * @param P [out]  Permutations matrix.
     * @return ( bool )
     */
    bool LUP(matrix &L, matrix &U, matrix &P);

    /**
     * The MatMul method, which enables the multiplication of matrices and vectors, has several overloads.
     * Multiplying a matrix by a matrix.
     * @param b [in] Second matrix.
     * @return (matrix)
     */
    matrix MatMul(const matrix &b);

    /**
     * The MatMul method, which enables the multiplication of matrices and vectors, has several overloads.
     * Multiplying a matrix by a vector.
     * @param b [in] Vector.
     * @return (vector)
     */
    vector MatMul(const vector &b);

    /**
     * Return the maximum value in a matrix.
     * @return (double)
     */
    double Max();

    /**
     * Return the maximum value in a matrix.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Max(const int axis);

    /**
     * Compute the arithmetic mean of element values.
     * @return (double)
     */
    double Mean();

    /**
     * Compute the arithmetic mean of element values.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Mean(const int axis);

    /**
     * Compute the median of the matrix/vector elements.
     * @return (double)
     */
    double Median();

    /**
     * Compute the median of the matrix/vector elements.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Median(const int axis);

    /**
     * Return the minimum value in a matrix/vector.
     * @return (double)
     */
    double Min();

    /**
     * Return the minimum value in a matrix/vector.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Min(const int axis);

    /**
     * Return matrix or vector norm.
     * @param norm [in] Matrix norm.
     * @return (double)
     */
    double Norm(const ENUM_MATRIX_NORM norm);

    /**
     * This is a static function that creates and returns a new matrix filled with ones.
     * @param rows [in] Number of rows.
     * @param cols [in] Number of columns.
     * @return (matrix)
     */
    static matrix Ones(const ulong rows, const ulong cols);

    /**
     * Compute the outer product of two matrices or two vectors.
     * @param b [in] Second matrix.
     * @return (matrix)
     */
    matrix Outer(const matrix &b);

    /**
     * Return the specified percentile of values of matrix/vector elements or elements along the specified axis.
     * @param percent [in]  Percentiles to compute, which must be between 0 and 100 inclusive.
     * @return (double)
     */
    double Percentile(const int percent);

    /**
     * Return the specified percentile of values of matrix/vector elements or elements along the specified axis.
     * @param percent [in]  Percentiles to compute, which must be between 0 and 100 inclusive.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Percentile(const int percent, const int axis);

    /**
     * Compute the pseudo-inverse of a matrix by the Moore-Penrose method.
     * @return (matrix)
     */
    matrix PInv();

    /**
     * Raise a square matrix to the integer power.
     * @param power [in] The exponent can be any integer, positive, negative, or zero.
     * @return (matrix)
     */
    matrix Power(const int power);

    /**
     * Return the product of the matrix/vector elements which can also be performed for the given axis.
     * @param initial [in] Initial multiplier.
     * @return (double)
     */
    double Prod(const double initial = 1);

    /**
     * Return the product of the matrix/vector elements which can also be performed for the given axis.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @param initial [in] Initial multiplier.
     * @return (vector)
     */
    vector Prod(const int axis, const double initial = 1);

    /**
     * Return the range of values of a matrix/vector or of the given matrix axis, equivalent to Max() - Min(). Ptp - Peak to peak.
     * @return (double)
     */
    double Ptp();

    /**
     * Return the range of values of a matrix/vector or of the given matrix axis, equivalent to Max() - Min(). Ptp - Peak to peak.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Ptp(const int axis);

    /**
     * Compute the qr factorization of a matrix.
     * @param Q [out] Matrix with orthonormal columns.
     * @param R [out] Upper triangular matrix.
     * @return (bool)
     */
    bool QR(matrix &Q, matrix &R);

    /**
     * Return the specified quantile of values of matrix/vector elements or elements along the specified axis.
     * @param quantile [in] Quantile to compute, which must be between 0 and 1 inclusive.
     * @return (double)
     */
    double Quantile(const double quantile);

    /**
     * Return the specified quantile of values of matrix/vector elements or elements along the specified axis.
     * @param quantile [in] Quantile to compute, which must be between 0 and 1 inclusive.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Quantile(const double quantile, const int axis);

    /**
     * Return matrix rank using the Gaussian method.
     * @return (int)
     */
    int Rank();

    /**
     * Compute the regression metric to evaluate the quality of the predicted data compared to the true data
     * @param matrix_true [in] Matrix of true values.
     * @param metric [in] Metric type from the ENUM_REGRESSION_METRIC enumeration.
     * @return (double)
     */
    double RegressionMetric(const matrix &matrix_true, ENUM_REGRESSION_METRIC metric);

    /**
     * Compute the regression metric to evaluate the quality of the predicted data compared to the true data
     * @param matrix_true [in] Matrix of true values.
     * @param metric [in] Metric type from the ENUM_REGRESSION_METRIC enumeration.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector RegressionMetric(const matrix &matrix_true, ENUM_REGRESSION_METRIC metric, int axis);

    /**
     * Change the shape of a matrix without changing its data.
     * @param rows [in] New number of rows.
     * @param cols [in] New number of columns.
     */
    void Reshape(const ulong rows, const ulong cols);

    /**
     * Return a new matrix with a changed shape and size.
     * @param rows [in] New number of rows.
     * @param cols [in] New number of columns.
     * @param reserve [in] Reserve amount in items.
     * @return (bool)
     */
    bool Resize(const ulong rows, const ulong cols, const ulong reserve = 0);

    /**
     * Return a row vector. Write a vector to the specified row
     * @param nrow [in] Row number.
     * @return (vector)
     */
    vector Row(const ulong nrow);

    /**
     * Return a row vector. Write a vector to the specified row
     * @param v [in] Row vector.
     * @param nrow [in] Row number.
     */
    void Row(const vector v, const ulong nrow);

    /**
     * Return the number of rows in a matrix.
     * @return (int)
     */
    ulong Rows();

    /**
     * Compute the sign and logarithm of a matrix determinant.
     * @param sign [out] The sign of the determinant. If the sign is even, the determinant is positive.
     * @return (double)
     */
    double SLogDet(int &sign);

    /**
     * Solve a linear matrix equation, or system of linear algebraic equations.
     * @param b [in] Ordinate or 'dependent variable' values. (Vector of free terms).
     * @return (vector)
     */
    vector Solve(const vector b);

    /**
     * Sort a matrix or vector in place.
     * @param compare_func [in] Comparator. You can specify one of the values of the ENUM_SORT_MODE enumeration or your own comparison function. If no function is specified, ascending sort is used.
     * @param context [in] Additional optional parameter that can be passed to a custom sort function.
     */
    template <typename func_name, typename T>
    void Sort(func_name compare_func = NULL, T context);

    /**
     * Sort a matrix or vector in place.
     * @param axis [in] Axis along which the sorting is performed: 0 - horizontal, 1 - vertical.
     * @param compare_func [in] Comparator. You can specify one of the values of the ENUM_SORT_MODE enumeration or your own comparison function. If no function is specified, ascending sort is used.
     * @param context [in] Additional optional parameter that can be passed to a custom sort function.
     */
    template <typename func_name, typename T>
    void Sort(const int axis, func_name compare_func = NULL, T context);

    /**
     * Compute spectrum of a matrix as the set of its eigenvalues from the product AT*A.
     * @return (vector)
     */
    vector Spectrum();

    /**
     * Split a matrix into multiple submatrices.
     * @param parts [in] Number of submatrices to split the matrix into.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @param splitted [out] Array of resulting submatrices.
     * @return (bool)
     */
    bool Split(const ulong parts, const int axis, matrix (&splitted)[]);

    /**
     * Split a matrix into multiple submatrices.
     * @param parts [in] Sizes of submatrices to split the matrix into.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @param splitted [out] Array of resulting submatrices.
     */
    void Split(const ulong (&parts)[], const int axis, matrix (&splitted)[]);

    /**
     * Return the standard deviation of values of matrix/vector elements or of elements along the given axis.
     * @return (double)
     */
    double Std();

    /**
     * Return the standard deviation of values of matrix/vector elements or of elements along the given axis.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Std(const int axis);

    /**
     * Return the sum of the matrix/vector elements which can also be performed for the given axis (axes).
     * @return (double)
     */
    double Sum();

    /**
     * Return the sum of the matrix/vector elements which can also be performed for the given axis (axes).
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Sum(const int axis);

    /**
     * Singular Value Decomposition.
     * @param U [out] Unitary matrix of order m, consisting of left singular vectors.
     * @param V [out] Unitary matrix of order n, consisting of right singular vectors.
     * @param singular_values [out] Singular values.
     * @return (bool)
     */
    bool SVD(matrix &U, matrix &V, vector &singular_values);

    /**
     * Swap columns in a matrix.
     * @param col1 [in] Index of the first column.
     * @param col2 [in] Index of the second column.
     * @return (bool)
     */
    bool SwapCols(const ulong col1, const ulong col2);

    /**
     * Swap rows in a matrix.
     * @param row1 [in] Index of the first row.
     * @param row2 [in] Index of the second row.
     * @return (bool)
     */
    bool SwapRows(const ulong row1, const ulong row2);

    /**
     * Return the sum along diagonals of the matrix.
     * @return (double)
     */
    double Trace();

    /**
     * Matrix transposition. Reverse or permute the axes of a matrix; returns the modified matrix.
     * @return (matrix)
     */
    matrix Transpose();

    /**
     * This is a static function Construct a matrix with ones at and below the given diagonal and zeros elsewhere.
     * @param rows [in] Number of rows in the array.
     * @param cols [in] Number of columns in the array.
     * @param ndiag [in] The sub-diagonal at and below which the array is filled. k = 0 is the main diagonal, while k < 0 is below it, and k > 0 is above. The default is 0.
     * @return (matrix)
     */
    static matrix Tri(const ulong rows, const ulong cols, const int ndiag = 0);

    /**
     * Return a copy of a matrix with elements above the k-th diagonal zeroed. Lower triangular matrix.
     * @param ndiag [in] Diagonal above which to zero elements. ndiag = 0 (the default) is the main diagonal, ndiag < 0 is below it and ndiag > 0 is above.
     * @return (matrix)
     */
    matrix Tril(const int ndiag = 0);

    /**
     * Return a copy of a matrix with the elements below the k-th diagonal zeroed. Upper triangular matrix.
     * @param ndiag [in] Diagonal below which to zero elements. ndiag = 0 (the default) is the main diagonal, ndiag < 0 is below it and ndiag > 0 is above.
     * @return (matrix)
     */
    matrix Triu(const int ndiag = 0);

    /**
     * Compute the variance of values of matrix/vector elements.
     * @return (double)
     */
    double Var();

    /**
     * Compute the variance of values of matrix/vector elements.
     * @param axis [in] Axis. 0 - horizontal axis, 1 - vertical axis.
     * @return (vector)
     */
    vector Var(const int axis);

    /**
     * Split a matrix vertically into multiple submatrices. Same as Split with axis=1
     * @param parts [in] Number of submatrices to split the matrix into.
     * @param splitted [out] Array of resulting submatrices.
     * @return (bool)
     */
    bool Vsplit(const ulong parts, matrix (&splitted)[]);

    /**
     * Split a matrix vertically into multiple submatrices. Same as Split with axis=1
     * @param parts [in] Sizes of submatrices.
     * @param splitted [out] Array of resulting submatrices.
     */
    void Vsplit(const ulong (&parts)[], matrix (&splitted)[]);

    /**
     * This is a static function that creates and returns a new matrix filled with zeros.
     * @param rows [in] Number of rows.
     * @param cols [in] Number of columns.
     * @return (matrix)
     */
    static matrix Zeros(const ulong rows, const ulong cols);
}

#endif