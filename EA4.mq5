#property strict
#include "EaHelper.mqh"
#include "EaInput1.mqh"

// variable global
// string g_Symbol[];
// int g_signal[2];
// int g_handlma1[2];

struct symbolInfo
{
    int index;
    string symbol;
    int signal;
    int handle1[];
};
// string g_Symbol[2];
int totalSymbol;
int number;
int totalhandle = 2;

symbolInfo g_symbolInfo[];

int OnInit()
{
    totalSymbol = SymbolsTotal(true);
    number = totalSymbol - totalSymbol;
    ArrayResize(g_symbolInfo, totalSymbol);
    for (int i = 0; i < totalSymbol; i++)
    {
        g_symbolInfo[i].signal = 0;
        g_symbolInfo[i].index = i;
        g_symbolInfo[i].symbol = GetSymbolName(i);
        ArrayResize(g_symbolInfo[i].handle1, totalhandle); // Resize untuk 2 handle MA per symbol
        for (int j = 0; j < totalhandle; j++)
        {
            g_symbolInfo[i].handle1[j] = INVALID_HANDLE;
        }
    }

    // inisialisasi handle
    // int count = ArraySize(g_handlma1);
    // for (int i = 0; i < count; i++)
    // {
    //     g_handlma1[i] = INVALID_HANDLE;
    // }
    // // inisialisasi signal
    // for (int i = 0; i < ArraySize(g_signal); i++)
    // {
    //     g_signal[i] = 0;
    //     if (debug)
    //         Print("g_signal index : ", i, " value : ", g_signal[i]);
    // }
    // inisialisasi symbol
    // g_Symbol = _Symbol;

    EventSetTimer(100);

    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    // for (int i = 0; i < ArraySize(g_handlma1); i++)
    // {
    //     ReleaseHandleMA(g_handlma1[i]);
    // }
    for (int i = 0; i < totalSymbol; i++)
    {
        for (int j = 0; j < totalhandle; j++)
        {
            ReleaseHandleMA(g_symbolInfo[i].handle1[j]);
            // Print("release handle : ", g_symbolInfo[i].handle1[j]);
        }
    }

    EventKillTimer();
}

void OnTick()
{
}
string GetSymbolName(int index, ENUM_SYMBOL_TYPE multisymbol)
{
    if (multisymbol == MULTI_SYMBOL)
    {
        return g_symbolInfo[index].symbol;
    }
    else if (multisymbol == SYMBOL_CURRENT)
    {
        return _Symbol;
    }
    else
    {
        return _Symbol;
    }
}

void OnTimer()
{
    int n;
    Loop(number, totalSymbol, n);

    string symbol = GetSymbolName(n, multi_symbol);

    bool isSignalMA1 = (IsIndikatorMa(ma1_active, ma1_buy, ma1_sell, symbol, PERIOD_CURRENT,
                                      ma1_periode1, ma1_shift1, ma1_method1, ma1_price1, ma1_periode2, ma1_shift2, ma1_method2, ma1_price2,
                                      ma1_signal_indikator1, ma1_signal_indikator2, ma1_type,
                                      ma1_buy, ma1_sell, 0, g_symbolInfo[n].handle1[0], g_symbolInfo[n].handle1[1]));
    bool order = ExecutionOrder(isSignalMA1, OR, g_symbolInfo[n].signal, symbol, 0.01, "Buy Signal", 0, 100);

    // bool isSignalMA2 = (IsIndikatorMa(ma2_active, ma2_buy, ma2_sell, g_Symbol, PERIOD_CURRENT,
    //                                 ma2_periode1, ma2_shift1, ma2_method1, ma2_price1, ma2_periode2, ma2_shift2, ma2_method2, ma2_price2,
    //                            ma2_signal_indikator1, ma2_signal_indikator2, ma2_type,
    //                       ma2_buy, ma2_sell, 1, g_handlma1));
    // if (isSignalMA1)
    // {
    //     if (g_signal[0] == 1)
    //     {
    //         Print("Buy Signal");
    //     }
    //     else
    //     {
    //         Print("sell Signal");
    //     }
    // }
    // Print("Signal : ", g_signal[0]);
    // number++;
}

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
}

