#property strict
#include <Trade/Trade.mqh>
#include <Indicators/Trend.mqh>
#include <Trade/SymbolInfo.mqh>
#include <Trade/AccountInfo.mqh>
#include <Trade/DealInfo.mqh>

// Fungsi untuk menghitung nilai risk berdasarkan persentase balance
double CalculateRiskPercentage(double balance, double riskPercent)
{
    return balance * riskPercent / 100;
}

// Fungsi untuk menghitung lot size berdasarkan risk dan stop loss
double CalculateLotSize(double riskAmount, double stopLossPoints, string symbol)
{
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double pointValue = SymbolInfoDouble(symbol, SYMBOL_POINT);

    if (stopLossPoints == 0 || tickValue == 0 || pointValue == 0)
        return 0;

    return riskAmount / (stopLossPoints * pointValue * tickValue);
}

// Fungsi untuk mengecek apakah candle bullish
bool IsBullishCandle(int shift = 0)
{
    return iClose(NULL, 0, shift) > iOpen(NULL, 0, shift);
}

// Fungsi untuk mengecek apakah candle bearish
bool IsBearishCandle(int shift = 0)
{
    return iClose(NULL, 0, shift) < iOpen(NULL, 0, shift);
}

// Fungsi untuk mendapatkan level support/resistance terdekat
double GetNearestLevel(double price, double &levels[], int totalLevels)
{
    double nearestLevel = 0;
    double minDistance = DBL_MAX;

    for (int i = 0; i < totalLevels; i++)
    {
        double distance = MathAbs(price - levels[i]);
        if (distance < minDistance)
        {
            minDistance = distance;
            nearestLevel = levels[i];
        }
    }

    return nearestLevel;
}

// Fungsi untuk menghitung jarak antara dua harga dalam points
int CalculatePointsDistance(double price1, double price2, string symbol)
{
    double pointValue = SymbolInfoDouble(symbol, SYMBOL_POINT);
    if (pointValue == 0)
        return 0;

    return (int)MathRound(MathAbs(price1 - price2) / pointValue);
}

// Fungsi untuk menghitung ukuran posisi berdasarkan risk dan stop loss
double CalculatePositionSize(double accountBalance, double riskPercent, double stopLossPips, string symbol)
{
    double riskAmount = CalculateRiskPercentage(accountBalance, riskPercent);
    return CalculateLotSize(riskAmount, stopLossPips, symbol);
}

// Fungsi untuk menghitung risk/reward ratio
double CalculateRiskRewardRatio(double entryPrice, double stopLossPrice, double takeProfitPrice, string symbol)
{
    double risk = MathAbs(entryPrice - stopLossPrice);
    double reward = MathAbs(takeProfitPrice - entryPrice);

    if (risk == 0)
        return 0;

    return reward / risk;
}

// Fungsi untuk mengecek apakah market sedang uptrend
bool IsTrendingUp(int period = 14)
{
    return iClose(NULL, 0, 1) > iClose(NULL, 0, period);
}

// Fungsi untuk mengecek apakah market sedang downtrend
bool IsTrendingDown(int period = 14)
{
    return iClose(NULL, 0, 1) < iClose(NULL, 0, period);
}

// Fungsi untuk menormalkan lot size sesuai dengan batasan broker
double NormalizeLotSize(double lotSize, string symbol)
{
    double minLot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
    double maxLot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
    double lotStep = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);

    lotSize = MathMax(lotSize, minLot);
    lotSize = MathMin(lotSize, maxLot);

    return MathRound(lotSize / lotStep) * lotStep;
}

// Fungsi untuk menghitung nilai pip untuk pair tertentu
double CalculatePipValue(string symbol)
{
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);

    if (tickSize == 0)
        return 0;

    return tickValue * (SymbolInfoDouble(symbol, SYMBOL_POINT) / tickSize);
}

