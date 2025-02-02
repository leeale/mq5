#include "SymbolHandler.mqh";
// Tambahkan struct untuk menyimpan status signal
struct SignalStatus
{
    bool isSignalActive; // Status signal aktif/tidak
    datetime signalTime; // Waktu terjadinya signal
    string signalType;
    double signalPrice;  // Harga saat signal terjadi
    string signalSource; // Sumber signal (MA/BB dan indexnya)
};
struct ManualSignalConfig
{
    Indikator_Type_Manual indType;
    Indikator_Type_Manual_Signal signalType;
    int total;
    int periods[];
    ENUM_TIMEFRAMES timeframes[];
    string symbol; // Symbol untuk mode manual
    bool isActive; // Status aktif/tidak
};

struct SMAConfig
{
    string label;
    ENUM_ON_OFF active;
    ENUM_MA_SIGNAL_TYPE type;
    ENUM_ACTIVE_DISABLE buy;
    ENUM_ACTIVE_DISABLE sell;
    ENUM_TIMEFRAMES timeframe;
    int periode;
    int shift;
    ENUM_MA_METHOD method;
    ENUM_APPLIED_PRICE price;
    int handle;
    double currentValue;
    double previousValue;
    string symbol; // Symbol untuk indikator
};
struct BBConfig
{
    string label;
    ENUM_ON_OFF active;
    ENUM_BB_SIGNAL_TYPE type;
    ENUM_ACTIVE_DISABLE buy;
    ENUM_ACTIVE_DISABLE sell;
    ENUM_TIMEFRAMES timeframe;
    int periode;
    int shift;
    double deviation;
    ENUM_APPLIED_PRICE price;
    int handle;
    double UpperCurrentValue;
    double UpperPreviousValue;
    double LowerCurrentValue;
    double LowerPreviousValue;
    string symbol; // Symbol untuk indikator
};

class C_Handler_Indikator : public CSymbolHandler
{
private:
    // string m_symbol; // Tambahkan member variable

    bool m_initialized;      // Status inisialisasi
    int m_totalMA;           // Total indikator MA
    SMAConfig m_maConfigs[]; // Array untuk menyimpan konfigurasi MA
    int m_totalBB;           // Total indikator BB
    BBConfig m_bbConfigs[];  // Array untuk menyimpan konfigurasi BB
    ManualSignalConfig m_manualConfig;
    bool m_isManualMode;
    string m_symbol;       // Symbol default
    datetime m_lastUpdate; // Waktu update terakhir global
    int m_lastError;       // Error code terakhir
    bool m_isUpdating;     // Flag untuk mencegah concurrent update

public:
    C_Handler_Indikator();
    ~C_Handler_Indikator();
    bool Initialize(int totalMA, int totalBB);
    bool SetMAConfig(const int index,
                     const string label,
                     const ENUM_ON_OFF active,
                     const ENUM_MA_SIGNAL_TYPE type,
                     const ENUM_ACTIVE_DISABLE buy,
                     const ENUM_ACTIVE_DISABLE sell,
                     const ENUM_TIMEFRAMES timeframe,
                     const int periode,
                     const int shift,
                     const ENUM_MA_METHOD method,
                     const ENUM_APPLIED_PRICE price);
    bool SetBBConfig(const int index,
                     const string label,
                     const ENUM_ON_OFF active,
                     const ENUM_BB_SIGNAL_TYPE type,
                     const ENUM_ACTIVE_DISABLE buy,
                     const ENUM_ACTIVE_DISABLE sell,
                     const ENUM_TIMEFRAMES timeframe,
                     const int periode,
                     const int shift,
                     const double deviation,
                     const ENUM_APPLIED_PRICE price);

    bool CreateIndicatorsMA(const string symbol);
    bool CreateIndicatorsBB(const string symbol);

    bool UpdateMAValues();
    bool UpdateBBValues();
    bool GetMAValues(const int index, double &currentValue, double &previousValue);
    bool GetBBValues(const int index, double &upperCurrent, double &upperPrevious, double &lowerCurrent, double &lowerPrevious);
    bool GetMAConfig(const int index, SMAConfig &config);
    bool GetBBConfig(const int index, BBConfig &config);