// jika parameter variabel benar maka sinyal beli, jika salah maka sinyal jual
/**
 *@brief Memeriksa apakah indikator moving average (MA) aktif dan menghasilkan sinyal beli/jual berdasarkan parameter yang dikonfigurasi.
 *
 *Fungsi ini bertanggung jawab untuk menganalisis data pasar dan menentukan apakah sinyal beli atau jual harus dihasilkan berdasarkan indikator rata-rata bergerak. Dibutuhkan berbagai parameter yang terkait dengan indikator MA, kondisi pasar, dan kontrol sinyal, dan mengembalikan nilai boolean yang menunjukkan apakah suatu sinyal telah dihasilkan.
 *
 *@param active Menunjukkan apakah indikator MA aktif atau tidak.
 *@param buy Menunjukkan apakah sinyal beli aktif atau nonaktif.
 *@param sell Menunjukkan apakah sinyal jual aktif atau nonaktif.
 *@param simbol Simbol perdagangan untuk dianalisis.
 *@param timeframe Jangka waktu yang digunakan untuk analisis.
 *@param periode1 Periode MA pertama.
 *@param shift1 Pergeseran untuk MA pertama.
 *@param method1 Metode yang digunakan untuk MA pertama.
 *@param applyprice1 Jenis harga yang digunakan untuk MA pertama.
 *@param periode2 Periode MA kedua.
 *@param shift2 Pergeseran untuk MA kedua.
 *@param method2 Metode yang digunakan untuk MA kedua.
 *@param applyprice2 Jenis harga yang digunakan untuk MA kedua.
 *@param signal_indikator1 Indikator sinyal untuk MA pertama.
 *@param signal_indikator2 Indikator sinyal untuk MA kedua.
 *@param ma_type Jenis sinyal MA yang akan digunakan (silang atau atas/bawah).
 *@param handlema1 Pegangan untuk MA pertama.
 *@param handlema2 Pegangan untuk MA kedua.
 *@param mabuy Kontrol untuk sinyal beli.
 *@param masell Kontrol untuk sinyal jual.
 *@param gsignalindex Indeks sinyal yang akan diperbarui.
 *@return true jika sinyal dihasilkan, false jika tidak.
 */

struct Helper
{
    int index_helper;
};
void Loop(int &num, int &tot, int &n)
{
    num++;
    n = num - 1;
    if (num >= tot)
        num = 0;
}
bool ExecutionOrder(bool signalinfo, ENUM_STRATEGY_COMBINATION Or_and, int finalsignal, string symbol, double volume, string comment, double sl = 0, double tp = 0)
{
    if (PositionSelect(symbol))
    {
        return false;
    }
    Print("combisignal : ", combi_signal);
    if (signalinfo && combi_signal == Or_and && finalsignal != 0)
    {
        Print("or masuk");
        double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
        double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
        double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
        int digit = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
        if (finalsignal == 1)
        {
            // updata sl jika tida 0
            if (sl != 0)
            {
                sl = ask - (sl * point);
                sl = NormalizeDouble(sl, digit);
            }
            if (tp != 0)
            {
                tp = ask + (tp * point);
                tp = NormalizeDouble(tp, digit);
            }
            if (comment == "")
            {
                comment = "Buy Signal";
            }
            OpenMarketOrder(symbol, ORDER_TYPE_BUY, volume, sl, tp, comment);
        }
        else
        {
            if (sl != 0)
            {
                sl = bid + (sl * point);
                sl = NormalizeDouble(sl, digit);
            }
            if (tp != 0)
            {
                tp = bid - (tp * point);
                tp = NormalizeDouble(tp, digit);
            }
            if (comment == "")
            {
                comment = "Sell Signal";
            }
            OpenMarketOrder(symbol, ORDER_TYPE_SELL, volume, sl, tp, comment);
        }
    }
    return true;
}

struct Proses_Signal
{
    int index_signal;
};