// Fungsi untuk menghitung margin yang dibutuhkan untuk posisi
double CalculateMargin(double lotSize, string symbol, int orderType)
{
    double margin = 0;
    double price = 0;

    if (orderType == ORDER_TYPE_BUY)
        price = SymbolInfoDouble(symbol, SYMBOL_ASK);
    else if (orderType == ORDER_TYPE_SELL)
        price = SymbolInfoDouble(symbol, SYMBOL_BID);

    margin = SymbolInfoDouble(symbol, SYMBOL_MARGIN_INITIAL) * lotSize * price;
    return margin;
}

// Fungsi untuk menghitung nilai swap untuk posisi
double CalculateSwap(double lotSize, string symbol, int orderType)
{
    double swapLong = SymbolInfoDouble(symbol, SYMBOL_SWAP_LONG);
    double swapShort = SymbolInfoDouble(symbol, SYMBOL_SWAP_SHORT);

    if (orderType == ORDER_TYPE_BUY)
        return lotSize * swapLong;
    else if (orderType == ORDER_TYPE_SELL)
        return lotSize * swapShort;

    return 0;
}

// ==================== Reminder Algoritma ====================

// Fungsi untuk mengurutkan array menggunakan Bubble Sort
void BubbleSort(double &arr[])
{
    int n = ArraySize(arr);
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = 0; j < n - i - 1; j++)
        {
            if (arr[j] > arr[j + 1])
            {
                double temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

// Fungsi untuk mencari nilai maksimum dalam array
double FindMaxValue(double &arr[])
{
    double maxVal = arr[0];
    for (int i = 1; i < ArraySize(arr); i++)
    {
        if (arr[i] > maxVal)
        {
            maxVal = arr[i];
        }
    }
    return maxVal;
}

// Fungsi untuk mencari nilai minimum dalam array
double FindMinValue(double &arr[])
{
    double minVal = arr[0];
    for (int i = 1; i < ArraySize(arr); i++)
    {
        if (arr[i] < minVal)
        {
            minVal = arr[i];
        }
    }
    return minVal;
}

// Fungsi untuk menghitung rata-rata dari array
double CalculateAverage(double &arr[])
{
    double sum = 0;
    for (int i = 0; i < ArraySize(arr); i++)
    {
        sum += arr[i];
    }
    return sum / ArraySize(arr);
}

// Fungsi untuk menghitung standar deviasi
double CalculateStdDev(double &arr[])
{
    double mean = CalculateAverage(arr);
    double sum = 0;
    for (int i = 0; i < ArraySize(arr); i++)
    {
        sum += MathPow(arr[i] - mean, 2);
    }
    return MathSqrt(sum / ArraySize(arr));
}

// Fungsi untuk mencari nilai dalam array menggunakan Binary Search
int BinarySearch(double &arr[], double target)
{
    int low = 0;
    int high = ArraySize(arr) - 1;

    while (low <= high)
    {
        int mid = (low + high) / 2;
        if (arr[mid] == target)
        {
            return mid;
        }
        else if (arr[mid] < target)
        {
            low = mid + 1;
        }
        else
        {
            high = mid - 1;
        }
    }
    return -1; // Return -1 jika tidak ditemukan
}

// Fungsi untuk menghitung Fibonacci sequence
int Fibonacci(int n)
{
    if (n <= 1)
    {
        return n;
    }
    return Fibonacci(n - 1) + Fibonacci(n - 2);
}

// Fungsi untuk menghitung faktorial
int Factorial(int n)
{
    if (n == 0)
    {
        return 1;
    }
    return n * Factorial(n - 1);
}

// Fungsi untuk mengecek apakah suatu bilangan prima
bool IsPrime(int n)
{
    if (n <= 1)
    {
        return false;
    }
    for (int i = 2; i <= MathSqrt(n); i++)
    {
        if (n % i == 0)
        {
            return false;
        }
    }
    return true;
}

// ==================== Helper Trade ====================

// Fungsi untuk membuka posisi buy
bool OpenBuyPosition(string symbol, double lotSize, double sl = 0, double tp = 0)
{
    CTrade trade;
    return trade.Buy(lotSize, symbol, 0, sl, tp);
}

// Fungsi untuk membuka posisi sell
bool OpenSellPosition(string symbol, double lotSize, double sl = 0, double tp = 0)
{
    CTrade trade;
    return trade.Sell(lotSize, symbol, 0, sl, tp);
}

// Fungsi untuk menutup semua posisi
bool CloseAllPositions(string symbol)
{
    CTrade trade;
    return trade.PositionClose(symbol);
}

// Fungsi untuk menutup posisi berdasarkan ticket
bool ClosePositionByTicket(ulong ticket)
{
    CTrade trade;
    return trade.PositionClose(ticket);
}

// ==================== Helper Indicator Release ====================

// Fungsi untuk melepaskan handle indikator
void ReleaseIndicatorHandle(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
    }
}

// Fungsi untuk melepaskan semua handle indikator
void ReleaseAllIndicatorHandles()
{
    // Di MQL5, kita perlu menyimpan handle indikator secara manual
    // Fungsi ini hanya melepaskan handle yang diberikan secara eksplisit
    // Pengguna perlu mengelola daftar handle mereka sendiri
    // Contoh implementasi:
    // 1. Buat array untuk menyimpan handle indikator
    // 2. Tambahkan handle ke array saat membuat indikator
    // 3. Lepaskan handle dari array saat tidak diperlukan
    // Fungsi ini hanya sebagai reminder untuk melepaskan handle
}

// Fungsi untuk mendapatkan handle Moving Average dengan parameter default
int GetMAHandle(string symbol, int period = 14, ENUM_MA_METHOD maMethod = MODE_SMA, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iMA(symbol, 0, period, 0, maMethod, priceType);
}

// Fungsi untuk mendapatkan handle RSI dengan parameter default
int GetRSIHandle(string symbol, int period = 14, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iRSI(symbol, 0, period, priceType);
}

// Fungsi untuk mendapatkan handle MACD dengan parameter default
int GetMACDHandle(string symbol, int fastEMA = 12, int slowEMA = 26, int signalSMA = 9, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iMACD(symbol, 0, fastEMA, slowEMA, signalSMA, priceType);
}

// Fungsi untuk mendapatkan handle Bollinger Bands dengan parameter default
int GetBollingerBandsHandle(string symbol, int period = 20, double deviation = 2.0, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iBands(symbol, 0, period, 0, deviation, priceType);
}

// Fungsi untuk mendapatkan handle Stochastic dengan parameter default
int GetStochasticHandle(string symbol, int kPeriod = 5, int dPeriod = 3, int slowing = 3, ENUM_STO_PRICE priceField = STO_LOWHIGH)
{
    return iStochastic(symbol, 0, kPeriod, dPeriod, slowing, MODE_SMA, priceField);
}

// Fungsi untuk mendapatkan handle Moving Average
int GetMAHandle(int period, ENUM_MA_METHOD maMethod = MODE_SMA, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iMA(NULL, 0, period, 0, maMethod, priceType);
}

// Fungsi untuk mendapatkan handle Relative Strength Index (RSI)
int GetRSIHandle(int period, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iRSI(NULL, 0, period, priceType);
}

// Fungsi untuk mendapatkan handle Moving Average Convergence Divergence (MACD)
int GetMACDHandle(int fastEMA, int slowEMA, int signalSMA, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iMACD(NULL, 0, fastEMA, slowEMA, signalSMA, priceType);
}

// Fungsi untuk mendapatkan handle Bollinger Bands
int GetBollingerBandsHandle(int period, double deviation, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    return iBands(NULL, 0, period, 0, deviation, priceType);
}

// Fungsi untuk mendapatkan handle Stochastic Oscillator
int GetStochasticHandle(int kPeriod, int dPeriod, int slowing, ENUM_STO_PRICE priceField = STO_LOWHIGH)
{
    return iStochastic(NULL, 0, kPeriod, dPeriod, slowing, MODE_SMA, priceField);
}

// Fungsi untuk menghitung Commodity Channel Index (CCI)
double CalculateCCI(int period, int shift = 0)
{
    double cci[1];
    int handle = iCCI(NULL, 0, period, PRICE_TYPICAL);
    if (CopyBuffer(handle, 0, shift, 1, cci) == 1)
        return cci[0];
    return 0;
}

// Fungsi untuk menghitung On Balance Volume (OBV)
double CalculateOBV(int shift = 0)
{
    double obv[1];
    int handle = iOBV(NULL, 0, VOLUME_TICK);
    if (CopyBuffer(handle, 0, shift, 1, obv) == 1)
        return obv[0];
    return 0;
}

// Fungsi untuk menghitung Williams Percent Range (WPR)
double CalculateWPR(int period, int shift = 0)
{
    double wpr[1];
    int handle = iWPR(NULL, 0, period);
    if (CopyBuffer(handle, 0, shift, 1, wpr) == 1)
        return wpr[0];
    return 0;
}

// Fungsi untuk menghitung Money Flow Index (MFI)
double CalculateMFI(int period, int shift = 0)
{
    double mfi[1];
    int handle = iMFI(NULL, 0, period, VOLUME_TICK);
    if (CopyBuffer(handle, 0, shift, 1, mfi) == 1)
        return mfi[0];
    return 0;
}

// Fungsi untuk menghitung nilai moving average
double CalculateMovingAverage(int period, ENUM_MA_METHOD maMethod = MODE_SMA, int shift = 0, ENUM_APPLIED_PRICE priceType = PRICE_CLOSE)
{
    double ma[1];
    int handle = iMA(NULL, 0, period, 0, maMethod, priceType);
    if (CopyBuffer(handle, 0, shift, 1, ma) == 1)
        return ma[0];
    return 0;
}

// Fungsi untuk menghitung VWAP (Volume Weighted Average Price)
double CalculateVolumeWeightedAveragePrice(int period, int shift = 0)
{
    double vwap[1];
    int handle = iCustom(NULL, 0, "Examples\\VWAP", period);
    if (CopyBuffer(handle, 0, shift, 1, vwap) == 1)
        return vwap[0];
    return 0;
}

// Fungsi untuk menghitung standar deviasi
double CalculateStandardDeviation(int period, int shift = 0, int priceType = PRICE_CLOSE)
{
    double stdDev[1];
    int handle = iStdDev(NULL, 0, period, 0, MODE_SMA, priceType);
    if (CopyBuffer(handle, 0, shift, 1, stdDev) == 1)
        return stdDev[0];
    return 0;
}

// Fungsi untuk menghitung nilai Parabolic SAR
double CalculateParabolicSAR(double step = 0.02, double maximum = 0.2, int shift = 0)
{
    double sar[1];
    int handle = iSAR(NULL, 0, step, maximum);
    if (CopyBuffer(handle, 0, shift, 1, sar) == 1)
        return sar[0];
    return 0;
}

// Fungsi untuk menghitung komponen Ichimoku Cloud
bool CalculateIchimokuCloud(int tenkan, int kijun, int senkou, int shift,
                            double &tenkanSen, double &kijunSen, double &senkouSpanA, double &senkouSpanB)
{
    double tenkanBuffer[1], kijunBuffer[1], senkouA[1], senkouB[1];
    int handle = iIchimoku(NULL, 0, tenkan, kijun, senkou);

    if (CopyBuffer(handle, 0, shift, 1, tenkanBuffer) == 1 &&
        CopyBuffer(handle, 1, shift, 1, kijunBuffer) == 1 &&
        CopyBuffer(handle, 2, shift, 1, senkouA) == 1 &&
        CopyBuffer(handle, 3, shift, 1, senkouB) == 1)
    {
        tenkanSen = tenkanBuffer[0];
        kijunSen = kijunBuffer[0];
        senkouSpanA = senkouA[0];
        senkouSpanB = senkouB[0];
        return true;
    }
    return false;
}

// Fungsi untuk menghitung nilai ADX (Average Directional Index)
double CalculateADX(int period = 14, int shift = 0)
{
    double adx[1];
    int handle = iADX(NULL, 0, period);
    if (CopyBuffer(handle, 0, shift, 1, adx) == 1)
        return adx[0];
    return 0;
}

// Fungsi untuk menghitung nilai Bollinger Bands
bool CalculateBollingerBands(int period, int deviation, int shift, double &upperBand, double &lowerBand)
{
    double upper[1], lower[1];
    int handle = iBands(NULL, 0, period, 0, deviation, PRICE_CLOSE);
    if (CopyBuffer(handle, UPPER_BAND, shift, 1, upper) == 1 &&
        CopyBuffer(handle, 2, LOWER_BAND, 1, lower) == 1)
    {
        upperBand = upper[0];
        lowerBand = lower[0];
        return true;
    }
    return false;
}

// Fungsi untuk menghitung nilai Stochastic Oscillator
bool CalculateStochastic(int kPeriod, int dPeriod, int slowing, int shift, double &stochK, double &stochD)
{
    double k[1], d[1];
    int handle = iStochastic(NULL, 0, kPeriod, dPeriod, slowing, MODE_SMA, STO_LOWHIGH);
    if (CopyBuffer(handle, 0, shift, 1, k) == 1 &&
        CopyBuffer(handle, 1, shift, 1, d) == 1)
    {
        stochK = k[0];
        stochD = d[0];
        return true;
    }
    return false;
}

// Fungsi untuk menghitung level Fibonacci retracement
void CalculateFibonacciLevels(double highPrice, double lowPrice, double &level236, double &level382, double &level500, double &level618, double &level764)
{
    double range = highPrice - lowPrice;
    level236 = highPrice - range * 0.236;
    level382 = highPrice - range * 0.382;
    level500 = highPrice - range * 0.500;
    level618 = highPrice - range * 0.618;
    level764 = highPrice - range * 0.764;
}

// Fungsi untuk menghitung profit/loss dari posisi terbuka
double CalculatePositionProfit(double openPrice, double currentPrice, double lotSize, string symbol)
{
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
    double pointValue = SymbolInfoDouble(symbol, SYMBOL_POINT);

    if (tickSize == 0 || pointValue == 0)
        return 0;

    double priceDiff = currentPrice - openPrice;
    return (priceDiff / tickSize) * tickValue * lotSize;
}

// Fungsi untuk menghitung risk per trade berdasarkan stop loss
double CalculateRiskPerTrade(double entryPrice, double stopLossPrice, double lotSize, string symbol)
{
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
    double pointValue = SymbolInfoDouble(symbol, SYMBOL_POINT);

    if (tickSize == 0 || pointValue == 0)
        return 0;

    double priceDiff = MathAbs(entryPrice - stopLossPrice);
    return (priceDiff / tickSize) * tickValue * lotSize;
}

// Fungsi untuk menghitung harga break even untuk posisi
double CalculateBreakEvenPrice(double openPrice, double lotSize, double commission, string symbol)
{
    double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);

    if (tickValue == 0 || tickSize == 0)
        return 0;

    double breakEvenDiff = commission / (lotSize * tickValue);
    return openPrice + (breakEvenDiff * tickSize);
}

// Fungsi untuk menghitung nilai ATR (Average True Range)
double CalculateATR(int period, int shift = 0)
{
    double atr[1];
    int handle = iATR(NULL, 0, period);
    if (CopyBuffer(handle, 0, shift, 1, atr) == 1)
        return atr[0];
    return 0;
}

// Fungsi untuk menghitung nilai RSI (Relative Strength Index)
double CalculateRSI(int period, int shift = 0)
{
    double rsi[1];
    int handle = iRSI(NULL, 0, period, PRICE_CLOSE);
    if (CopyBuffer(handle, 0, shift, 1, rsi) == 1)
        return rsi[0];
    return 0;
}

// Fungsi untuk menghitung nilai MACD (Moving Average Convergence Divergence)
double CalculateMACD(int fastEMA, int slowEMA, int signalSMA, int shift = 0)
{
    double macd[1];
    int handle = iMACD(NULL, 0, fastEMA, slowEMA, signalSMA, PRICE_CLOSE);
    if (CopyBuffer(handle, 0, shift, 1, macd) == 1)
        return macd[0];
    return 0;
}
