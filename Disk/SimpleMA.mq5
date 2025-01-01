#include <Trade/Trade.mqh>
CTrade trade;

input string symbolsString = "EURUSD,GBPUSD"; // String simbol yang akan diperdagangkan
input int maPeriod = 14;                      // Periode Moving Average
input double lotSize = 0.1;                   // Ukuran lot
input double takeProfit = 50;                 // Take profit dalam poin
input double stopLoss = 50;                   // Stop loss dalam poin
input int bbPeriod = 20;                      // Periode Bollinger Bands
input double bbDeviation = 2.0;               // Deviasi Bollinger Bands

string symbols[]; // Variabel global untuk menyimpan simbol yang dipisahkan

int maHandle;         // Handle untuk Moving Average
int bbHandle;         // Handle untuk Bollinger Bands
double maBuffer[];    // Buffer untuk menyimpan nilai MA
double bbUpper[];     // Buffer untuk menyimpan nilai upper band
double bbLower[];     // Buffer untuk menyimpan nilai lower band
double closePrices[]; // Buffer untuk menyimpan harga penutupan

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    // Memisahkan string simbol menjadi array
    StringSplit(symbolsString, ',', symbols);

    // Inisialisasi EA untuk setiap simbol
    for (int i = 0; i < ArraySize(symbols); i++)
    {
        maHandle = iMA(symbols[i], 0, maPeriod, 0, MODE_SMA, PRICE_CLOSE);
        bbHandle = iBands(symbols[i], 0, bbPeriod, 0, bbDeviation, PRICE_CLOSE);

        if (maHandle == INVALID_HANDLE || bbHandle == INVALID_HANDLE)
        {
            Print("Failed to create handles for ", symbols[i], ": ", GetLastError());
            return INIT_FAILED;
        }
    }
    Print("Simple MA EA Initialized for multiple symbols");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    // Cleanup code here
    for (int i = 0; i < ArraySize(symbols); i++)
    {
        IndicatorRelease(maHandle); // Lepaskan handle indikator MA
        IndicatorRelease(bbHandle); // Lepaskan handle indikator BB
    }
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    for (int i = 0; i < ArraySize(symbols); i++)
    {
        // Menghitung Moving Average
        if (CopyBuffer(maHandle, 0, 0, 2, maBuffer) < 0)
        {
            Print("Failed to copy buffer for MA ", symbols[i], ": ", GetLastError());
            return;
        }

        // Menghitung Bollinger Bands
        if (CopyBuffer(bbHandle, 0, 0, 2, bbUpper) < 0 || CopyBuffer(bbHandle, 1, 0, 2, bbLower) < 0)
        {
            Print("Failed to copy buffer for Bollinger Bands ", symbols[i], ": ", GetLastError());
            return;
        }

        // Validasi data MA
        if (ArraySize(maBuffer) < 2 || maBuffer[0] == 0 || maBuffer[1] == 0)
        {
            Print("Invalid MA data for ", symbols[i]);
            continue; // Lewati simbol ini jika data tidak valid
        }

        // Mengambil harga penutupan
        if (CopyClose(symbols[i], 0, 0, 2, closePrices) < 0)
        {
            Print("Failed to copy close prices for ", symbols[i], ": ", GetLastError());
            return;
        }

        double maCurrent = maBuffer[0];  // MA saat ini
        double maPrevious = maBuffer[1]; // MA sebelumnya

        // Cek apakah ada posisi terbuka
        if (PositionsTotal() == 0)
        {
            // Sinyal Sell
            if (closePrices[1] > bbUpper[1] && closePrices[0] > bbUpper[0])
            {
                double price = SymbolInfoDouble(symbols[i], SYMBOL_BID);
                double sl = price + stopLoss * _Point;
                double tp = price - takeProfit * _Point;
                if (!trade.Sell(lotSize, symbols[i], price, sl, tp, "Bollinger Band Sell"))
                {
                    Print("Error opening sell order for ", symbols[i], ": ", GetLastError());
                }
            }
            // Sinyal Buy
            else if (closePrices[1] < bbLower[1] && closePrices[0] < bbLower[0])
            {
                double price = SymbolInfoDouble(symbols[i], SYMBOL_ASK);
                double sl = price - stopLoss * _Point;
                double tp = price + takeProfit * _Point;
                if (!trade.Buy(lotSize, symbols[i], price, sl, tp, "Bollinger Band Buy"))
                {
                    Print("Error opening buy order for ", symbols[i], ": ", GetLastError());
                }
            }
        }
    }
}
//+------------------------------------------------------------------+
