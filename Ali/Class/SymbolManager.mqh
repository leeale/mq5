#include "../Input.mqh"
#include "../Helper/_FungsiHelper.mqh"

class CSymbolManager
{
private:
    string m_symbols[];            // Array untuk menyimpan simbol
    int m_totalSymbols;            // Jumlah total simbol
    bool m_isInitialized;          // Flag status inisialisasi
    ENUM_SYMBOL_TYPE m_symbolType; // Tipe simbol
    ENUM_TRADING_DIRECTION m_direction;
    string m_customSymbols;         // Daftar simbol kustom
    ENUM_SYMBOL_BASE m_baseSymbols; // Simbol base untuk korelasi
    ENUM_BASE_DIRECTION m_baseDirection;

public:
    CSymbolManager(void);
    ~CSymbolManager(void);
    void Setinitialize(void);
    bool Initialize(void);
    int GetTotalSymbols(void) const;
    // Getter
    string GetSymbol(int index) const;
    ENUM_SYMBOL_TYPE GetTypeSymbol() const;
    ENUM_TRADING_DIRECTION GetTradingDirection() const;
    string GetCustomSymbols() const;
    ENUM_SYMBOL_BASE GetBaseSymbol() const;
    ENUM_BASE_DIRECTION GetBaseDirection() const;
    // seetter
    void setTypeSymbol(ENUM_SYMBOL_TYPE symbolType);
    void setTradingDirection(ENUM_TRADING_DIRECTION tradingDirection);
    void SetCustomSymbols(string symbols);
    void setBaseSymbols(ENUM_SYMBOL_BASE baseSymbols);
    void setBaseDirection(ENUM_BASE_DIRECTION baseDirection);

private:
    bool InitializeAllSymbols(void);
    bool InitializeBaseSymbols(void);
    bool InitializeCustomSymbols(void);
    bool InitializeCurrentSymbol(void);
    bool IsCorrelatedSymbol(const string symbol, const string baseSymbol) const;
};

CSymbolManager::CSymbolManager(void)
{
    m_totalSymbols = 0;
    m_isInitialized = false;
    m_symbolType = SYMBOL_CURRENT;
    m_baseSymbols = USD;
    m_customSymbols = "";
}

CSymbolManager::~CSymbolManager(void)
{
    if (m_isInitialized)
    {
        ArrayFree(m_symbols);
    }
}

bool CSymbolManager::Initialize()
{
    if (m_isInitialized)
        return true;
    ArrayFree(m_symbols);
    m_totalSymbols = 0;

    setTypeSymbol(i_symbolType);
    setTradingDirection(i_symbolDirection);
    SetCustomSymbols(i_symbolCustom);
    setBaseSymbols(i_symbolBase);
    setBaseDirection(i_symbolBaseDirection);

    switch (m_symbolType)
    {
    case SYMBOL_ALL:
        return InitializeAllSymbols();
    case ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM:
        return InitializeCustomSymbols();
    case SYMBOL_CURRENT:
        return InitializeCurrentSymbol();
    case SYMBOL_BASE:
        return InitializeBaseSymbols();
    default:
        return false;
    }
}
// void CSymbolManager::Setinitialize()
// {
//     // Cleanup
//     ArrayFree(m_symbols);
//     m_totalSymbols = 0;
//     // setTypeSymbol(i_symbolType);
//     // setBaseSymbols(i_symbolBase);
//     // SetCustomSymbols(i_symbolCustom);
//     // setTradingDirection(i_symbolDirection);
//     // Force reinitialize
//     m_isInitialized = false;
// }
void CSymbolManager::setTypeSymbol(const ENUM_SYMBOL_TYPE symbolType)
{
    m_symbolType = symbolType;
    m_isInitialized = false;
}
void CSymbolManager::SetCustomSymbols(const string symbols)
{
    m_customSymbols = symbols;
    m_isInitialized = false;
}
void CSymbolManager::setBaseDirection(const ENUM_BASE_DIRECTION baseDirection)
{
    m_baseDirection = baseDirection;
    m_isInitialized = false;
}
void CSymbolManager::setBaseSymbols(const ENUM_SYMBOL_BASE baseSymbols)
{
    m_baseSymbols = baseSymbols;
    m_isInitialized = false;
}
void CSymbolManager::setTradingDirection(const ENUM_TRADING_DIRECTION tradingDirection)
{
    m_direction = tradingDirection;
    m_isInitialized = false;
}