    // mode manual
    bool InitializeManualSignal(const Indikator_Type_Manual indType,
                                const Indikator_Type_Manual_Signal signalType,
                                const int total,
                                const string periods,
                                const string timeframes);

    bool CreateManualIndicators(const string symbol);
    bool GetMASignal(const int index, const string symbol, bool &signal);
    bool GetBBSignal(const int index, const string symbol, bool &signal);

    bool GetIndividualMASignal(const int index, const string symbol, bool &signal);
    bool GetIndividualBBSignal(const int index, const string symbol, bool &signal);

    bool GetManualSignal(bool &signal, string symbol);

private:
    void ReleaseIndicators();
};

C_Handler_Indikator::C_Handler_Indikator() : CSymbolHandler()
{
    m_totalMA = 0;
    m_totalBB = 0;
    m_initialized = false;
    ArrayResize(m_maConfigs, 0);
    ArrayResize(m_bbConfigs, 0);
}

C_Handler_Indikator::~C_Handler_Indikator()
{
    ArrayFree(m_maConfigs);
    ArrayFree(m_bbConfigs);
    ReleaseIndicators();
}

// Set konfigurasi untuk MA spesifik
bool C_Handler_Indikator::SetMAConfig(const int index,
                                      const string label,
                                      const ENUM_ON_OFF active,
                                      const ENUM_MA_SIGNAL_TYPE type,
                                      const ENUM_ACTIVE_DISABLE buy,
                                      const ENUM_ACTIVE_DISABLE sell,
                                      const ENUM_TIMEFRAMES timeframe,
                                      const int periode,
                                      const int shift,
                                      const ENUM_MA_METHOD method,
                                      const ENUM_APPLIED_PRICE price)

{
    if (index < 0 || index >= m_totalMA)
        return false;

    m_maConfigs[index].label = label;
    m_maConfigs[index].active = active;
    m_maConfigs[index].type = type;
    m_maConfigs[index].buy = buy;
    m_maConfigs[index].sell = sell;
    m_maConfigs[index].timeframe = timeframe;
    m_maConfigs[index].periode = periode;
    m_maConfigs[index].shift = shift;
    m_maConfigs[index].method = method;
    m_maConfigs[index].price = price;
    m_maConfigs[index].handle = INVALID_HANDLE;

    return true;
}
bool C_Handler_Indikator::SetBBConfig(const int index,
                                      const string label,
                                      const ENUM_ON_OFF active,
                                      const ENUM_BB_SIGNAL_TYPE type,
                                      const ENUM_ACTIVE_DISABLE buy,
                                      const ENUM_ACTIVE_DISABLE sell,
                                      const ENUM_TIMEFRAMES timeframe,
                                      const int periode,
                                      const int shift,
                                      const double deviation,
                                      const ENUM_APPLIED_PRICE price)

{
    if (index < 0 || index >= m_totalBB)
        return false;

    m_bbConfigs[index].label = label;
    m_bbConfigs[index].active = active;
    m_bbConfigs[index].type = type;
    m_bbConfigs[index].buy = buy;
    m_bbConfigs[index].sell = sell;
    m_bbConfigs[index].timeframe = timeframe;
    m_bbConfigs[index].periode = periode;
    m_bbConfigs[index].shift = shift;
    m_bbConfigs[index].deviation = deviation;
    m_bbConfigs[index].price = price;
    m_bbConfigs[index].handle = INVALID_HANDLE;

    return true;
}

