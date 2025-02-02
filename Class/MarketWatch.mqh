class CMarketWatch
{
private:
    bool m_initialized;
    string m_symbols[];
    int m_totalSymbols;

    struct MarketData
    {
        string symbol;

        int digits;
        int stopLevel;
        double bid;
        double ask;
        double point;
        double spread;
        double tickValue;
        double tickSize;
        double swapLong;
        double swapShort;
        double minVolume;
        double volumeStep;
        double maxVolume;
        double priceChange;
        double lastHigh;
        double lastLow;
        double askHigh;
        double askLow;
        double bidHigh;
        double bidLow;
        double sessionOpen;
        double sessionClose;
    } m_marketData[];

    // Helper methods
    bool ValidateSymbol(const string symbol);
    void InitializeSymbols();

public:
    CMarketWatch();
    ~CMarketWatch();
    void UpdateMarketData(const int index);

    // Initialization
    bool Initialize();
    void Deinitialize();

    // Getters
    string GetSymbol(const int index) const;
    int GetTotalSymbols() const { return m_totalSymbols; }
    int GetStopLevel(const string symbol) const;
    double GetBid(const string symbol) const;
    double GetAsk(const string symbol) const;
    double GetSpread(const string symbol) const;
    int GetDigits(const string symbol) const;
    double GetPoint(const string symbol) const;
    double GetTickValue(const string symbol) const;
    double GetTickSize(const string symbol) const;
    double GetSwapLong(const string symbol) const;
    double GetSwapShort(const string symbol) const;
    double GetMinVolume(const string symbol) const;
    double GetVolumeStep(const string symbol) const;
    double GetMaxVolume(const string symbol) const;
    double GetPriceChange(const string symbol) const;
    double GetLastHigh(const string symbol) const;
    double GetLastLow(const string symbol) const;
    double GetAskHigh(const string symbol) const;
    double GetAskLow(const string symbol) const;
    double GetBidHigh(const string symbol) const;
    double GetBidLow(const string symbol) const;
    double GetSessionOpen(const string symbol) const;
    double GetSessionClose(const string symbol) const;

    // Market Data Operations
    bool RefreshMarketData();
    bool IsSymbolValid(const string symbol) const;
    bool IsSymbolTradeAllowed(const string symbol) const;
    MarketData GetMarketData(const string symbol) const;

    // Symbol Management
    bool AddSymbol(const string symbol);
    bool RemoveSymbol(const string symbol);
    void ClearSymbols();
};

//+------------------------------------------------------------------+
//| Constructor                                                        |
//+------------------------------------------------------------------+
CMarketWatch::CMarketWatch()
{
    m_initialized = false;
    m_totalSymbols = 0;
}

//+------------------------------------------------------------------+
//| Destructor                                                         |
//+------------------------------------------------------------------+
CMarketWatch::~CMarketWatch()
{
    Deinitialize();
}

//+------------------------------------------------------------------+
//| Initialize the MarketWatch                                         |
//+------------------------------------------------------------------+
bool CMarketWatch::Initialize()
{
    if (m_initialized)
        return true;

    InitializeSymbols();
    if (!RefreshMarketData())
        return false;

    m_initialized = true;
    return true;
}

//+------------------------------------------------------------------+
//| Deinitialize the MarketWatch                                      |
//+------------------------------------------------------------------+
void CMarketWatch::Deinitialize()
{
    ClearSymbols();
    m_initialized = false;
}

//+------------------------------------------------------------------+
//| Initialize symbols array                                           |
//+------------------------------------------------------------------+
void CMarketWatch::InitializeSymbols()
{
    m_totalSymbols = SymbolsTotal(true);
    ArrayResize(m_symbols, m_totalSymbols);
    ArrayResize(m_marketData, m_totalSymbols);

    for (int i = 0; i < m_totalSymbols; i++)
    {
        m_symbols[i] = SymbolName(i, true);
        UpdateMarketData(i);
    }
}

//+------------------------------------------------------------------+
//| Update market data for specific symbol index                       |
//+------------------------------------------------------------------+
void CMarketWatch::UpdateMarketData(const int index)
{
    if (index >= m_totalSymbols)
        return;

    string symbol = m_symbols[index];
    m_marketData[index].symbol = symbol;
    m_marketData[index].bid = SymbolInfoDouble(symbol, SYMBOL_BID);
    m_marketData[index].ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
    m_marketData[index].point = SymbolInfoDouble(symbol, SYMBOL_POINT);
    m_marketData[index].digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    m_marketData[index].spread = (double)SymbolInfoInteger(symbol, SYMBOL_SPREAD);
    m_marketData[index].tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
    m_marketData[index].tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
    m_marketData[index].swapLong = SymbolInfoDouble(symbol, SYMBOL_SWAP_LONG);
    m_marketData[index].swapShort = SymbolInfoDouble(symbol, SYMBOL_SWAP_SHORT);
    m_marketData[index].stopLevel = (int)SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL);
    m_marketData[index].minVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
    m_marketData[index].volumeStep = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);
    m_marketData[index].maxVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
    m_marketData[index].priceChange = SymbolInfoDouble(symbol, SYMBOL_PRICE_CHANGE);
    m_marketData[index].lastHigh = SymbolInfoDouble(symbol, SYMBOL_LASTHIGH);
    m_marketData[index].lastLow = SymbolInfoDouble(symbol, SYMBOL_LASTLOW);
    m_marketData[index].askHigh = SymbolInfoDouble(symbol, SYMBOL_ASKHIGH);
    m_marketData[index].askLow = SymbolInfoDouble(symbol, SYMBOL_ASKLOW);
    m_marketData[index].bidHigh = SymbolInfoDouble(symbol, SYMBOL_BIDHIGH);
    m_marketData[index].bidLow = SymbolInfoDouble(symbol, SYMBOL_BIDLOW);
    // session open
    m_marketData[index].sessionOpen = SymbolInfoDouble(symbol, SYMBOL_SESSION_OPEN);
    // session close
    m_marketData[index].sessionClose = SymbolInfoDouble(symbol, SYMBOL_SESSION_CLOSE);
}

