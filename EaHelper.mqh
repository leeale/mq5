
#ifndef EA_HELPER_MQH
#define EA_HELPER_MQH

#include <Trade/Trade.mqh>
#property strict

// ================== ENUM GENERAL ==================
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
// ================== ENUM MA ==================
enum ENUM_MA_SIGNAL_TYPE
{
    MA_SIGNAL_CROSS,  // Cross
    MA_SIGNAL_UP_DOWN // Up And Down
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
enum ENUM_BB_SIGNAL_TYPE
{
    BB_SIGNAL_SELLUP_BUYDOWN, // Selll Up And Buy Down
    BB_SIGNAL_BUYUP_SELLDOWN  // Buy Up And Sell Down
};

// ======================== ENUM HELPER ==========================================================================

enum ENUM_INDICATOR_TYPE
{
    INDICATOR_MA,         // Moving Average
    INDICATOR_BB,         // Bollinger Bands
    INDICATOR_RSI,        // Relative Strength Index
    INDICATOR_MACD,       // Moving Average Convergence Divergence
    INDICATOR_STOCHASTIC, // Stochastic Oscillator
    INDICATOR_ATR,        // Average True Range
    INDICATOR_ADX         // Average Directional Index
};
enum ENUM_SIGNAL_TYPE
{
    SIGNAL_BUY,  // Sinyal Beli
    SIGNAL_SELL, // Sinyal Jual
    SIGNAL_NONE  // Tidak Ada Sinyal
};
enum ENUM_RISK_MANAGEMENT
{
    RISK_FIXED_LOT,      // Lot Tetap
    RISK_PERCENTAGE,     // Persentase dari Ekuitas
    RISK_MARTINGALE,     // Strategi Martingale
    RISK_ANTI_MARTINGALE // Strategi Anti-Martingale
};
enum ENUM_CUSTOM_TIMEFRAME
{
    TIMEFRAME_M1 = 1,     // 1 Menit
    TIMEFRAME_M5 = 5,     // 5 Menit
    TIMEFRAME_M15 = 15,   // 15 Menit
    TIMEFRAME_H1 = 60,    // 1 Jam
    TIMEFRAME_H4 = 240,   // 4 Jam
    TIMEFRAME_D1 = 1440,  // 1 Hari
    TIMEFRAME_W1 = 10080, // 1 Minggu
    TIMEFRAME_MN1 = 43200 // 1 Bulan
};
enum ENUM_STRATEGY_TYPE
{
    STRATEGY_TREND_FOLLOWING, // Strategi Mengikuti Tren
    STRATEGY_MEAN_REVERSION,  // Strategi Mean Reversion
    STRATEGY_BREAKOUT,        // Strategi Breakout
    STRATEGY_SCALPING         // Strategi Scalping
};

//==================== ==================== =============
/**
 *@brief Periksa apakah pegangan MA valid
 *
 *@param[in] simbol Simbol untuk diperiksa
 *@param[dalam] periode Jangka waktu untuk diperiksa
 *@param[dalam] ma_periode MA
 *@param[in] ma_shift Pergeseran MA
 *@param[in] ma_method Metode MA
 *@param[in] apply_price Harga MA yang diterapkan
 *@param[in] menangani Handle MA
 *
 *@return Benar jika pegangannya valid, salah jika sebaliknya
 */
bool IsHandle_MA(const string &symbol,
                 const ENUM_TIMEFRAMES period,
                 const int ma_period,
                 const int ma_shift,
                 const ENUM_MA_METHOD ma_method,
                 const ENUM_APPLIED_PRICE applied_price, int &handle)
{
    if (handle == INVALID_HANDLE)
    {
        Print("Trying to get handle of MA for symbol: ", symbol,
              " with period: ", period, " and MA period: ", ma_period,
              " and MA shift: ", ma_shift, " and MA method: ", ma_method,
              " and applied price: ", applied_price);
        handle = iMA(symbol, period, ma_period, ma_shift, ma_method, applied_price);
        if (handle == INVALID_HANDLE)
        {
            Print("Error in iMA: ", GetLastError());
            return false;
        }
    }

    return true;
}
bool IsHandle_BB(const string &symbol,
                 const ENUM_TIMEFRAMES period,
                 const int bands_period,
                 const double deviation,
                 const int bands_shift,
                 const ENUM_APPLIED_PRICE applied_price, int &handle)
{
    if (handle == INVALID_HANDLE)
    {
        handle = iBands(symbol, period, bands_period, bands_shift, deviation, applied_price);
        Print("Error in iBands: ", GetLastError());
        return false;
    }

    return true;
}
bool IsHandle_RSI(const string &symbol,
                  const ENUM_TIMEFRAMES period,
                  const int rsi_period,
                  const ENUM_APPLIED_PRICE applied_price)
{
    int handle = iRSI(symbol, period, rsi_period, applied_price);
    if (handle == INVALID_HANDLE)
    {
        Print("Error in iRSI: ", GetLastError());
        return false;
    }
    return true;
}
bool IsHandle_MACD(const string &symbol,
                   const ENUM_TIMEFRAMES period,
                   const int fast_ema_period,
                   const int slow_ema_period,
                   const int signal_period,
                   const ENUM_APPLIED_PRICE applied_price)
{
    int handle = iMACD(symbol, period, fast_ema_period, slow_ema_period, signal_period, applied_price);
    if (handle == INVALID_HANDLE)
    {
        Print("Error in iMACD: ", GetLastError());
        return false;
    }
    return true;
}
bool IsHandle_Stochastic(const string &symbol,
                         const ENUM_TIMEFRAMES period,
                         const int k_period,
                         const int d_period,
                         const int slowing,
                         const ENUM_MA_METHOD ma_method,
                         const ENUM_STO_PRICE price_field)
{
    int handle = iStochastic(symbol, period, k_period, d_period, slowing, ma_method, price_field);
    if (handle == INVALID_HANDLE)
    {
        Print("Error in iStochastic: ", GetLastError());
        return false;
    }
    return true;
}
//=================================================================================================================
bool IsValidVolume(double volume, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    double minVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
    double stepVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);
    return (volume >= minVolume && fmod(volume - minVolume, stepVolume) == 0.0);
}