bool CSymbolManager::InitializeAllSymbols()
{
    m_totalSymbols = SymbolsTotal(true);
    if (m_totalSymbols <= 0)
        return false;

    if (ArrayResize(m_symbols, m_totalSymbols) != m_totalSymbols)
    {
        Print("Failed to allocate memory for symbols");
        return false;
    }

    for (int i = 0; i < m_totalSymbols; i++)
    {
        m_symbols[i] = SymbolName(i, true);
    }
    Print("Total Symbols: ", m_totalSymbols);
    m_isInitialized = true;
    return true;
}
bool CSymbolManager::InitializeBaseSymbols()
{
    // First count correlated symbols
    int tempTotal = SymbolsTotal(true);
    m_totalSymbols = 0;
    string symbolbase = GetBaseSymbolString(i_symbolBase);

    // First pass: count valid symbols
    for (int i = 0; i < tempTotal; i++)
    {
        string symbol = SymbolName(i, true);
        if (IsCorrelatedSymbol(symbol, symbolbase))
        {
            m_totalSymbols++;
        }
    }

    if (m_totalSymbols <= 0)
    {
        Print("No correlated symbols found for base symbol: ", m_baseSymbols);
        return false;
    }

    // Resize array for actual symbols
    if (ArrayResize(m_symbols, m_totalSymbols) != m_totalSymbols)
    {
        Print("Failed to allocate memory for base symbols");
        return false;
    }

    // Second pass: store correlated symbols
    int index = 0;
    for (int i = 0; i < tempTotal; i++)
    {
        string symbol = SymbolName(i, true);
        if (IsCorrelatedSymbol(symbol, symbolbase))
        {
            m_symbols[index] = symbol;
            if (!SymbolSelect(m_symbols[index], true))
            {
                Print("Failed to select symbol: ", m_symbols[index]);
                return false;
            }
            index++;
        }
    }

    m_isInitialized = true;
    return true;
}

bool CSymbolManager::InitializeCustomSymbols()
{
    if (m_customSymbols == "")
    {
        m_customSymbols = "EURUSD,GBPUSD,USDJPY"; // Default symbols
    }

    string tempSymbols[];
    StringSplit(m_customSymbols, ',', tempSymbols);
    m_totalSymbols = ArraySize(tempSymbols);

    if (m_totalSymbols <= 0)
        return false;

    if (ArrayResize(m_symbols, m_totalSymbols) != m_totalSymbols)
    {
        Print("Failed to allocate memory for custom symbols");
        return false;
    }

    for (int i = 0; i < m_totalSymbols; i++)
    {
        m_symbols[i] = tempSymbols[i];
        // Verify symbol exists
        if (!SymbolSelect(m_symbols[i], true))
        {
            Print("Symbol not found: ", m_symbols[i]);
            return false;
        }
    }

    m_isInitialized = true;
    return true;
}

bool CSymbolManager::InitializeCurrentSymbol()
{
    m_totalSymbols = 1;
    if (ArrayResize(m_symbols, m_totalSymbols) != m_totalSymbols)
    {
        Print("Failed to allocate memory for current symbol");
        return false;
    }

    m_symbols[0] = _Symbol;
    m_isInitialized = true;
    return true;
}

// Getter methods
int CSymbolManager::GetTotalSymbols() const
{
    return m_totalSymbols;
}
string CSymbolManager::GetSymbol(const int index) const
{
    // if (!m_isInitialized && !Initialize())
    // {
    //     return "";
    // }

    if (index >= 0 && index < m_totalSymbols)
    {
        return m_symbols[index];
    }
    return "";
}

bool CSymbolManager::IsCorrelatedSymbol(const string symbol, const string baseSymbol) const
{
    // Base symbol is always correlated with itself
    if (symbol == baseSymbol)
        return true;

    // Get the first three characters (currency)
    string baseCurrency = StringSubstr(baseSymbol, 0, 3);
    string quoteCurrency = StringSubstr(baseSymbol, 3, 3);

    // Check if symbol contains either currency from base pair
    string symbolBase = StringSubstr(symbol, 0, 3);
    string symbolQuote = StringSubstr(symbol, 3, 3);

    return (symbolBase == baseCurrency || symbolBase == quoteCurrency ||
            symbolQuote == baseCurrency || symbolQuote == quoteCurrency);
}

ENUM_SYMBOL_TYPE CSymbolManager::GetTypeSymbol() const
{
    return m_symbolType;
}
ENUM_TRADING_DIRECTION CSymbolManager::GetTradingDirection() const
{
    return m_direction;
}
string CSymbolManager::GetCustomSymbols() const
{
    return m_customSymbols;
}
ENUM_SYMBOL_BASE CSymbolManager::GetBaseSymbol() const
{
    return m_baseSymbols;
}
ENUM_BASE_DIRECTION CSymbolManager::GetBaseDirection() const
{
    return m_baseDirection;
}
