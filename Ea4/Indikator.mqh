// #include "Symbol.mqh";
#include "Input.mqh";
#include "Symbol.mqh";

struct MAConfig
{

    string label;
    // ENUM_ON_OFF active;
    ENUM_MA_SIGNAL_TYPE type;
    ENUM_TIMEFRAMES timeframe;
    int periode;
    int shift;
    ENUM_MA_METHOD method;
    ENUM_APPLIED_PRICE price;
    int handle;
    ENUM_SIGNAL_TYPE signal;
};
struct BBConfig
{
    string label;
    // ENUM_ON_OFF active;
    ENUM_BB_SIGNAL_TYPE type;
    ENUM_TIMEFRAMES timeframe;
    int periode;
    int shift;
    double deviation;
    ENUM_APPLIED_PRICE price;
    int handle;
    ENUM_SIGNAL_TYPE signal;
};
struct SymbolConfig
{
    string symbol;
    int handleMA[];
    int handleBB[];
    ENUM_SIGNAL_TYPE signal[];
};
class CIndikator
{
private:
    CSymbol m_symbol;
    SymbolConfig m_symbolConfigs[];
    int m_totalMA;
    int m_totalBB;
    MAConfig m_maConfigs[];
    BBConfig m_bbConfigs[];
    int m_totalIndikator;

    // Methods privat
    void _SetTotalMA();
    void _SetTotalBB();
    void _SetTotalIndikator();
    void _SetMAConfig();
    void _SetSymbolConfig();
    void _SetBBConfig();
    void _ConfigureNormalMA(int &totalma);
    void _ConfigureManualMA(int &totalma);
    void _ConfigureNormalBB(int &totalbb);
    void _ConfigureManualBB(int &totalbb);
    bool __SetMAConfig(const int index, const string label, const ENUM_ON_OFF active, const ENUM_MA_SIGNAL_TYPE type, const ENUM_TIMEFRAMES timeframe, const int periode, const int shift, const ENUM_MA_METHOD method, const ENUM_APPLIED_PRICE price);
    bool __SetBBConfig(const int index, const string label, const ENUM_ON_OFF active, const ENUM_BB_SIGNAL_TYPE type, const ENUM_TIMEFRAMES timeframe, const int periode, const int shift, const double deviation, const ENUM_APPLIED_PRICE price);
    // Helper Handle Indikator
    bool _CreateMAHandle(const string symbol, const int indexsymbol, const int index);
    bool _CreateBBHandle(const string symbol, const int indexsymbol, const int index);

public:
    // Methods public
    CIndikator();
    ~CIndikator();
    int GetTotalMA() const;
    int GetTotalBB() const;
    int GetTotalIndikator() const;
    void SetInitialized();
    MAConfig GetMAConfig(const int index);
    BBConfig GetBBConfig(const int index);
    SymbolConfig SetSymbolConfig(const int index, int indexindikator, ENUM_SIGNAL_TYPE signal);
    // int GetSymbolHandleMA(const int indexsymbol, const int index);
    void UpdateMASignal(const int index, const ENUM_SIGNAL_TYPE signal);
    void UpdateBBSignal(const int index, const ENUM_SIGNAL_TYPE signal);
    int GetMASignal(const int index) const;
    int GetBBSignal(const int index) const;

    // Handle Indikator
    bool CreateIndicatorHandles(const string symbol, const int indexsymbol);
    void ReleaseIndicatorHandles(int indexsymbol);
    int GetTotalSymbol()
    {
        return m_symbol.GetTotalSymbol();
    }
    SymbolConfig GetSymbolConfig(const int index);
};

// IMPLEMENTASI METHODS DI LUAR CLASS

