#property strict
/**
 * @brief Mendapatkan nilai Moving Average pada candle tertentu
 *
 * @param[in] handle Handle indikator Moving Average
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @return Nilai Moving Average pada candle yang dimaksud
 */
double GetMAValue(int handle, int shift = 0)
{
    double maValue[1];
    if (CopyBuffer(handle, 0, shift, 1, maValue) <= 0)
    {
        Print("Failed to get MA value: ", GetLastError());
        return 0;
    }
    return maValue[0];
}
/**
 * @brief Mendapatkan nilai upper dan lower band dari Bollinger Bands
 *
 * @param[in] handle Handle indikator Bollinger Bands
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[out] upperBand Nilai upper band yang didapatkan
 * @param[out] lowerBand Nilai lower band yang didapatkan
 */
void GetBBValues(int handle, int shift, double &upperBand, double &lowerBand)
{
    double upper[1], lower[1];
    if (CopyBuffer(handle, 1, shift, 1, upper) <= 0 || CopyBuffer(handle, 2, shift, 1, lower) <= 0)
    {
        Print("Failed to get BB values: ", GetLastError());
        upperBand = 0;
        lowerBand = 0;
        return;
    }
    upperBand = upper[0];
    lowerBand = lower[0];
}
/**
 * @brief Mendapatkan nilai Relative Strength Index (RSI)
 *
 * @param[in] handle Handle indikator RSI
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @return Nilai RSI pada candle yang dimaksud
 */
double GetRSIValue(int handle, int shift = 0)
{
    double rsiValue[1];
    if (CopyBuffer(handle, 0, shift, 1, rsiValue) <= 0)
    {
        Print("Failed to get RSI value: ", GetLastError());
        return 0;
    }
    return rsiValue[0];
}
/**
 * @brief Mendapatkan nilai MACD line dan signal line
 *
 * @param[in] handle Handle indikator MACD
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[out] macdLine Nilai MACD line yang didapatkan
 * @param[out] signalLine Nilai signal line yang didapatkan
 */
void GetMACDValues(int handle, int shift, double &macdLine, double &signalLine)
{
    double macd[1], signal[1];
    if (CopyBuffer(handle, 0, shift, 1, macd) <= 0 || CopyBuffer(handle, 1, shift, 1, signal) <= 0)
    {
        Print("Failed to get MACD values: ", GetLastError());
        macdLine = 0;
        signalLine = 0;
        return;
    }
    macdLine = macd[0];
    signalLine = signal[0];
}
/**
 * @brief Mendapatkan nilai main line dan signal line dari Stochastic
 *
 * @param[in] handle Handle indikator Stochastic
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[out] mainLine Nilai main line yang didapatkan
 * @param[out] signalLine Nilai signal line yang didapatkan
 */
void GetStochasticValues(int handle, int shift, double &mainLine, double &signalLine)
{
    double main[1], signal[1];
    if (CopyBuffer(handle, 0, shift, 1, main) <= 0 || CopyBuffer(handle, 1, shift, 1, signal) <= 0)
    {
        Print("Failed to get Stochastic values: ", GetLastError());
        mainLine = 0;
        signalLine = 0;
        return;
    }
    mainLine = main[0];
    signalLine = signal[0];
}
/**
 * @brief Mendapatkan nilai Average True Range (ATR)
 *
 * @param[in] handle Handle indikator ATR
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @return Nilai ATR pada candle yang dimaksud
 */
double GetATRValue(int handle, int shift = 0)
{
    double atrValue[1];
    if (CopyBuffer(handle, 0, shift, 1, atrValue) <= 0)
    {
        Print("Failed to get ATR value: ", GetLastError());
        return 0;
    }
    return atrValue[0];
}
/**
 * @brief Mendapatkan nilai ADX line, +DI dan -DI
 *
 * @param[in] handle Handle indikator ADX
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[out] adxLine Nilai ADX line yang didapatkan
 * @param[out] plusDI Nilai +DI yang didapatkan
 * @param[out] minusDI Nilai -DI yang didapatkan
 */
