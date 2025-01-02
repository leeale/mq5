/**
 * @brief Mendapatkan nilai Bollinger Bands (BB) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai BB menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, periode BB, deviasi, dan shift. Fungsi mengembalikan false
 * jika handle tidak valid atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk BB. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai BB. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] period Periode perhitungan BB. Defaultnya adalah 20.
 * @param[in] deviation Deviasi BB. Defaultnya adalah 2.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] upper Nilai upper band (referensi)
 * @param[out] middle Nilai middle band (referensi)
 * @param[out] lower Nilai lower band (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsBBValueValid(double &upper, double &middle, double &lower,
                    int handle = 0, string symbol = NULL,
                    ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                    int period = 20, double deviation = 2.0,
                    int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iBands(symbol, tf, period, 0, deviation, PRICE_CLOSE);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsBBValueValid()");
        return false;
    }

    double upperBand[1], middleBand[1], lowerBand[1];
    if (CopyBuffer(handle, 0, shift, 1, upperBand) <= 0 ||
        CopyBuffer(handle, 1, shift, 1, middleBand) <= 0 ||
        CopyBuffer(handle, 2, shift, 1, lowerBand) <= 0)
    {
        Print("Failed to get BB values: ", GetLastError());
        return false;
    }

    upper = upperBand[0];
    middle = middleBand[0];
    lower = lowerBand[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Commodity Channel Index (CCI) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai CCI menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan periode CCI. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk CCI. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai CCI. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] period Periode perhitungan CCI. Defaultnya adalah 14.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] cci Nilai CCI (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsCCIValueValid(double &cci, int handle = 0, string symbol = NULL,
                     ENUM_TIMEFRAMES tf = PERIOD_CURRENT, int period = 14,
                     int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iCCI(symbol, tf, period, PRICE_TYPICAL);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsCCIValueValid()");
        return false;
    }

    double cciValue[1];
    if (CopyBuffer(handle, 0, shift, 1, cciValue) <= 0)
    {
        Print("Failed to get CCI value: ", GetLastError());
        return false;
    }

    cci = cciValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai On Balance Volume (OBV) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai OBV menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan volume yang digunakan. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk OBV. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai OBV. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] applied_volume Jenis volume yang digunakan. Defaultnya adalah VOLUME_TICK.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] obv Nilai OBV (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsOBVValueValid(double &obv, int handle = 0, string symbol = NULL,
                     ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                     ENUM_APPLIED_VOLUME applied_volume = VOLUME_TICK,
                     int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iOBV(symbol, tf, applied_volume);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsOBVValueValid()");
        return false;
    }

    double obvValue[1];
    if (CopyBuffer(handle, 0, shift, 1, obvValue) <= 0)
    {
        Print("Failed to get OBV value: ", GetLastError());
        return false;
    }

    obv = obvValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Ichimoku Cloud untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai komponen Ichimoku Cloud menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan periode Ichimoku. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk Ichimoku. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai Ichimoku. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] tenkan_period Periode Tenkan-sen. Defaultnya adalah 9.
 * @param[in] kijun_period Periode Kijun-sen. Defaultnya adalah 26.
 * @param[in] senkou_period Periode Senkou Span B. Defaultnya adalah 52.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] tenkan Nilai Tenkan-sen (referensi)
 * @param[out] kijun Nilai Kijun-sen (referensi)
 * @param[out] senkouA Nilai Senkou Span A (referensi)
 * @param[out] senkouB Nilai Senkou Span B (referensi)
 * @param[out] chikou Nilai Chikou Span (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsIchimokuValueValid(double &tenkan, double &kijun, double &senkouA,
                          double &senkouB, double &chikou, int handle = 0,
                          string symbol = NULL, ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                          int tenkan_period = 9, int kijun_period = 26,
                          int senkou_period = 52, int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iIchimoku(symbol, tf, tenkan_period, kijun_period, senkou_period);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsIchimokuValueValid()");
        return false;
    }

    double tenkanValue[1], kijunValue[1], senkouAValue[1], senkouBValue[1], chikouValue[1];
    if (CopyBuffer(handle, 0, shift, 1, tenkanValue) <= 0 ||
        CopyBuffer(handle, 1, shift, 1, kijunValue) <= 0 ||
        CopyBuffer(handle, 2, shift, 1, senkouAValue) <= 0 ||
        CopyBuffer(handle, 3, shift, 1, senkouBValue) <= 0 ||
        CopyBuffer(handle, 4, shift, 1, chikouValue) <= 0)
    {
        Print("Failed to get Ichimoku values: ", GetLastError());
        return false;
    }

    tenkan = tenkanValue[0];
    kijun = kijunValue[0];
    senkouA = senkouAValue[0];
    senkouB = senkouBValue[0];
    chikou = chikouValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Average True Range (ATR) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai ATR menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan periode ATR. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk ATR. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai ATR. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] period Periode perhitungan ATR. Defaultnya adalah 14.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] atr Nilai ATR (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsATRValueValid(double &atr, int handle = 0, string symbol = NULL,
                     ENUM_TIMEFRAMES tf = PERIOD_CURRENT, int period = 14,
                     int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iATR(symbol, tf, period);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsATRValueValid()");
        return false;
    }

    double atrValue[1];
    if (CopyBuffer(handle, 0, shift, 1, atrValue) <= 0)
    {
        Print("Failed to get ATR value: ", GetLastError());
        return false;
    }

    atr = atrValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Average Directional Index (ADX) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai ADX menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan periode ADX. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk ADX. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai ADX. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] period Periode perhitungan ADX. Defaultnya adalah 14.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] adx Nilai ADX (referensi)
 * @param[out] plusDI Nilai +DI (referensi)
 * @param[out] minusDI Nilai -DI (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsADXValueValid(double &adx, double &plusDI, double &minusDI,
                     int handle = 0, string symbol = NULL,
                     ENUM_TIMEFRAMES tf = PERIOD_CURRENT, int period = 14,
                     int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iADX(symbol, tf, period);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsADXValueValid()");
        return false;
    }

    double adxValue[1], plusDIValue[1], minusDIValue[1];
    if (CopyBuffer(handle, 0, shift, 1, adxValue) <= 0 ||
        CopyBuffer(handle, 1, shift, 1, plusDIValue) <= 0 ||
        CopyBuffer(handle, 2, shift, 1, minusDIValue) <= 0)
    {
        Print("Failed to get ADX values: ", GetLastError());
        return false;
    }

    adx = adxValue[0];
    plusDI = plusDIValue[0];
    minusDI = minusDIValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Parabolic SAR untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai Parabolic SAR menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, step, dan maximum. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk Parabolic SAR. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai Parabolic SAR. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] step Nilai step. Defaultnya adalah 0.02.
 * @param[in] maximum Nilai maximum. Defaultnya adalah 0.2.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] sar Nilai Parabolic SAR (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsParabolicSARValueValid(double &sar, int handle = 0, string symbol = NULL,
                              ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                              double step = 0.02, double maximum = 0.2,
                              int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iSAR(symbol, tf, step, maximum);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsParabolicSARValueValid()");
        return false;
    }

    double sarValue[1];
    if (CopyBuffer(handle, 0, shift, 1, sarValue) <= 0)
    {
        Print("Failed to get Parabolic SAR value: ", GetLastError());
        return false;
    }

    sar = sarValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Relative Strength Index (RSI) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai RSI menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan periode RSI. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk RSI. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai RSI. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] period Periode perhitungan RSI. Defaultnya adalah 14.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] rsi Nilai RSI (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsRSIValueValid(double &rsi, int handle = 0, string symbol = NULL,
                     ENUM_TIMEFRAMES tf = PERIOD_CURRENT, int period = 14,
                     int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iRSI(symbol, tf, period, PRICE_CLOSE);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsRSIValueValid()");
        return false;
    }

    double rsiValue[1];
    if (CopyBuffer(handle, 0, shift, 1, rsiValue) <= 0)
    {
        Print("Failed to get RSI value: ", GetLastError());
        return false;
    }

    rsi = rsiValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Moving Average Convergence Divergence (MACD) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai MACD menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, periode fast EMA, periode slow EMA, dan periode signal SMA.
 * Fungsi mengembalikan false jika handle tidak valid atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk MACD. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai MACD. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] fast_period Periode fast EMA. Defaultnya adalah 12.
 * @param[in] slow_period Periode slow EMA. Defaultnya adalah 26.
 * @param[in] signal_period Periode signal SMA. Defaultnya adalah 9.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] macd Nilai MACD (referensi)
 * @param[out] signal Nilai signal line (referensi)
 * @param[out] histogram Nilai histogram (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsMACDValueValid(double &macd, double &signal, double &histogram,
                      int handle = 0, string symbol = NULL,
                      ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                      int fast_period = 12, int slow_period = 26,
                      int signal_period = 9, int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iMACD(symbol, tf, fast_period, slow_period, signal_period, PRICE_CLOSE);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsMACDValueValid()");
        return false;
    }

    double macdValue[1], signalValue[1], histogramValue[1];
    if (CopyBuffer(handle, 0, shift, 1, macdValue) <= 0 ||
        CopyBuffer(handle, 1, shift, 1, signalValue) <= 0 ||
        CopyBuffer(handle, 2, shift, 1, histogramValue) <= 0)
    {
        Print("Failed to get MACD values: ", GetLastError());
        return false;
    }

    macd = macdValue[0];
    signal = signalValue[0];
    histogram = histogramValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Simple Moving Average (SMA) untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai SMA menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, dan periode SMA. Fungsi mengembalikan false jika handle tidak valid
 * atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk SMA. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai SMA. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] period Periode perhitungan SMA. Defaultnya adalah 20.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] sma Nilai SMA (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsSMAValueValid(double &sma, int handle = 0, string symbol = NULL,
                     ENUM_TIMEFRAMES tf = PERIOD_CURRENT, int period = 20,
                     int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iMA(symbol, tf, period, 0, MODE_SMA, PRICE_CLOSE);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsSMAValueValid()");
        return false;
    }

    double smaValue[1];
    if (CopyBuffer(handle, 0, shift, 1, smaValue) <= 0)
    {
        Print("Failed to get SMA value: ", GetLastError());
        return false;
    }

    sma = smaValue[0];
    return true;
}

/**
 * @brief Mendapatkan nilai Stochastic Oscillator untuk candle tertentu.
 *
 * Fungsi ini menghitung nilai Stochastic menggunakan parameter yang ditentukan. Jika
 * handle 0, handle baru dibuat menggunakan simbol yang ditentukan,
 * jangka waktu, periode %K, periode %D, dan slowing. Fungsi mengembalikan false jika
 * handle tidak valid atau jika data tidak dapat diambil.
 *
 * @param[in] handle Indikator handle untuk Stochastic. Jika 0, indikator baru akan dibuat.
 * @param[in] symbol Simbol yang memerlukan nilai Stochastic. Defaultnya adalah simbol saat ini.
 * @param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 * @param[in] k_period Periode %K. Defaultnya adalah 5.
 * @param[in] d_period Periode %D. Defaultnya adalah 3.
 * @param[in] slowing Slowing. Defaultnya adalah 3.
 * @param[in] shift Pergeseran candle (0 berarti candle saat ini).
 * @param[out] main Nilai %K (referensi)
 * @param[out] signal Nilai %D (referensi)
 * @return bool True jika berhasil mendapatkan nilai, false jika gagal
 */
bool IsStochasticValueValid(double &main, double &signal, int handle = 0,
                            string symbol = NULL, ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                            int k_period = 5, int d_period = 3, int slowing = 3,
                            int shift = 0)
{
    if (symbol == NULL)
        symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iStochastic(symbol, tf, k_period, d_period, slowing, MODE_SMA, STO_LOWHIGH);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle IsStochasticValueValid()");
        return false;
    }

    double mainValue[1], signalValue[1];
    if (CopyBuffer(handle, 0, shift, 1, mainValue) <= 0 ||
        CopyBuffer(handle, 1, shift, 1, signalValue) <= 0)
    {
        Print("Failed to get Stochastic values: ", GetLastError());
        return false;
    }

    main = mainValue[0];
    signal = signalValue[0];
    return true;
}

bool IsReleaseHandle(int handle)
{
    if (handle != INVALID_HANDLE)
    {
        IndicatorRelease(handle);
        handle = INVALID_HANDLE;
        Print("Handle released");
        return true;
    }
    return false;
}