// Create semua indicator handles
bool C_Handler_Indikator::CreateIndicatorsMA(const string symbol)
{
    if (!m_initialized)
    {
        Print("Error: Indicator handler not initialized");
        return false;
    }

    // Release existing handles first to prevent memory leaks
    ReleaseIndicators();

    // Count active MAs
    int activeCount = 0;
    for (int i = 0; i < m_totalMA; i++)
    {
        if (m_maConfigs[i].active == ON)
            activeCount++;
    }

    if (activeCount == 0)
    {
        Print("Warning: No active MA configurations found");
        return true; // Not necessarily an error
    }

    // Create temporary array for active configurations
    SMAConfig tempConfigs[];
    if (!ArrayResize(tempConfigs, activeCount))
    {
        Print("Error: Failed to allocate memory for temporary configurations");
        return false;
    }

    // Copy active configurations and create handles
    int activeIndex = 0;
    for (int i = 0; i < m_totalMA; i++)
    {
        if (m_maConfigs[i].active == ON)
        {
            tempConfigs[activeIndex] = m_maConfigs[i];

            // Create new MA handle
            tempConfigs[activeIndex].handle = iMA(symbol,
                                                  tempConfigs[activeIndex].timeframe,
                                                  tempConfigs[activeIndex].periode,
                                                  tempConfigs[activeIndex].shift,
                                                  tempConfigs[activeIndex].method,
                                                  tempConfigs[activeIndex].price);

            if (tempConfigs[activeIndex].handle == INVALID_HANDLE)
            {
                string errorMsg = StringFormat("Failed to create MA handle for %s (Period: %d, Timeframe: %s)",
                                               tempConfigs[activeIndex].label,
                                               tempConfigs[activeIndex].periode,
                                               EnumToString(tempConfigs[activeIndex].timeframe));
                Print(errorMsg);

                // Cleanup already created handles
                for (int j = 0; j < activeIndex; j++)
                {
                    if (tempConfigs[j].handle != INVALID_HANDLE)
                        IndicatorRelease(tempConfigs[j].handle);
                }
                return false;
            }

            activeIndex++;
        }
    }

    // Update main array with active configurations
    m_totalMA = activeCount;
    if (!ArrayResize(m_maConfigs, m_totalMA))
    {
        Print("Error: Failed to resize main configuration array");
        // Cleanup temporary handles
        for (int i = 0; i < activeCount; i++)
        {
            if (tempConfigs[i].handle != INVALID_HANDLE)
                IndicatorRelease(tempConfigs[i].handle);
        }
        return false;
    }

    // Copy configurations
    for (int i = 0; i < m_totalMA; i++)
    {
        m_maConfigs[i] = tempConfigs[i];
    }

    Print("Successfully created ", m_totalMA, " MA indicators");
    return true;
}

bool C_Handler_Indikator::CreateIndicatorsBB(const string symbol)
{
    if (!m_initialized)
    {
        Print("Error: Indicator handler not initialized");
        return false;
    }

    // Release existing handles first to prevent memory leaks
    ReleaseIndicators();

    // Count active BBs
    int activeCount = 0;
    for (int i = 0; i < m_totalBB; i++)
    {
        if (m_bbConfigs[i].active == ON)
            activeCount++;
    }

    if (activeCount == 0)
    {
        Print("Warning: No active BB configurations found");
        return true; // Not necessarily an error
    }

    // Create temporary array for active configurations
    BBConfig tempConfigs[];
    if (!ArrayResize(tempConfigs, activeCount))
    {
        Print("Error: Failed to allocate memory for temporary configurations");
        return false;
    }
    // Copy active configurations and create handles
    int activeIndex = 0;
    for (int i = 0; i < m_totalBB; i++)
    {
        if (m_bbConfigs[i].active == ON)
        {
            tempConfigs[activeIndex] = m_bbConfigs[i];

            // Create new BB handle
            tempConfigs[activeIndex].handle = iBands(symbol,
                                                     tempConfigs[activeIndex].timeframe,
                                                     tempConfigs[activeIndex].periode,
                                                     tempConfigs[activeIndex].shift,
                                                     tempConfigs[activeIndex].deviation,
                                                     tempConfigs[activeIndex].price);

            if (tempConfigs[activeIndex].handle == INVALID_HANDLE)
            {
                string errorMsg = StringFormat("Failed to create BB handle for %s (Period: %d, Timeframe: %s)",
                                               tempConfigs[activeIndex].label,
                                               tempConfigs[activeIndex].periode,
                                               EnumToString(tempConfigs[activeIndex].timeframe));
                Print(errorMsg);

                // Cleanup already created handles
                for (int j = 0; j < activeIndex; j++)
                {
                    if (tempConfigs[j].handle != INVALID_HANDLE)
                        IndicatorRelease(tempConfigs[j].handle);
                }
            }
            activeIndex++;
        }
    }

    // Update main array with active configurations
    m_totalBB = activeCount;
    if (!ArrayResize(m_bbConfigs, m_totalBB))
    {
        Print("Error: Failed to resize main configuration array");
        // Cleanup temporary handles
        for (int i = 0; i < activeCount; i++)
        {
            if (tempConfigs[i].handle != INVALID_HANDLE)
                IndicatorRelease(tempConfigs[i].handle);
        }
        return false;
    }

    // Copy configurations
    for (int i = 0; i < m_totalBB; i++)
    {
        m_bbConfigs[i] = tempConfigs[i];
    }

    Print("Successfully created ", m_totalBB, " BB indicators");
    return true;
}
// Initialize handler dengan jumlah MA yang diinginkan
bool C_Handler_Indikator::Initialize(int totalMA, int totalBB)
{
    if (totalMA <= 0 || totalBB <= 0)
        return false;

    m_totalMA = totalMA;

    if (!ArrayResize(m_maConfigs, m_totalMA))
        return false;

    for (int i = 0; i < m_totalMA; i++)
    {
        m_maConfigs[i].handle = INVALID_HANDLE;
        m_maConfigs[i].currentValue = 0.0;
        m_maConfigs[i].previousValue = 0.0;
        m_maConfigs[i].active = OFF;
    }
    m_totalBB = totalBB;

    if (!ArrayResize(m_bbConfigs, m_totalBB))
        return false;

    for (int i = 0; i < m_totalBB; i++)
    {
        m_bbConfigs[i].handle = INVALID_HANDLE;
        m_bbConfigs[i].UpperCurrentValue = 0.0;
        m_bbConfigs[i].LowerCurrentValue = 0.0;
        m_bbConfigs[i].UpperPreviousValue = 0.0;
        m_bbConfigs[i].LowerPreviousValue = 0.0;
        m_bbConfigs[i].active = OFF;
    }

    m_initialized = true;
    return true;
}

