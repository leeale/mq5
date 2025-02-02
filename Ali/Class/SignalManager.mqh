#include "../Input.mqh"
#include "SymbolManager.mqh"

struct IndicatorInfo
{
    int handle;
    bool isActive;
    bool isBuy;
    bool isSell;
    ENUM_TIMEFRAMES timeframe;
    int signalType;
    double signal;
};

struct SymbolData
{
    string symbol;
    IndicatorInfo indicators[];
};

class CSignalManager
{
private:
    SymbolData symbolArray[];
    CSymbolManager *symbolManager;
    int totalSymbols;
    int totalHandles;
    bool isInitialized;
    ENUM_MODE_SIGNAL m_signalMode;
    int m_manualTotal;

private:
    void InitializeIndicatorArrays(const int symbolIndex);
    void CleanupInactiveHandles(const int symbolIndex);
    bool CreateIndicatorHandle(const int symbolIndex, const int handleIndex);
    void ReleaseIndicatorHandle(const int symbolIndex, const int handleIndex);
    void CleanupHandles();

public:
    CSignalManager(void);
    ~CSignalManager(void);

    bool Init(const ENUM_MODE_SIGNAL mode, const int manualTotal = 0);
    void InitHandles();
    void ConfigureSymbols(ENUM_SYMBOL_TYPE symbolType,
                          string customSymbols = "",
                          ENUM_SYMBOL_BASE baseSymbol = USD);

    // Getters
    int GetTotalHandles() const { return totalHandles; }
    int GetTotalSymbols() const { return totalSymbols; }
    bool IsIndicatorActive(const int symbolIndex, const int handleIndex) const;
};

CSignalManager::CSignalManager(void)
{
    totalSymbols = 0;
    totalHandles = 0;
    isInitialized = false;
    symbolManager = new CSymbolManager();
}

CSignalManager::~CSignalManager(void)
{
    if (symbolManager != NULL)
    {
        delete symbolManager;
    }
    CleanupHandles();
}

bool CSignalManager::Init(const ENUM_MODE_SIGNAL mode, const int manualTotal = 0)
{
    if (isInitialized)
        return true;

    m_signalMode = mode;
    m_manualTotal = manualTotal;
    totalHandles = (mode == MODE_SIGNAL_MANUAL) ? manualTotal : 11;

    if (!symbolManager.Initialize())
    {
        Print("Failed to initialize symbol manager");
        return false;
    }

    totalSymbols = symbolManager.GetTotalSymbols();
    if (totalSymbols <= 0)
    {
        Print("No symbols available");
        return false;
    }

    if (ArrayResize(symbolArray, totalSymbols) != totalSymbols)
    {
        Print("Failed to allocate memory for symbol array");
        return false;
    }

    for (int i = 0; i < totalSymbols; i++)
    {
        symbolArray[i].symbol = symbolManager.GetSymbol(i);
        InitializeIndicatorArrays(i);
    }

    isInitialized = true;
    return true;
}

void CSignalManager::ConfigureSymbols(ENUM_SYMBOL_TYPE symbolType,
                                      string customSymbols = "",
                                      ENUM_SYMBOL_BASE baseSymbol = USD)
{
    symbolManager.setTypeSymbol(symbolType);

    if (symbolType == ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM && customSymbols != "")
    {
        symbolManager.SetCustomSymbols(customSymbols);
    }
    else if (symbolType == SYMBOL_BASE)
    {
        symbolManager.setBaseSymbols(baseSymbol);
    }

    isInitialized = false;
}

void CSignalManager::InitHandles()
{
    if (!isInitialized && !Init(m_signalMode, m_manualTotal))
    {
        Print("Failed to initialize signal manager");
        return;
    }

    for (int i = 0; i < totalSymbols; i++)
    {
        if (m_signalMode == MODE_SIGNAL_MULTI)
        {
            CleanupInactiveHandles(i);
        }
    }

    Print("Handles initialized for ", totalSymbols, " symbols");
}

