//+------------------------------------------------------------------+
//| file_name.mq4.mq4
//| Copyright 2017, Author Name
//| Link
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

struct handle
{
    int ma[];
    int rsi[];
    int macd[];
    int bb[];
};

struct data
{

    double ma[];
    double bbupper[];
    double bblower[];
};

data g_data;
handle g_handle;
string g_symbol[];

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    int t = SymbolsTotal(true);

    ArrayResize(g_handle.rsi, t);
    ArrayResize(g_handle.macd, t);
    ArrayResize(g_handle.ma, t);
    ArrayResize(g_handle.bb, t);

    ArrayResize(g_symbol, t);

    ArraySetAsSeries(g_data.ma, true);
    ArraySetAsSeries(g_data.bbupper, true);
    ArraySetAsSeries(g_data.bblower, true);

    for (int i = 0; i < t; i++)
    {
        g_handle.ma[i] = INVALID_HANDLE;
        g_handle.bb[i] = INVALID_HANDLE;
        g_handle.rsi[i] = INVALID_HANDLE;
        g_handle.macd[i] = INVALID_HANDLE;

        g_symbol[i] = SymbolName(i, true);
    }
    EventSetTimer(5);

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    int t = SymbolsTotal(true);
    for (int i = 0; i < t; i++)
    {
        if (g_handle.ma[i] != INVALID_HANDLE)
        {
            IndicatorRelease(g_handle.ma[i]);
        }
        EventKillTimer();
    }
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
    int t = SymbolsTotal(true);

    for (int i = 0; i < t; i++)
    {
        if (g_handle.ma[i] == INVALID_HANDLE)
        {
            g_handle.ma[i] = iMA(g_symbol[i], PERIOD_D1, 1, 0, 0, 0);
            Print(g_symbol[i], "created ma handle");
            continue;
        }

        if (CopyIndicatorBuffer(g_symbol[i], g_handle.ma[i], MA, g_data.ma))
        {
            // Print(g_symbol[i], "copied ma buffer", g_data.ma[0]);
            Print(g_symbol[i], "copied ma buffer 2 ", g_data.ma[3]);
        }
    }
}
enum ENUM_INDICATOR_TYPE
{

    MA,
    RSI,
    MACD,
    BB
};

//+------------------------------------------------------------------+
//| Function to copy indicator buffer                                |
//+------------------------------------------------------------------+
bool CopyIndicatorBuffer(string symbol, int handle, ENUM_INDICATOR_TYPE indType, double &buffer[])
{
    // Mengatur array sebagai time series
    ArraySetAsSeries(buffer, true);

    int bufferIndex = 0;
    int copyCount = 0;

    // Menentukan jumlah data yang akan disalin berdasarkan tipe indikator
    switch (indType)
    {
    case MA:
        bufferIndex = 0;
        copyCount = 10;
        break;
    case RSI:
        bufferIndex = 0;
        copyCount = 14;
        break;
    case MACD:
        bufferIndex = 0;
        copyCount = 20;
        break;
    case BB:
        bufferIndex = 0;
        copyCount = 20;
        break;
    }

    // Mengubah ukuran array sesuai dengan jumlah data yang akan disalin
    ArrayResize(buffer, copyCount);

    // Menyalin data indikator ke dalam array
    int copied = CopyBuffer(handle, bufferIndex, 0, copyCount, buffer);

    // Mengembalikan true jika proses penyalinan berhasil
    return (copied == copyCount);
}

//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
}
//+------------------------------------------------------------------+