CIndikator::CIndikator()
{

    // Print(m_symbol.GetTotalSymbol());
    m_totalMA = 0;
    m_totalBB = 0;
    m_totalIndikator = 0;
}
CIndikator::~CIndikator()
{
    for (int i = 0; i < ArraySize(m_symbolConfigs); i++)
    {
        ReleaseIndicatorHandles(i);
    }
    ArrayFree(m_maConfigs);
    ArrayFree(m_bbConfigs);
    ArrayFree(m_symbolConfigs);
}

bool CIndikator::__SetMAConfig(const int index, const string label, const ENUM_ON_OFF active, const ENUM_MA_SIGNAL_TYPE type, const ENUM_TIMEFRAMES timeframe, const int periode, const int shift, const ENUM_MA_METHOD method, const ENUM_APPLIED_PRICE price)
{
    if (index < 0)
        return false;

    m_maConfigs[index].label = label;
    // m_maConfigs[index].active = active;
    m_maConfigs[index].type = type;
    m_maConfigs[index].timeframe = timeframe;
    m_maConfigs[index].periode = periode;
    m_maConfigs[index].shift = shift;
    m_maConfigs[index].method = method;
    m_maConfigs[index].price = price;
    // m_maConfigs[index].handle = INVALID_HANDLE;

    return true;
}
bool CIndikator::__SetBBConfig(const int index, const string label, const ENUM_ON_OFF active, const ENUM_BB_SIGNAL_TYPE type, const ENUM_TIMEFRAMES timeframe, const int periode, const int shift, const double deviation, const ENUM_APPLIED_PRICE price)

{
    if (index < 0)
        return false;

    m_bbConfigs[index].label = label;
    // m_bbConfigs[index].active = active;
    m_bbConfigs[index].type = type;
    m_bbConfigs[index].timeframe = timeframe;
    m_bbConfigs[index].periode = periode;
    m_bbConfigs[index].shift = shift;
    m_bbConfigs[index].deviation = deviation;
    m_bbConfigs[index].price = price;
    // m_bbConfigs[index].handle = INVALID_HANDLE;

    return true;
}

void CIndikator::SetInitialized()
{
    m_symbol.SetInitialized();
    ArrayResize(m_symbolConfigs, m_symbol.GetTotalSymbol());
    _SetTotalMA();
    _SetTotalBB();
    _SetTotalIndikator();
    if (m_totalMA > 0 || (i_signal_manual == ON && i_signal_manual_type == IND_MOVING_AVERAGE))
        _SetMAConfig();
    if (m_totalBB > 0 || (i_signal_manual == ON && i_signal_manual_type == IND_BOLLINGER_BANDS))
        _SetBBConfig();
    _SetSymbolConfig();
}
int CIndikator::GetTotalMA() const
{
    return m_totalMA;
}
int CIndikator::GetTotalBB() const
{
    return m_totalBB;
}
int CIndikator::GetTotalIndikator() const
{
    return m_totalIndikator;
}

// Methods privat
void CIndikator::_SetTotalMA()
{
    ENUM_ON_OFF ma_active[6] = {ma1_active, ma2_active, ma3_active, ma4_active, ma5_active, ma6_active};

    int totalma = 0;
    for (int i = 0; i < ArraySize(ma_active); i++)
    {
        if (ma_active[i] == ON)
        {
            totalma++;
        }
    }
    Print("Total MA : ", totalma);
    m_totalMA = totalma;
}
void CIndikator::_SetTotalBB()
{
    ENUM_ON_OFF bb_active[6] = {bb1_active, bb2_active, bb3_active, bb4_active, bb5_active, bb6_active};
    int totalbb = 0;
    for (int i = 0; i < ArraySize(bb_active); i++)
    {
        if (bb_active[i] == ON)
            totalbb++;
    }
    Print("Total BB : ", totalbb);
    m_totalBB = totalbb;
}
void CIndikator::_SetTotalIndikator()
{
    m_totalIndikator = m_totalMA + m_totalBB;
}
void CIndikator::_SetMAConfig()
{
    int totalma = 0;
    if (m_totalMA > 0)
        _ConfigureNormalMA(totalma); // Set Member m_maConfigs Jika totalMA > 0
    if (i_signal_manual == ON && i_signal_manual_type == IND_MOVING_AVERAGE)
        _ConfigureManualMA(totalma); // Update Member totalMA and m_maConfigs
    if (m_totalMA < 1)
        ArrayFree(m_maConfigs);
    Print("Total MA _SetMAConfig : ", totalma);
}
void CIndikator::_SetBBConfig()
{
    int totalbb = 0;
    if (m_totalBB > 0)
        _ConfigureNormalBB(totalbb); // Set Member m_bbConfigs Jika totalBB > 0
    if (i_signal_manual == ON && i_signal_manual_type == IND_BOLLINGER_BANDS)
        _ConfigureManualBB(totalbb); // Update Member totalBB and m_bbConfigs
    if (m_totalBB < 1)
        ArrayFree(m_bbConfigs);
    Print("Total BB _SetBBConfig : ", totalbb);
}