bool IsIndikatorMa(
    // KELOMPOK 1: PARAMETER FILTER UTAMA
    ENUM_ON_OFF active,       // Status aktif indikator
    ENUM_ACTIVE_DISABLE buy,  // Status sinyal beli
    ENUM_ACTIVE_DISABLE sell, // Status sinyal jual
    // KELOMPOK 2: PARAMETER PASAR
    string symbol,             // Simbol trading
    ENUM_TIMEFRAMES timeframe, // Timeframe analisis
    // KELOMPOK 3: PARAMETER MA PERTAMA
    int periode1,                     // Periode MA1
    int shift1,                       // Shift MA1
    ENUM_MA_METHOD method1,           // Metode MA1
    ENUM_APPLIED_PRICE appliedprice1, // Tipe harga MA1
    // KELOMPOK 4: PARAMETER MA KEDUA
    int periode2,                     // Periode MA2
    int shift2,                       // Shift MA2
    ENUM_MA_METHOD method2,           // Metode MA2
    ENUM_APPLIED_PRICE appliedprice2, // Tipe harga MA2
    // KELOMPOK 5: PARAMETER SINYAL
    int signal_indikator1,       // Indikator sinyal 1
    int signal_indikator2,       // Indikator sinyal 2
    ENUM_MA_SIGNAL_TYPE ma_type, // Tipe sinyal MA
    // KELOMPOK 6: PARAMETER KONTROL SINYAL
    ENUM_ACTIVE_DISABLE mabuy,  // Kontrol beli
    ENUM_ACTIVE_DISABLE masell, // Kontrol jual
    int gsignalindex,           // Indeks sinyal yang akan diperbarui
    // KELOMPOK 7: HANDLE MA
    int &handle1,
    int &handle2) // Handle MA
{
    // jika status aktif indikator tidak valid dan status sinyal beli dan jual tidak valid, kembalikan false
    if (!IsFilterIndikator(active, buy, sell))
    {
        if (debug)
            Print("Status Tidak aktif | Beli tidak aktif | Jual tidak aktif");
        return false;
    }
    // Set nilai default untuk harga saat ini dan candle sebelumnya
    double currentPrice = 0;
    double CandlePrevieous = 0;
    double price1 = 0;
    double price2 = 0;

    // Dapatkan harga saat ini dan candle sebelumnya
    currentPrice = iClose(symbol, timeframe, 0);
    CandlePrevieous = iClose(symbol, timeframe, 1);

    // Variabel untuk menyimpan nilai MA1 dan MA2
    double PriceMa1[];
    double PriceMa2[];
    ArraySetAsSeries(PriceMa1, true);
    ArraySetAsSeries(PriceMa2, true);

    //---------------------------------- CEK MENGUNAKAN INDIKATOR MA1 ATAU CURRENT PRICE ----------------------------------
    // Jika sinyal indikator 1 adalah MOVING AVERAGE, periksa apakah MA1 ada dan salin nilai MA1 ke array PriceMa1
    if (signal_indikator1 == 0)
    {
        bool isHandleMA1 = IsHandle_MA(symbol, PERIOD_CURRENT, periode1, shift1, method1, appliedprice1, handle1);
        if (!isHandleMA1)
        {
            if (debug)
                Print("isHandleMA1 false error handle MA1 Index :", gsignalindex, GetLastError());
            return false;
        }

        if (CopyBuffer(handle1, 0, 0, 2, PriceMa1) != 2)
        {
            if (debug)
                Print("error copy buffer MA1 Index :", gsignalindex, GetLastError());
            return false;
        }
        price1 = PriceMa1[0];
    }
    else
    {
        // Jika sinyal indikator 1 adalah CURRENT PRICE, gunakan harga saat ini sebagai nilai MA1
        price1 = currentPrice;
    }
    //==================================== END CEK MENGUNAKAN INDIKATOR MA1 ATAU CURRENT PRICE ====================================

    //---------------------------------- CEK MENGUNAKAN INDIKATOR MA2 ----------------------------------
    // Jika sinyal indikator 2 adalah MOVING AVERAGE, periksa apakah MA2 ada dan salin nilai MA2 ke array PriceMa2
    if (signal_indikator2 == 0)
    {

        bool isHandleMA2 = IsHandle_MA(symbol, PERIOD_CURRENT, periode2, shift2, method2, appliedprice2, handle2);
        if (!isHandleMA2)
        {
            if (debug)
                Print("isHandleMA2 false error handle MA2 Index :", gsignalindex, GetLastError());
            return false;
        }
        if (CopyBuffer(handle2, 0, 0, 2, PriceMa2) != 2)
        {
            if (debug)
                Print("error copy buffer MA2 Index :", gsignalindex, GetLastError());
            return false;
        }
        price2 = PriceMa2[0];
    }

    if (price1 == 0 || price2 == 0)
    {
        if (debug)
        {
            Print("MA1 INDEX :", gsignalindex, price1, " MA2 INDEX :", gsignalindex, price2, " |Kosong");
        }
    }
    //================================= END CEK MENGUNAKAN INDIKATOR MA2 =================================

    //---------------------------------- CEK SINYAL BERDASARKAN TIPE SINYAL ----------------------------------
    // jika sinyal indkator adalah CROSS, periksa apakah MA2 ada dan salin nilai MA2 ke array PriceMa2
    if (ma_type == MA_SIGNAL_CROSS)
    {
        // Menggunakan data previous untuk mendeteksi crossing
        double ma1Current = PriceMa1[0];
        double ma1Previous = PriceMa1[1];
        double ma2Current = PriceMa2[0];
        double ma2Previous = PriceMa2[1];
        // Sinyal beli: MA1 melintasi di atas MA2
        if (ma1Previous < ma2Previous && ma1Current > ma2Current)
        {
            if (updateSignal(mabuy, gsignalindex))
            {
                return true;
            }
        }
        else if (ma1Previous > ma2Previous && ma1Current < ma2Current)
        {
            if (updateSignal(masell, gsignalindex, -1))
            {
                return true;
            }
        }
    }
    //
    else if (ma_type == MA_SIGNAL_UP_DOWN)
    {
        double ma1value1 = PriceMa1[0];
        double ma1value2 = PriceMa2[0];
        if (ma1value1 > ma1value2)
        {
            if (updateSignal(mabuy, gsignalindex))
            {
                return true;
            }
        }
        else if (ma1value1 < ma1value2)
        {
            if (updateSignal(masell, gsignalindex, -1))
            {
                return true;
            }
        }
    }
    else if (ma_type == MA_SIGNAL_UP_DOWN_CURRENTPRICE)
    {
        double ma1value1 = PriceMa1[0];
        double ma1value2 = PriceMa2[0];
        Print(ma1value1, " | ", ma1value2);
        if (ma1value1 > ma1value2)
        {
            if (currentPrice > ma1value1)
            {
                if (updateSignal(mabuy, gsignalindex))
                {
                    return true;
                }
            }
        }
        else if (ma1value1 < ma1value2)
        {
            if (currentPrice < ma1value1)
            {
                if (updateSignal(masell, gsignalindex, -1))
                {
                    return true;
                }
            }
        }
    }
    // =================================== END CEK SINYAL BERDASARKAN TIPE SINYAL ===================================\


    // g_signal[gsignalindex] = 0;
    return false;
}

/**
 * @brief Memperbarui nilai sinyal pada indeks i
 * @param buyorsell jika AKTIF, perbarui nilai sinyal, jika tidak, jangan lakukan apa pun
 * @param i mengindeks array sinyal yang akan diperbarui
 * @param signal nilai sinyal untuk menyetel sinyal, 1 untuk beli, -1 untuk jual, defaultnya adalah 1 sinyal beli
 * @return true jika nilai sinyal diperbarui, false jika tidak
 */
bool updateSignal(ENUM_ACTIVE_DISABLE buyorsell, int i, int signal = 1)
{
    if (buyorsell == ACTIVE)
    {
        g_symbolInfo[i].signal = (signal == 1) ? 1 : -1;
        return true;
    }
    return false;
}