void ReleaseHandleMA(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
        Print("Handle MA telah dirilis.");
    }
    else
    {
        Print("Handle tidak valid, tidak perlu dirilis.");
    }
}
void ReleaseHandleBB(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
        Print("Handle Bollinger Bands telah dirilis.");
    }
    else
    {
        Print("Handle tidak valid, tidak perlu dirilis.");
    }
}
void ReleaseHandleRSI(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
        Print("Handle RSI telah dirilis.");
    }
    else
    {
        Print("Handle RSI tidak valid, tidak perlu dirilis.");
    }
}
void ReleaseHandleMACD(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
        Print("Handle MACD telah dirilis.");
    }
    else
    {
        Print("Handle MACD tidak valid, tidak perlu dirilis.");
    }
}
void ReleaseHandleStochastic(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
        Print("Handle Stochastic telah dirilis.");
    }
    else
    {
        Print("Handle Stochastic tidak valid, tidak perlu dirilis.");
    }
}
//=================================================================================================================
double GetBidPrice(const string symbol)
{
    return SymbolInfoDouble(symbol, SYMBOL_BID);
}
double GetAskPrice(const string symbol)
{
    return SymbolInfoDouble(symbol, SYMBOL_ASK);
}
double GetLastPrice(const string symbol)
{
    return SymbolInfoDouble(symbol, SYMBOL_LAST);
}
int CalculateDistanceInPoints(const string symbol, double price1, double price2)
{
    double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
    return (int)MathRound(MathAbs(price1 - price2) / point);
}
double GetAskPrice2(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoDouble(symbol, SYMBOL_ASK);
}

double GetBidPrice2(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoDouble(symbol, SYMBOL_BID);
}