void GetADXValues(int handle, int shift, double &adxLine, double &plusDI, double &minusDI)
{
    double adx[1], plus[1], minus[1];
    if (CopyBuffer(handle, 0, shift, 1, adx) <= 0 || CopyBuffer(handle, 1, shift, 1, plus) <= 0 || CopyBuffer(handle, 2, shift, 1, minus) <= 0)
    {
        Print("Failed to get ADX values: ", GetLastError());
        adxLine = 0;
        plusDI = 0;
        minusDI = 0;
        return;
    }
    adxLine = adx[0];
    plusDI = plus[0];
    minusDI = minus[0];
}
/**
 * @brief Mendapatkan nilai komponen Ichimoku Cloud
 *
 * @param[in] handle Handle indikator Ichimoku
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[out] tenkanSen Nilai Tenkan-sen yang didapatkan
 * @param[out] kijunSen Nilai Kijun-sen yang didapatkan
 * @param[out] senkouSpanA Nilai Senkou Span A yang didapatkan
 * @param[out] senkouSpanB Nilai Senkou Span B yang didapatkan
 */
void GetIchimokuValues(int handle, int shift, double &tenkanSen, double &kijunSen, double &senkouSpanA, double &senkouSpanB)
{
    double tenkan[1], kijun[1], spanA[1], spanB[1];
    if (CopyBuffer(handle, 0, shift, 1, tenkan) <= 0 || CopyBuffer(handle, 1, shift, 1, kijun) <= 0 || CopyBuffer(handle, 2, shift, 1, spanA) <= 0 || CopyBuffer(handle, 3, shift, 1, spanB) <= 0)
    {
        Print("Failed to get Ichimoku values: ", GetLastError());
        tenkanSen = 0;
        kijunSen = 0;
        senkouSpanA = 0;
        senkouSpanB = 0;
        return;
    }
    tenkanSen = tenkan[0];
    kijunSen = kijun[0];
    senkouSpanA = spanA[0];
    senkouSpanB = spanB[0];
}
/**
 * @brief Mendapatkan nilai Parabolic SAR
 *
 * @param[in] handle Handle indikator Parabolic SAR
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @return Nilai Parabolic SAR pada candle yang dimaksud
 */
double GetParabolicSARValue(int handle, int shift = 0)
{
    double sarValue[1];
    if (CopyBuffer(handle, 0, shift, 1, sarValue) <= 0)
    {
        Print("Failed to get Parabolic SAR value: ", GetLastError());
        return 0;
    }
    return sarValue[0];
}
/**
 * @brief Mendapatkan nilai Volume
 *
 * @param[in] handle Handle indikator Volume
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @return Nilai Volume pada candle yang dimaksud
 */
double GetVolumeValue(int handle, int shift = 0)
{
    double volumeValue[1];
    if (CopyBuffer(handle, 0, shift, 1, volumeValue) <= 0)
    {
        Print("Failed to get Volume value: ", GetLastError());
        return 0;
    }
    return volumeValue[0];
}
/**
 * @brief Mendapatkan harga pembukaan candle
 *
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @param[in] timeframe Timeframe yang akan diperiksa (default = timeframe saat ini)
 * @return Harga pembukaan candle yang dimaksud
 */
double GetCandleOpen(int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return iOpen(symbol, timeframe, shift);
}
/**
 * @brief Mendapatkan harga terendah candle
 *
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @param[in] timeframe Timeframe yang akan diperiksa (default = timeframe saat ini)
 * @return Harga terendah candle yang dimaksud
 */
double GetCandleLow(int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return iLow(symbol, timeframe, shift);
}
/**
 * @brief Mendapatkan harga tertinggi candle
 *
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @param[in] timeframe Timeframe yang akan diperiksa (default = timeframe saat ini)
 * @return Harga tertinggi candle yang dimaksud
 */
double GetCandleHigh(int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return iHigh(symbol, timeframe, shift);
}
/**
 * @brief Mendapatkan harga penutupan candle
 *
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @param[in] timeframe Timeframe yang akan diperiksa (default = timeframe saat ini)
 * @return Harga penutupan candle yang dimaksud
 */
double GetCandleClose(int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return iClose(symbol, timeframe, shift);
}
/**
 * @brief Mendapatkan waktu candle
 *
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @param[in] timeframe Timeframe yang akan diperiksa (default = timeframe saat ini)
 * @return Waktu candle yang dimaksud
 */