// Release semua indicator handles
void C_Handler_Indikator::ReleaseIndicators()
{
    for (int i = 0; i < ArraySize(m_maConfigs); i++)
    {

        if (m_maConfigs[i].handle != INVALID_HANDLE)
        {
            IndicatorRelease(m_maConfigs[i].handle);
            m_maConfigs[i].handle = INVALID_HANDLE;
        }
    }
    for (int i = 0; i < ArraySize(m_bbConfigs); i++)
    {

        if (m_bbConfigs[i].handle != INVALID_HANDLE)
        {
            IndicatorRelease(m_bbConfigs[i].handle);
            m_bbConfigs[i].handle = INVALID_HANDLE;
        }
    }
}
bool C_Handler_Indikator::UpdateBBValues()
{
    if (!m_initialized)
        return false;

    for (int i = 0; i < m_totalBB; i++)
    {

        double upperBuffer[];
        double lowerBuffer[];
        ArraySetAsSeries(upperBuffer, true);
        ArraySetAsSeries(lowerBuffer, true);

        if (CopyBuffer(m_bbConfigs[i].handle, 1, 0, 2, upperBuffer) != 2)
        {
            Print("Failed to copy BB upper buffer for ", m_bbConfigs[i].label);
            return false;
        }

        if (CopyBuffer(m_bbConfigs[i].handle, 2, 0, 2, lowerBuffer) != 2)
        {
            Print("Failed to copy BB lower buffer for ", m_bbConfigs[i].label);
            return false;
        }

        // Current = index 0, Previous = index 1
        m_bbConfigs[i].UpperCurrentValue = upperBuffer[0];
        m_bbConfigs[i].UpperPreviousValue = upperBuffer[1];

        m_bbConfigs[i].LowerCurrentValue = lowerBuffer[0];
        m_bbConfigs[i].LowerPreviousValue = lowerBuffer[1];
    }
    return true;
}

bool C_Handler_Indikator::GetBBValues(const int index, double &upperCurrent, double &upperPrevious, double &lowerCurrent, double &lowerPrevious)
{
    if (index < 0 || index >= m_totalBB)
        return false;

    upperCurrent = m_bbConfigs[index].UpperCurrentValue;
    upperPrevious = m_bbConfigs[index].UpperPreviousValue;
    lowerCurrent = m_bbConfigs[index].LowerCurrentValue;
    lowerPrevious = m_bbConfigs[index].LowerPreviousValue;
    return true;
}

