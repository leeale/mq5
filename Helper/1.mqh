
#property strict
/**
 *@brief Mengambil nilai Moving Average (MA) untuk candle tertentu.
 *
 *Fungsi ini menghitung nilai MA menggunakan parameter yang ditentukan. Jika
 *asalkan pegangannya 0, pegangan baru dibuat menggunakan simbol yang ditentukan,
 *jangka waktu, periode MA, metode MA, dan harga yang diterapkan. Fungsi mengembalikan 0
 *jika pegangannya tidak valid atau jika data tidak dapat diambil.
 *
 *@param[in] handle Indikator handle untuk MA. Jika 0, indikator baru akan dibuat.
 *@param[in] Simbol Simbol yang memerlukan nilai MA. Defaultnya adalah simbol saat ini.
 *@param[in] tf Jangka waktu yang akan digunakan. Defaultnya adalah jangka waktu saat ini.
 *@param[in] maPeriod Periode perhitungan MA. Defaultnya adalah 14.
 *@param[in] shift Pergeseran candle (0 berarti candle saat ini).
 *@param[in] maMethod Metode rata-rata bergerak. Defaultnya adalah rata-rata pergerakan sederhana (MODE_SMA).
 *@param[in] applyPrice Jenis harga yang akan digunakan dalam perhitungan. Defaultnya adalah harga penutupan (PRICE_CLOSE).
 *@return Nilai MA untuk candle yang ditentukan. Mengembalikan 0 jika pegangan tidak valid atau pengambilan data gagal.
 */

double GetMAValue(int handle = 0, string Symbol = NULL,
                  ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
                  int maPeriod = 14,
                  int shift = 0,
                  ENUM_MA_METHOD maMethod = MODE_SMA,
                  ENUM_APPLIED_PRICE appliedPrice = PRICE_CLOSE)
{
    // jika handle 0 string symbol wajib di isi
    if (Symbol == NULL)
        Symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iMA(Symbol, tf, maPeriod, shift, maMethod, appliedPrice);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle GetMAValue()");
        return 0;
    }

    double maValue[1];
    if (CopyBuffer(handle, 0, shift, 1, maValue) <= 0)
    {
        Print("Failed to get MA value: ", GetLastError());
        return 0;
    }
    return maValue[0];
}
double GetBBValues(
    double &upper,
    double &lower,
    int handle = 0,
    string Symbol = NULL,
    ENUM_TIMEFRAMES tf = PERIOD_CURRENT,
    int bbPeriod = 20,
    double bbDeviation = 2.0,
    int shift = 0,
    ENUM_APPLIED_PRICE appliedPrice = PRICE_CLOSE)
{

    // jika handle 0 string symbol wajib di isi
    if (Symbol == NULL)
        Symbol = _Symbol;
    if (handle == 0)
    {
        handle = INVALID_HANDLE;
        handle = iBands(Symbol, tf, bbPeriod, shift, bbDeviation, appliedPrice);
    }
    if (handle == INVALID_HANDLE)
    {
        Print("Invalid handle GetBBValues()");
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
    return true;
}