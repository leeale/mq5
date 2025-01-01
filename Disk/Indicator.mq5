#property strict

#include <Indicators/Indicators.mqh>
#include <Indicators/Indicator.mqh>

// Deklarasi indikator yang akan digunakan
CiMA MA; // Moving Average
CiMA MA2;
CiRSI RSI; // RSI

int OnInit()
{
    // Inisialisasi Moving Average
    if (!MA.Create(_Symbol, PERIOD_CURRENT, 14, 0, MODE_SMA, PRICE_CLOSE))
    {
        Print("Error membuat indikator MA");
        return INIT_FAILED;
    }
    if (!MA2.Create(_Symbol, PERIOD_CURRENT, 1, 0, MODE_SMA, PRICE_CLOSE))
    {
        Print("Error membuat indikator MA");
        return INIT_FAILED;
    }

    // Inisialisasi RSI
    if (!RSI.Create(_Symbol, PERIOD_CURRENT, 14, PRICE_CLOSE))
    {
        Print("Error membuat indikator RSI");
        return INIT_FAILED;
    }
    EventSetTimer(1);
    return INIT_SUCCEEDED;
}

void OnTimer2()
{
    // Update nilai indikator
    MA.Refresh();
    MA2.Refresh();
    RSI.Refresh();

    // Ambil nilai indikator
    double maValue = MA.Main(0);   // Nilai MA saat ini
    double maValue2 = MA2.Main(0); // Nilai MA saat ini
    double rsiValue = RSI.Main(0); // Nilai RSI saat ini

    // Contoh logika trading sederhana
    if (rsiValue < 30)
    { // Kondisi oversold
        Print("RSI menunjukkan kondisi oversold: ", rsiValue);
    }

    if (maValue2 > maValue)
    { // Harga di atas MA
        Print("Harga di atas MA: ", maValue);
    }
    Print("RSI: ", rsiValue);
    Print("MA: ", maValue);
    Print("MA2: ", maValue2);
}

void OnDeinit(const int reason)
{
    MA.FullRelease();
    MA2.FullRelease();
    RSI.FullRelease();
}