bool C_Handler_Indikator::UpdateMAValues()
{
    if (!m_initialized)
        return false;

    for (int i = 0; i < m_totalMA; i++)
    {

        double buffer[];
        ArraySetAsSeries(buffer, true);

        if (CopyBuffer(m_maConfigs[i].handle, 0, 0, 2, buffer) != 2)
        {
            Print("Failed to copy MA buffer for ", m_maConfigs[i].label);
            return false;
        }

        m_maConfigs[i].currentValue = buffer[0];
        m_maConfigs[i].previousValue = buffer[1];
    }
    return true;
}

bool C_Handler_Indikator::GetMAValues(const int index, double &currentValue, double &previousValue)
{
    if (index < 0 || index >= m_totalMA)
        return false;

    currentValue = m_maConfigs[index].currentValue;
    previousValue = m_maConfigs[index].previousValue;
    return true;
}

bool C_Handler_Indikator::GetMAConfig(const int index, SMAConfig &config)
{
    if (index < 0 || index >= m_totalMA)
        return false;

    config = m_maConfigs[index];
    return true;
}

bool C_Handler_Indikator::GetBBConfig(const int index, BBConfig &config)
{
    if (index < 0 || index >= m_totalBB)
        return false;

    config = m_bbConfigs[index];
    return true;
}

// mode manual
bool C_Handler_Indikator::InitializeManualSignal(const Indikator_Type_Manual indType,
                                                 const Indikator_Type_Manual_Signal signalType,
                                                 const int total,
                                                 const string periods,
                                                 const string timeframes)
{
    m_manualConfig.indType = indType;
    m_manualConfig.signalType = signalType;
    m_manualConfig.total = total;

    // Parse periods string
    string periodStr[];
    StringSplit(periods, ',', periodStr);
    if (ArraySize(periodStr) != total)
        return false;

    ArrayResize(m_manualConfig.periods, total);
    for (int i = 0; i < total; i++)
    {
        m_manualConfig.periods[i] = (int)StringToInteger(periodStr[i]);
    }

    // Parse timeframes string
    string tfStr[];
    StringSplit(timeframes, ',', tfStr);
    if (ArraySize(tfStr) != total)
        return false;

    ArrayResize(m_manualConfig.timeframes, total);
    for (int i = 0; i < total; i++)
    {

        m_manualConfig.timeframes[i] = ConvertStringToTimeframe(tfStr[i]);
    }

    m_isManualMode = true;
    return true;
}
bool C_Handler_Indikator::CreateManualIndicators(const string symbol)
{
    if (i_signal_manual == OFF)
        return true; // Return true karena ini bukan error, hanya tidak aktif
                     //  m_symbol = symbol; // Set symbol saat create

    switch (i_signal_manual_type)
    {
    case IND_MOVING_AVERAGE:
        m_totalMA = i_siganl_manual_total;
        ArrayResize(m_maConfigs, m_totalMA);

        for (int i = 0; i < m_totalMA; i++)
        {
            if (!SetMAConfig(i,
                             "Manual MA " + IntegerToString(i),
                             ON,
                             i_signal_manual_type_MA,
                             ACTIVE,
                             ACTIVE,
                             m_manualConfig.timeframes[i],
                             m_manualConfig.periods[i],
                             0,
                             MODE_SMA,
                             PRICE_CLOSE))
                return false;
        }
        return CreateIndicatorsMA(symbol);

    case IND_BOLLINGER_BANDS:
        m_totalBB = i_siganl_manual_total;
        ArrayResize(m_bbConfigs, m_totalBB);

        for (int i = 0; i < m_totalBB; i++)
        {
            if (!SetBBConfig(i,
                             "Manual BB " + IntegerToString(i),
                             ON,
                             i_signal_manual_type_BB,
                             ACTIVE,
                             ACTIVE,
                             m_manualConfig.timeframes[i],
                             m_manualConfig.periods[i],
                             0,
                             2.0,
                             PRICE_CLOSE))
                return false;
        }
        return CreateIndicatorsBB(symbol);

    default:
        return false;
    }
}