bool OpenMarketOrder(const string symbol, ENUM_ORDER_TYPE order_type, double volume, double sl = 0, double tp = 0)
{
    CTrade trade;
    if (order_type == ORDER_TYPE_BUY)
    {
        if (!trade.Buy(volume, symbol, GetAskPrice(symbol), sl, tp))
        {
            Print("Error in Buy: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
            return false;
        }
        else
        {
            Print("Buy Order Executed Successfully");
            return true;
        }
    }
    else if (order_type == ORDER_TYPE_SELL)
    {
        if (!trade.Sell(volume, symbol, GetBidPrice(symbol), sl, tp))
        {
            Print("Error in Sell: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
            return false;
        }
        else
        {
            Print("Sell Order Executed Successfully");
            return true;
        }
    }
    return false;
}
bool OpenPendingOrder(const string symbol, ENUM_ORDER_TYPE order_type, double volume, double limit_price, double price, double sl = 0, double tp = 0)
{
    CTrade trade;
    if (order_type == ORDER_TYPE_BUY_LIMIT || order_type == ORDER_TYPE_BUY_STOP ||
        order_type == ORDER_TYPE_SELL_LIMIT || order_type == ORDER_TYPE_SELL_STOP)
    {
        if (!trade.OrderOpen(symbol, order_type, volume, limit_price, price, sl, tp))
        {
            Print("Error in Pending OrderOpen : ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
            return false;
        }
        else
        {
            Print("Pending Order Executed Successfully");
            return true;
        }
    }
    return false;
}
bool CloseOrderByTicket(ulong ticket)
{
    CTrade trade;
    return trade.PositionClose(ticket);
}
void CloseAllOrders(const string symbol)
{
    CTrade trade;
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        ulong ticket = PositionGetTicket(i);
        if (PositionGetString(POSITION_SYMBOL) == symbol)
        {
            trade.PositionClose(ticket);
        }
    }
}
bool HasOpenPosition(const string symbol)
{
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (PositionGetString(POSITION_SYMBOL) == symbol)
        {
            return true;
        }
    }
    return false;
}
int CountOpenPositions(const string symbol)
{
    int count = 0;
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (PositionGetString(POSITION_SYMBOL) == symbol)
        {
            count++;
        }
    }
    return count;
}
bool ModifyOrder(ulong ticket, double sl, double tp)
{
    CTrade trade;
    return trade.PositionModify(ticket, sl, tp);
}
double GetOrderOpenPrice(ulong ticket)
{
    if (PositionSelectByTicket(ticket))
    {
        return PositionGetDouble(POSITION_PRICE_OPEN);
    }
    Print("Order tidak ditemukan.");
    return 0.0;
}
double GetOrderVolume(ulong ticket)
{
    if (PositionSelectByTicket(ticket))
    {
        return PositionGetDouble(POSITION_VOLUME);
    }
    Print("Order tidak ditemukan.");
    return 0.0;
}
int GetServerHour()
{
    datetime serverTime = TimeCurrent();
    MqlDateTime timeStruct;
    TimeToStruct(serverTime, timeStruct);
    return timeStruct.hour;
}

int GetServerMinute()
{
    datetime serverTime = TimeCurrent();
    MqlDateTime timeStruct;
    TimeToStruct(serverTime, timeStruct);
    return timeStruct.min;
}
int GetActivePositions(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    int totalPositions = PositionsTotal();
    int count = 0;

    for (int i = 0; i < totalPositions; i++)
    {
        ulong ticket = PositionGetTicket(i);
        if (PositionGetString(POSITION_SYMBOL) == symbol)
            count++;
    }
    return count;
}
double GetAccountBalance()
{
    return AccountInfoDouble(ACCOUNT_BALANCE);
}

double GetAccountEquity()
{
    return AccountInfoDouble(ACCOUNT_EQUITY);
}
double CalculateLotByRisk(double riskPercent, double stopLossPoints, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
    double contractSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE);
    double stopLossValue = stopLossPoints * (tickValue / tickSize);

    double riskAmount = balance * (riskPercent / 100.0);
    double lotSize = riskAmount / stopLossValue;
    double minVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
    double stepVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);

    // Menyesuaikan lot sesuai dengan langkah volume
    lotSize = MathMax(minVolume, MathFloor(lotSize / stepVolume) * stepVolume);
    return lotSize;
}
bool IsSymbolTradeable(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE) == SYMBOL_TRADE_MODE_FULL;
}
double GetSpreadPoints(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
    double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
    double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
    return (ask - bid) / point;
}
bool IsTradingAllowed()
{
    return TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) && AccountInfoInteger(ACCOUNT_TRADE_ALLOWED);
}
double CalculateStopLoss(double entryPrice, double stopLossPoints, bool isBuy)
{
    double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
    if (isBuy)
        return entryPrice - stopLossPoints * point;
    else
        return entryPrice + stopLossPoints * point;
}

