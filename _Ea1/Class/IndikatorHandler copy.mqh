#include "SymbolHandler.mqh";

struct SMAConfig
{
    string label;
    ENUM_ON_OFF active;
    ENUM_SIGNAL_TYPE type;
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
};

class CIndikatorHandler : public CSymbolHandler
{
private:
    int m_totalMA;           // Total indikator MA
    bool m_initialized;      // Status inisialisasi
    SMAConfig m_maConfigs[]; // Array untuk menyimpan konfigurasi MA
    int m_activeHandlers[];  // Handler untuk MA yang aktif
public:
    CIndikatorHandler(/* args */);
    ~CIndikatorHandler();
    bool Initialize(int totalMA);
    bool SetMAConfig(const int index,
                     const string label,
                     const ENUM_ON_OFF active,
                     const ENUM_SIGNAL_TYPE type,
                     const ENUM_ACTIVE_DISABLE buy,
                     const ENUM_ACTIVE_DISABLE sell,
                     const ENUM_TIMEFRAMES timeframe,
                     const int periode,
                     const int shift,
                     const ENUM_MA_METHOD method,
                     const ENUM_APPLIED_PRICE price);

    bool CreateIndicators(const string symbol);
    SMAConfig GetMAconfig();

private:
    void ReleaseIndicators();
};

CIndikatorHandler::CIndikatorHandler() : m_totalMA(0), m_initialized(false)
{
    ArrayResize(m_maConfigs, 0);
    ArrayResize(m_activeHandlers, 0);
}

CIndikatorHandler::~CIndikatorHandler()
{
    ReleaseIndicators();
}

// Set konfigurasi untuk MA spesifik
bool CIndikatorHandler::SetMAConfig(const int index,
                                    const string label,
                                    const ENUM_ON_OFF active,
                                    const ENUM_SIGNAL_TYPE type,
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

// Create semua indicator handles
bool CIndikatorHandler::CreateIndicators(const string symbol)
{
    for (int i = 0; i < m_totalMA; i++)
    {
        if (m_maConfigs[i].active == ON)
        {
            m_maConfigs[i].handle = iMA(symbol,
                                        m_maConfigs[i].timeframe,
                                        m_maConfigs[i].periode,
                                        m_maConfigs[i].shift,
                                        m_maConfigs[i].method,
                                        m_maConfigs[i].price);

            if (m_maConfigs[i].handle == INVALID_HANDLE)
            {
                Print("Failed to create MA handle for ", m_maConfigs[i].label);
                return false;
            }
        }
    }
    return true;
}
// Initialize handler dengan jumlah MA yang diinginkan
bool CIndikatorHandler::Initialize(int totalMA)
{
    if (m_initialized)
        return false;

    m_totalMA = totalMA;
    ArrayResize(m_maConfigs, m_totalMA);
    m_initialized = true;
    return true;
}

// Release semua indicator handles
void CIndikatorHandler::ReleaseIndicators()
{
    if (!m_initialized)
        return;

    for (int i = 0; i < m_totalMA; i++)
    {
        if (m_activeHandlers[i] != INVALID_HANDLE)
        {
            IndicatorRelease(m_activeHandlers[i]);
            m_activeHandlers[i] = INVALID_HANDLE;
            m_maConfigs[i].handle = INVALID_HANDLE;
        }
    }
}
// SMAConfig CIndikatorHandler::GetMAconfig()
// {
//     int index = ArraySize(m_maConfigs);
//     for (int i = 0; i < index; i++)
//     {
//         Print(m_maConfigs[i].label);
//     }
// }