void CSignalManager::InitializeIndicatorArrays(const int symbolIndex)
{
    if (symbolIndex >= totalSymbols)
        return;

    ArrayResize(symbolArray[symbolIndex].indicators, totalHandles);

    for (int i = 0; i < totalHandles; i++)
    {
        symbolArray[symbolIndex].indicators[i].handle = INVALID_HANDLE;
        symbolArray[symbolIndex].indicators[i].isActive = false;
        symbolArray[symbolIndex].indicators[i].isBuy = true;
        symbolArray[symbolIndex].indicators[i].isSell = true;
        symbolArray[symbolIndex].indicators[i].timeframe = PERIOD_CURRENT;
        symbolArray[symbolIndex].indicators[i].signalType = 0;
        symbolArray[symbolIndex].indicators[i].signal = 0;

        if (m_signalMode == MODE_SIGNAL_MANUAL)
        {
            symbolArray[symbolIndex].indicators[i].isActive = true;
        }
    }
}

void CSignalManager::CleanupInactiveHandles(const int symbolIndex)
{
    for (int i = ArraySize(symbolArray[symbolIndex].indicators) - 1; i >= 0; i--)
    {
        if (!symbolArray[symbolIndex].indicators[i].isActive)
        {
            ReleaseIndicatorHandle(symbolIndex, i);
            ArrayRemove(symbolArray[symbolIndex].indicators, i, 1);
        }
    }
}

void CSignalManager::CleanupHandles()
{
    for (int i = 0; i < totalSymbols; i++)
    {
        for (int j = 0; j < ArraySize(symbolArray[i].indicators); j++)
        {
            if (symbolArray[i].indicators[j].handle != INVALID_HANDLE)
            {
                IndicatorRelease(symbolArray[i].indicators[j].handle);
            }
        }
    }
}

bool CSignalManager::IsIndicatorActive(const int symbolIndex, const int handleIndex) const
{
    if (symbolIndex >= totalSymbols)
        return false;
    if (handleIndex >= ArraySize(symbolArray[symbolIndex].indicators))
        return false;

    return symbolArray[symbolIndex].indicators[handleIndex].isActive;
}
bool CSignalManager::CreateIndicatorHandle(const int symbolIndex, const int handleIndex)
{
    // Validate indices
    if (symbolIndex >= totalSymbols || handleIndex >= totalHandles)
    {
        Print("Invalid indices for CreateIndicatorHandle: symbolIndex=", symbolIndex,
              " handleIndex=", handleIndex);
        return false;
    }

    string symbol = symbolArray[symbolIndex].symbol;
    IndicatorInfo &indicator = symbolArray[symbolIndex].indicators[handleIndex];

    // Release existing handle if any
    ReleaseIndicatorHandle(symbolIndex, handleIndex);

    // Create new handle based on indicator type
    switch (indicator.signalType)
    {
    case IND_MOVING_AVERAGE:
        indicator.handle = iMA(symbol,
                               indicator.timeframe,
                               ma1_periode, // From input parameters
                               ma1_shift,   // From input parameters
                               ma1_method,  // From input parameters
                               ma1_price);  // From input parameters
        break;

    case IND_BOLLINGER_BANDS:
        indicator.handle = iBands(symbol,
                                  indicator.timeframe,
                                  bb1_periode,   // From input parameters
                                  bb1_shift,     // From input parameters
                                  bb1_deviation, // From input parameters
                                  bb1_price);    // From input parameters
        break;

    default:
        Print("Unsupported indicator type: ", indicator.signalType);
        indicator.handle = INVALID_HANDLE;
        return false;
    }

    // Verify handle creation
    if (indicator.handle == INVALID_HANDLE)
    {
        Print("Failed to create indicator handle for symbol: ", symbol,
              " type: ", EnumToString((ENUM_INDICATOR_TYPE)indicator.signalType));
        return false;
    }

    return true;
}

void CSignalManager::ReleaseIndicatorHandle(const int symbolIndex, const int handleIndex)
{
    // Validate indices
    if (symbolIndex >= totalSymbols)
        return;
    if (handleIndex >= ArraySize(symbolArray[symbolIndex].indicators))
        return;

    // Get reference to indicator
    IndicatorInfo &indicator = symbolArray[symbolIndex].indicators[handleIndex];

    // Release handle if valid
    if (indicator.handle != INVALID_HANDLE)
    {
        if (!IndicatorRelease(indicator.handle))
        {
            Print("Warning: Failed to release indicator handle for symbol: ",
                  symbolArray[symbolIndex].symbol,
                  " handleIndex: ", handleIndex);
        }
        indicator.handle = INVALID_HANDLE;
    }
}