void CIndikator::_ConfigureNormalMA(int &totalma)
{
    ArrayResize(m_maConfigs, m_totalMA);
    ENUM_ON_OFF ma_active[] = {ma1_active, ma2_active, ma3_active, ma4_active, ma5_active, ma6_active};
    string ma_label[] = {ma1_label, ma2_label, ma3_label, ma4_label, ma5_label, ma6_label};
    ENUM_MA_SIGNAL_TYPE ma_type[] = {ma1_type, ma2_type, ma3_type, ma4_type, ma5_type, ma6_type};
    ENUM_TIMEFRAMES ma_timeframe[] = {ma1_timeframe, ma2_timeframe, ma3_timeframe, ma4_timeframe, ma5_timeframe, ma6_timeframe};
    int ma_periode[] = {ma1_periode, ma2_periode, ma3_periode, ma4_periode, ma5_periode, ma6_periode};
    int ma_shift[] = {ma1_shift, ma2_shift, ma3_shift, ma4_shift, ma5_shift, ma6_shift};
    ENUM_MA_METHOD ma_method[] = {ma1_method, ma2_method, ma3_method, ma4_method, ma5_method, ma6_method};
    ENUM_APPLIED_PRICE ma_price[] = {ma1_price, ma2_price, ma3_price, ma4_price, ma5_price, ma6_price};

    for (int i = 0; i < 6; i++)
    {
        if (ma_active[i] == ON)
        {
            __SetMAConfig(totalma, ma_label[i], ma_active[i], ma_type[i], ma_timeframe[i],
                          ma_periode[i], ma_shift[i], ma_method[i], ma_price[i]);
            Print("MA : " + m_maConfigs[totalma].label);
            totalma++;
        }
    }
}

void CIndikator::_ConfigureManualMA(int &totalma)
{
    m_totalMA += i_siganl_manual_total; // Update total MA
    string periods[];
    string timeframes[];

    // Split period dan timeframe string
    StringSplit(i_signal_manual_period, ',', periods);
    StringSplit(i_signal_manual_timeframe, ',', timeframes);

    // Jika period kurang dari total yang diminta
    if (ArraySize(periods) < i_siganl_manual_total) // 10
    {
        string lastPeriod = periods[ArraySize(periods) - 1]; // ambil value terakhir
        int oldSize = ArraySize(periods);                    // total value
        ArrayResize(periods, i_siganl_manual_total);         // 3

        // Isi sisa dengan nilai terakhir
        for (int i = oldSize; i < i_siganl_manual_total; i++)
        {
            periods[i] = lastPeriod;
        }
    }

    // Jika timeframe kurang dari total yang diminta
    if (ArraySize(timeframes) < i_siganl_manual_total)
    {
        string lastTimeframe = timeframes[ArraySize(timeframes) - 1];
        int oldSize = ArraySize(timeframes);
        ArrayResize(timeframes, i_siganl_manual_total);

        // Isi sisa dengan nilai terakhir
        for (int i = oldSize; i < i_siganl_manual_total; i++)
        {
            timeframes[i] = lastTimeframe;
        }
    }

    // Resize array untuk menampung MA manual
    ArrayResize(m_maConfigs, ArraySize(m_maConfigs) + i_siganl_manual_total);

    // Tambahkan MA manual
    for (int i = 0; i < i_siganl_manual_total; i++)
    {
        long period = StringToInteger(periods[i]);

        __SetMAConfig(totalma, "MA Manual #" + IntegerToString(i + 1), ON, i_signal_manual_type_MA, StringToTimeFrame(timeframes[i]), (int)period, i_siganl_manual_shift, i_signal_manual_method, i_signal_manual_price);
        Print("Manual MA : " + m_maConfigs[totalma].label);
        totalma++;
    }
}