//+------------------------------------------------------------------+
//| Refresh all market data                                           |
//+------------------------------------------------------------------+
bool CMarketWatch::RefreshMarketData()
{
    if (!m_initialized)
        return false;

    for (int i = 0; i < m_totalSymbols; i++)
    {
        UpdateMarketData(i);
    }
    return true;
}
//+------------------------------------------------------------------+
//| Get symbol by index |
//+------------------------------------------------------------------+
string CMarketWatch::GetSymbol(const int index) const
{
    if (index >= m_totalSymbols || index < 0)
        return "";
    return m_symbols[index];
}

//+------------------------------------------------------------------+
//| Get bid price for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetBid(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].bid;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get ask price for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetAsk(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].ask;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get spread for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetSpread(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].spread;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get digits for symbol |
//+------------------------------------------------------------------+
int CMarketWatch::GetDigits(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].digits;
    }
    return 0;
}
int CMarketWatch::GetStopLevel(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].stopLevel;
    }
    return 0;
}

//+------------------------------------------------------------------+
//| Get point value for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetPoint(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].point;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get tick value for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetTickValue(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].tickValue;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get tick size for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetTickSize(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].tickSize;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get swap long for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetSwapLong(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].swapLong;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Get swap short for symbol |
//+------------------------------------------------------------------+
double CMarketWatch::GetSwapShort(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].swapShort;
    }
    return 0.0;
}
double CMarketWatch::GetMinVolume(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].minVolume;
    }
    return 0.0;
}
double CMarketWatch::GetVolumeStep(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].volumeStep;
    }
    return 0.0;
}
double CMarketWatch::GetMaxVolume(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].maxVolume;
    }
    return 0.0;
}

double CMarketWatch::GetPriceChange(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].priceChange;
    }
    return 0.0;
}
// get last high
double CMarketWatch::GetLastHigh(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].lastHigh;
    }
    return 0.0;
}
double CMarketWatch::GetLastLow(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].lastLow;
    }
    return 0.0;
}
double CMarketWatch::GetAskHigh(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].askHigh;
    }
    return 0.0;
}

double CMarketWatch::GetAskLow(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].askLow;
    }
    return 0.0;
}
double CMarketWatch::GetBidHigh(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].bidHigh;
    }
    return 0.0;
}
double CMarketWatch::GetBidLow(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].bidLow;
    }
    return 0.0;
}
double CMarketWatch::GetSessionOpen(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].sessionOpen;
    }
    return 0.0;
}
double CMarketWatch::GetSessionClose(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i].sessionClose;
    }
    return 0.0;
}

//+------------------------------------------------------------------+
//| Validate symbol |
//+------------------------------------------------------------------+
bool CMarketWatch::ValidateSymbol(const string symbol)
{
    return SymbolSelect(symbol, true);
}

//+------------------------------------------------------------------+
//| Check if symbol is valid |
//+------------------------------------------------------------------+
bool CMarketWatch::IsSymbolValid(const string symbol) const
{
    if (symbol == "")
        return false;

    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return true;
    }
    return false;
}

//+------------------------------------------------------------------+
//| Check if symbol trading is allowed |
//+------------------------------------------------------------------+
bool CMarketWatch::IsSymbolTradeAllowed(const string symbol) const
{
    if (!IsSymbolValid(symbol))
        return false;
    return (bool)SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE) != SYMBOL_TRADE_MODE_DISABLED;
}

//+------------------------------------------------------------------+
//| Get market data for symbol |
//+------------------------------------------------------------------+
CMarketWatch::MarketData CMarketWatch::GetMarketData(const string symbol) const
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
            return m_marketData[i];
    }

    MarketData emptyData;
    ZeroMemory(emptyData);
    return emptyData;
}

//+------------------------------------------------------------------+
//| Add new symbol to watch list |
//+------------------------------------------------------------------+
bool CMarketWatch::AddSymbol(const string symbol)
{
    if (!ValidateSymbol(symbol))
        return false;
    if (IsSymbolValid(symbol))
        return true;

    m_totalSymbols++;
    ArrayResize(m_symbols, m_totalSymbols);
    ArrayResize(m_marketData, m_totalSymbols);

    m_symbols[m_totalSymbols - 1] = symbol;
    UpdateMarketData(m_totalSymbols - 1);

    return true;
}

//+------------------------------------------------------------------+
//| Remove symbol from watch list |
//+------------------------------------------------------------------+
bool CMarketWatch::RemoveSymbol(const string symbol)
{
    for (int i = 0; i < m_totalSymbols; i++)
    {
        if (m_symbols[i] == symbol)
        {
            for (int j = i; j < m_totalSymbols - 1; j++)
            {
                m_symbols[j] = m_symbols[j + 1];
                m_marketData[j] = m_marketData[j + 1];
            }
            m_totalSymbols--;
            ArrayResize(m_symbols, m_totalSymbols);
            ArrayResize(m_marketData, m_totalSymbols);
            return true;
        }
    }
    return false;
}

//+------------------------------------------------------------------+
//| Clear all symbols |
//+------------------------------------------------------------------+
void CMarketWatch::ClearSymbols()
{
    m_totalSymbols = 0;
    ArrayFree(m_symbols);
    ArrayFree(m_marketData);
}