double CalculateTakeProfit(double entryPrice, double takeProfitPoints, bool isBuy)
{
    double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
    if (isBuy)
        return entryPrice + takeProfitPoints * point;
    else
        return entryPrice - takeProfitPoints * point;
}
bool IsPositionExists(int magicNumber, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (PositionSelect(symbol) &&
            PositionGetInteger(POSITION_MAGIC) == magicNumber &&
            PositionGetString(POSITION_SYMBOL) == symbol)
        {
            return true;
        }
    }
    return false;
}
double GetATR(int period, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double atr[];
    if (CopyBuffer(iATR(symbol, timeframe, period), 0, 0, 1, atr) <= 0)
    {
        Print("Failed to get ATR data!");
        return 0;
    }
    return atr[0];
}
double CalculatePendingOrderPrice(bool isBuy, bool isStopOrder, double distancePoints)
{
    double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
    double ask = GetAskPrice2();
    double bid = GetBidPrice2();

    if (isBuy)
    {
        if (isStopOrder)
            return ask + distancePoints * point; // Buy Stop
        else
            return ask - distancePoints * point; // Buy Limit
    }
    else
    {
        if (isStopOrder)
            return bid - distancePoints * point; // Sell Stop
        else
            return bid + distancePoints * point; // Sell Limit
    }
}
bool IsValidPendingOrderPrice(double price, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
    return fmod(price, tickSize) == 0.0;
}
double CalculateRequiredMargin(double volume, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    double margin;
    if (OrderCalcMargin(ORDER_TYPE_BUY, symbol, volume, SymbolInfoDouble(symbol, SYMBOL_ASK), margin))
        return margin;
    else
    {
        Print("Failed to calculate margin: ", GetLastError());
        return -1;
    }
}
double CalculateLotByRiskPercentage(double riskPercentage, double stopLossPoints, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
    double stopLossValue = stopLossPoints * (tickValue / tickSize);

    double riskAmount = balance * (riskPercentage / 100.0);
    double lotSize = riskAmount / stopLossValue;

    // Menyesuaikan lot sesuai dengan langkah volume
    double minVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
    double stepVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);
    lotSize = MathMax(minVolume, MathFloor(lotSize / stepVolume) * stepVolume);

    return lotSize;
}
bool IsMarketOpen(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    // Mendapatkan waktu server saat ini
    datetime serverTime = TimeCurrent();
    MqlDateTime timeStruct;
    TimeToStruct(serverTime, timeStruct);

    // Mendapatkan jam buka dan tutup pasar (contoh untuk Forex: 24 jam)
    // Anda dapat menyesuaikan dengan jam pasar yang sesuai
    int marketOpenHour = 0;   // Jam buka pasar
    int marketCloseHour = 24; // Jam tutup pasar

    return (timeStruct.hour >= marketOpenHour && timeStruct.hour < marketCloseHour);
}
bool IsSpreadAcceptable(double maxSpreadPoints, string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double spreadPoints = GetSpreadPoints(symbol);
    return (spreadPoints <= maxSpreadPoints);
}
bool IsHighImpactNews(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    // Contoh: Anda dapat menggunakan API atau sumber data eksternal untuk mengecek berita
    // Ini adalah placeholder, Anda perlu mengimplementasikan logika sesuai kebutuhan
    return false;
}
double DistanceToNearestSupportResistance(double price, const double &levels[], string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double minDistance = DBL_MAX;
    for (int i = 0; i < ArraySize(levels); i++)
    {
        double distance = MathAbs(price - levels[i]);
        if (distance < minDistance)
        {
            minDistance = distance;
        }
    }
    return minDistance;
}
bool IsReversalCandle(int shift, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double open = iOpen(symbol, timeframe, shift);
    double close = iClose(symbol, timeframe, shift);
    double high = iHigh(symbol, timeframe, shift);
    double low = iLow(symbol, timeframe, shift);

    // Contoh: Candle bullish reversal (hammer)
    bool isBullishReversal = (close > open) && ((close - open) < (high - low) * 0.3);

    // Contoh: Candle bearish reversal (shooting star)
    bool isBearishReversal = (close < open) && ((open - close) < (high - low) * 0.3);

    return (isBullishReversal || isBearishReversal);
}
bool IsPriceGap(double threshold, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) // Gap Harga
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan

    double previousClose = iClose(symbol, timeframe, 1); // Menutup harga sebelumnya
    double currentOpen = iOpen(symbol, timeframe, 0);    // Harga buka saat ini
    double gap = MathAbs(currentOpen - previousClose);   // Menggunakan nilai absolut untuk memastikan nilai positif

    return (gap > threshold); // Jika gap lebih besar dari threshold, maka gap harga terjadi
}

#endif // EA_HELPER_MQH