void CIndikator::_ConfigureNormalBB(int &totalbb)
{

    ArrayResize(m_bbConfigs, m_totalBB);
    ENUM_ON_OFF bb_active[6] = {bb1_active, bb2_active, bb3_active, bb4_active, bb5_active, bb6_active};
    ENUM_BB_SIGNAL_TYPE bb_type[] = {bb1_type, bb2_type, bb3_type, bb4_type, bb5_type, bb6_type};
    ENUM_TIMEFRAMES bb_timeframe[] = {bb1_timeframe, bb2_timeframe, bb3_timeframe, bb4_timeframe, bb5_timeframe, bb6_timeframe};
    string bb_label[] = {bb1_label, bb2_label, bb3_label, bb4_label, bb5_label, bb6_label};
    int bb_periode[] = {bb1_periode, bb2_periode, bb3_periode, bb4_periode, bb5_periode, bb6_periode};
    int bb_shift[] = {bb1_shift, bb2_shift, bb3_shift, bb4_shift, bb5_shift, bb6_shift};
    double bb_deviation[] = {bb1_deviation, bb2_deviation, bb3_deviation, bb4_deviation, bb5_deviation, bb6_deviation};
    ENUM_APPLIED_PRICE bb_price[] = {bb1_price, bb2_price, bb3_price, bb4_price, bb5_price, bb6_price};
    for (int i = 0; i < ArraySize(bb_active); i++)
    {
        if (bb_active[i] == ON)
        {
            __SetBBConfig(totalbb, bb_label[i], bb_active[i], bb_type[i], bb_timeframe[i], bb_periode[i], bb_shift[i], bb_deviation[i], bb_price[i]);
            Print("bb : " + m_bbConfigs[totalbb].label);
            // Print("totalbb : ", totalbb);
            totalbb++;
        }
    }
}
void CIndikator::_ConfigureManualBB(int &totalbb)
{
    m_totalBB += i_siganl_manual_total;
    string periods[]; // 1
    string timeframes[];

    // Split period dan timeframe string
    StringSplit(i_signal_manual_period, ',', periods);
    StringSplit(i_signal_manual_timeframe, ',', timeframes);
    // Jika period kurang dari total yang diminta
    if (ArraySize(periods) < i_siganl_manual_total) // 1
    {
        string lastPeriod = periods[ArraySize(periods) - 1]; // periods[0]
        int oldSize = ArraySize(periods);                    // 1
        ArrayResize(periods, i_siganl_manual_total);         // 3

        // Isi sisa dengan nilai terakhir
        for (int i = oldSize; i < i_siganl_manual_total; i++)
        {
            periods[i] = lastPeriod;
        }
    }
    // Jika timeframe kurang dari total yang diminta
    if (ArraySize(timeframes) < i_siganl_manual_total)
    {
        string lastTimeframe = timeframes[ArraySize(timeframes) - 1];
        int oldSize = ArraySize(timeframes);
        ArrayResize(timeframes, i_siganl_manual_total);

        // Isi sisa dengan nilai terakhir
        for (int i = oldSize; i < i_siganl_manual_total; i++)
        {
            timeframes[i] = lastTimeframe;
        }
    }
    // Resize array untuk menampung MA manual
    ArrayResize(m_maConfigs, ArraySize(m_maConfigs) + i_siganl_manual_total);

    // Tambahkan MA manual
    for (int i = 0; i < i_siganl_manual_total; i++)
    {
        long period = StringToInteger(periods[i]);

        __SetBBConfig(totalbb, "BB Manual #" + IntegerToString(i + 1), ON, i_signal_manual_type_BB, StringToTimeFrame(timeframes[i]), (int)period, i_siganl_manual_shift, i_signal_manual_deviation, i_signal_manual_price);
        Print("Manual BB : " + m_bbConfigs[totalbb].label);
        totalbb++;
    }
}