datetime GetCandleTime(int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return iTime(symbol, timeframe, shift);
}
/**
 * @brief Mendapatkan volume candle
 *
 * @param[in] shift Pergeseran candle (0 = candle saat ini)
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @param[in] timeframe Timeframe yang akan diperiksa (default = timeframe saat ini)
 * @return Volume candle yang dimaksud
 */
long GetCandleVolume(int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return iVolume(symbol, timeframe, shift);
}
/**
 * @brief Mendapatkan jumlah digit desimal untuk simbol tertentu
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Jumlah digit desimal untuk simbol tersebut
 */
int GetCandleDigits(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
}
/**
 * @brief Mendapatkan nilai point untuk simbol tertentu
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Nilai point untuk simbol tersebut
 */
double GetCandlePoint(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoDouble(symbol, SYMBOL_POINT);
}
/**
 * @brief Mendapatkan ukuran tick untuk simbol tertentu
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Ukuran tick untuk simbol tersebut
 */
double GetCandleTickSize(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
}
/**
 * @brief Mendapatkan waktu saat ini
 *
 * @return Waktu saat ini dalam format datetime
 */
datetime GetCandleTimeCurrent()
{
    return TimeCurrent();
}
/**
 * @brief Mendapatkan jam dari waktu tertentu
 *
 * @param[in] time Waktu yang akan diperiksa (default = waktu saat ini)
 * @return Jam dari waktu yang dimaksud
 */
int GetCandleTimeHours(datetime time = 0)
{
    if (time == 0)
        time = TimeCurrent();
    MqlDateTime dt;
    TimeToStruct(time, dt);
    return dt.hour;
}
/**
 * @brief Mendapatkan menit dari waktu tertentu
 *
 * @param[in] time Waktu yang akan diperiksa (default = waktu saat ini)
 * @return Menit dari waktu yang dimaksud
 */
int GetCandleTimeMinutes(datetime time = 0)
{
    if (time == 0)
        time = TimeCurrent();
    MqlDateTime dt;
    TimeToStruct(time, dt);
    return dt.min;
}
/**
 * @brief Mendapatkan detik dari waktu tertentu
 *
 * @param[in] time Waktu yang akan diperiksa (default = waktu saat ini)
 * @return Detik dari waktu yang dimaksud
 */
int GetCandleTimeSeconds(datetime time = 0)
{
    if (time == 0)
        time = TimeCurrent();
    MqlDateTime dt;
    TimeToStruct(time, dt);
    return dt.sec;
}
/**
 * @brief Mendapatkan harga bid saat ini
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Harga bid saat ini
 */
double GetCandleBid(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoDouble(symbol, SYMBOL_BID);
}
/**
 * @brief Mendapatkan harga ask saat ini
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Harga ask saat ini
 */
double GetCandleAsk(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoDouble(symbol, SYMBOL_ASK);
}
/**
 * @brief Mendapatkan spread (selisih harga jual dan harga beli) candle saat ini
 *
 * @param[in] symbol Simbol yang ingin diambil sprednya. Jika tidak disebutkan maka
 *                    akan menggunakan simbol saat ini.
 * @return Spred candle saat ini.
 */
long GetCandleSpread(string symbol = NULL)
{
    if (symbol == NULL)
        symbol = _Symbol; // Menggunakan simbol saat ini jika tidak ditentukan
    return SymbolInfoInteger(symbol, SYMBOL_SPREAD);
}
/**
 *@brief Periksa apakah harga pembukaan candle saat ini berada di atas harga yang diberikan.
 *
 *@param[in] price Harga yang ingin dicek.
 *@param[in] shift Pergeseran candle untuk memeriksa.
 *@param[in] simbol Simbol yang akan diperiksa (default pada simbol saat ini).
 *@param[in] jangka waktu Jangka waktu yang akan diperiksa (default pada jangka waktu saat ini).
 *@return Benar jika harga pembukaan candle berada di atas harga yang diberikan, salah jika sebaliknya.
 */
bool IsCandleOpenAbove(double price, int shift = 0, string symbol = NULL, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT)
{
    return GetCandleOpen(shift, symbol, timeframe) > price;
}