// Implementasi helper methods
bool C_Handler_Indikator::GetMASignal(const int index, const string symbol, bool &signal)
{
    double current, previous;
    if (!GetMAValues(index, current, previous))
        return false;

    double currentClose = iClose(symbol, m_maConfigs[index].timeframe, 0);
    double previousClose = iClose(symbol, m_maConfigs[index].timeframe, 1);

    switch (m_maConfigs[index].type)
    {
    case ENUM_MA_SIGNAL_TYPE::UP_DOWN:
        signal = (current > previous);
        break;
    case ENUM_MA_SIGNAL_TYPE::UP_DOWN_REVERSE:
        signal = (current < previous);
        break;
    case ENUM_MA_SIGNAL_TYPE::CROSS_UP:
        signal = (previousClose <= previous && currentClose > current);
        break;
    case ENUM_MA_SIGNAL_TYPE::CROSS_DOWN:
        signal = (previousClose >= previous && currentClose < current);
        break;
    default:
        return false;
    }

    return true;
}

bool C_Handler_Indikator::GetBBSignal(const int index, const string symbol, bool &signal)
{
    double upperCurrent, upperPrevious;
    double lowerCurrent, lowerPrevious;
    if (!GetBBValues(index, upperCurrent, upperPrevious, lowerCurrent, lowerPrevious))
        return false;

    double currentClose = iClose(symbol, m_bbConfigs[index].timeframe, 0);
    double previousClose = iClose(symbol, m_bbConfigs[index].timeframe, 1);

    switch (m_bbConfigs[index].type)
    {
    case ENUM_BB_SIGNAL_TYPE::UP_DOWN:
        signal = (upperCurrent > upperPrevious && lowerCurrent > lowerPrevious);
        break;
    case ENUM_BB_SIGNAL_TYPE::UP_DOWN_REVERSE:
        signal = (upperCurrent < upperPrevious && lowerCurrent < lowerPrevious);
        break;
    case ENUM_BB_SIGNAL_TYPE::CROSS_UP:
        signal = (previousClose <= upperPrevious && currentClose > upperCurrent);
        break;
    case ENUM_BB_SIGNAL_TYPE::CROSS_DOWN:
        signal = (previousClose >= lowerPrevious && currentClose < lowerCurrent);
        break;
    default:
        return false;
    }

    return true;
}

bool C_Handler_Indikator::GetIndividualMASignal(const int index, const string symbol, bool &signal)
{
    if (index < 0 || index >= m_totalMA)
        return false;

    if (!UpdateMAValues())
        return false;

    return GetMASignal(index, symbol, signal);
}

bool C_Handler_Indikator::GetIndividualBBSignal(const int index, const string symbol, bool &signal)
{
    if (index < 0 || index >= m_totalBB)
        return false;

    if (!UpdateBBValues())
        return false;

    return GetBBSignal(index, symbol, signal);
}
bool C_Handler_Indikator::GetManualSignal(bool &signal, string symbol)
{
    if (i_signal_manual == OFF)
    {
        signal = false;
        return true;
    }

    switch (i_signal_manual_type)
    {
    case IND_MOVING_AVERAGE:
    {
        if (!UpdateMAValues())
            return false;

        bool allSignalsMA = true;
        for (int i = 0; i < m_totalMA; i++)
        {
            bool localSignal;
            if (!GetMASignal(i, symbol, localSignal))
                return false;

            if (i_combi_signal == AND)
                allSignalsMA &= localSignal;
            else
                allSignalsMA |= localSignal;
        }

        signal = allSignalsMA;
        return true;
    }

    case IND_BOLLINGER_BANDS:
    {
        if (!UpdateBBValues())
            return false;

        bool allSignalsBB = true;
        for (int i = 0; i < m_totalBB; i++)
        {
            bool localSignal;
            if (!GetBBSignal(i, symbol, localSignal))
                return false;

            if (i_combi_signal == AND)
                allSignalsBB &= localSignal;
            else
                allSignalsBB |= localSignal;
        }

        signal = allSignalsBB;
        return true;
    }

    default:
        return false;
    }
}