MAConfig CIndikator::GetMAConfig(const int index)
{
    if (index < 0 || index > m_totalMA)
    {
        Print("Invalid MA Config index ", index);
        return m_maConfigs[0];
    }
    return m_maConfigs[index];
}
// Getter functions for BB Configuration
BBConfig CIndikator::GetBBConfig(const int index)
{
    if (index < 0 || index > m_totalBB)
    {
        Print("Invalid BB Config index ", index);
        return m_bbConfigs[0];
    }
    return m_bbConfigs[index];
}

bool CIndikator::_CreateMAHandle(const string symbol, const int indexsymbol, const int index)
{
    if (index < 0 || index >= m_totalMA)
    {
        Print("Invalid MA index for handle creation: " + IntegerToString(index));
        return false;
    }

    m_symbolConfigs[indexsymbol].handleMA[index] = iMA(symbol,
                                                       m_maConfigs[index].timeframe,
                                                       m_maConfigs[index].periode,
                                                       m_maConfigs[index].shift,
                                                       m_maConfigs[index].method,
                                                       m_maConfigs[index].price);

    if (m_symbolConfigs[indexsymbol].handleMA[index] == INVALID_HANDLE)
    {
        Print("Failed to create MA handle for " + m_maConfigs[index].label +
              " Error: " + IntegerToString(GetLastError()));
        return false;
    }

    return true;
}

bool CIndikator::_CreateBBHandle(const string symbol, const int indexsymbol, const int index)
{
    if (index < 0 || index >= m_totalBB)
    {
        Print("Invalid BB index for handle creation: " + IntegerToString(index));
        return false;
    }

    m_symbolConfigs[indexsymbol].handleBB[index] = iBands(symbol,
                                                          m_bbConfigs[index].timeframe,
                                                          m_bbConfigs[index].periode,
                                                          m_bbConfigs[index].shift,
                                                          m_bbConfigs[index].deviation,
                                                          m_bbConfigs[index].price);

    if (m_symbolConfigs[indexsymbol].handleBB[index] == INVALID_HANDLE)
    {
        Print("Failed to create BB handle for " + m_bbConfigs[index].label +
              " Error: " + IntegerToString(GetLastError()));
        return false;
    }

    return true;
}

bool CIndikator::CreateIndicatorHandles(const string symbol, const int indexsymbol)
{
    bool success = true;
    // string symbols[];
    // int totalSymbols = CSymbol::GetTotalSymbol(symbols); // Get array of active symbols

    // Create MA handles
    for (int i = 0; i < m_totalMA; i++)
    {
        if (!_CreateMAHandle(symbol, indexsymbol, i))
        {
            success = false;
            Print("Failed to create MA handle at index " + IntegerToString(i));
        }
        Print("MA handle created for ", m_symbolConfigs[indexsymbol].handleMA[i]);
    }

    // Create BB handles
    for (int i = 0; i < m_totalBB; i++)
    {
        if (!_CreateBBHandle(symbol, indexsymbol, i))
        {
            success = false;
            Print("Failed to create BB handle at index " + IntegerToString(i));
        }
        Print("BB handle created for ", m_symbolConfigs[indexsymbol].handleBB[i]);
    }

    return success;
}

void CIndikator::ReleaseIndicatorHandles(int indexsymbol)
{
    // Release MA handles
    for (int i = 0; i < m_totalMA; i++)
    {
        if (m_symbolConfigs[indexsymbol].handleMA[i] != INVALID_HANDLE)
        {
            IndicatorRelease(m_symbolConfigs[indexsymbol].handleMA[i]);
            m_symbolConfigs[indexsymbol].handleMA[i] = INVALID_HANDLE;
        }
    }

    // Release BB handles
    for (int i = 0; i < m_totalBB; i++)
    {
        if (m_symbolConfigs[indexsymbol].handleBB[i] != INVALID_HANDLE)
        {
            IndicatorRelease(m_symbolConfigs[indexsymbol].handleBB[i]);
            m_symbolConfigs[indexsymbol].handleBB[i] = INVALID_HANDLE;
        }
    }
}
void CIndikator::UpdateMASignal(const int index, const ENUM_SIGNAL_TYPE signal)
{
    if (index < 0 || index >= m_totalMA)
    {
        Print("Invalid MA index for signal update: " + IntegerToString(index));
        return;
    }
    m_maConfigs[index].signal = signal;
}

void CIndikator::UpdateBBSignal(const int index, const ENUM_SIGNAL_TYPE signal)
{
    if (index < 0 || index >= m_totalBB)
    {
        Print("Invalid BB index for signal update: " + IntegerToString(index));
        return;
    }
    m_bbConfigs[index].signal = signal;
}

// Get signal values
int CIndikator::GetMASignal(const int index) const
{
    if (index < 0 || index >= m_totalMA)
    {
        Print("Invalid MA index for signal get: " + IntegerToString(index));
        return 0;
    }
    return m_maConfigs[index].signal;
}

int CIndikator::GetBBSignal(const int index) const
{
    if (index < 0 || index >= m_totalBB)
    {
        Print("Invalid BB index for signal get: " + IntegerToString(index));
        return 0;
    }
    return m_bbConfigs[index].signal;
}

void CIndikator::_SetSymbolConfig()
{
    Print("total symbol: ", m_symbol.GetTotalSymbol());
    int totalSymbols = m_symbol.GetTotalSymbol();
    for (int i = 0; i < totalSymbols; i++)
    {
        ArrayResize(m_symbolConfigs[i].handleMA, m_totalMA);
        ArrayResize(m_symbolConfigs[i].handleBB, m_totalBB);

        m_symbolConfigs[i].symbol = m_symbol.GetSymbol(i);
        CreateIndicatorHandles(m_symbolConfigs[i].symbol, i);
        Print(m_symbolConfigs[i].symbol);
    }
}

SymbolConfig CIndikator::SetSymbolConfig(const int index, int indexindikator, ENUM_SIGNAL_TYPE signal)
{

    if (index < 0 || index >= ArraySize(m_symbolConfigs))
    {
        Print("Error: Index diluar batas array");
        return m_symbolConfigs[0];
    }

    m_symbolConfigs[index].signal[indexindikator] = signal;
    return m_symbolConfigs[index];
}

SymbolConfig CIndikator::GetSymbolConfig(const int index)
{
    return m_symbolConfigs[index];
}

ENUM_TIMEFRAMES StringToTimeFrame(string tf)
{
    if (tf == "M1")
        return PERIOD_M1;
    if (tf == "M5")
        return PERIOD_M5;
    if (tf == "M15")
        return PERIOD_M15;
    if (tf == "M30")
        return PERIOD_M30;
    if (tf == "H1")
        return PERIOD_H1;
    if (tf == "H4")
        return PERIOD_H4;
    if (tf == "D1")
        return PERIOD_D1;
    if (tf == "W1")
        return PERIOD_W1;
    if (tf == "MN1")
        return PERIOD_MN1;
    return PERIOD_CURRENT;
}