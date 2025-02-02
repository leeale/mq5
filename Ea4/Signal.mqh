#include "Indikator.mqh"

// #include "Input.mqh"
class CSignal
{
private:
    CIndikator m_indikator; // Pointer Indikator

    // Helper methods untuk perhitungan signal
    double _GetMAValue(const int indexSymbol, const int index, const int ma = 0, const int shift = 0);
    double _GetBBValue(const int indexSymbol, const int index, const int band = 0, const int shift = 0);

public:
    int GetTotalSymbol()
    {
        return m_indikator.GetTotalSymbol();
    }
    int GetTotalMA()
    {
        return m_indikator.GetTotalMA();
    }
    int GetTotalBB()
    {
        return m_indikator.GetTotalBB();
    }
    void CalculateSignal();
    ENUM_SIGNAL_TYPE CalculateMASignal(const int indexSymbol, const int index, const string symbol);
    ENUM_SIGNAL_TYPE CalculateBBSignal(const int indexSymbol, const int index, const string symbol);
    void SetInitialized();
};

double CSignal::_GetMAValue(const int indexSymbol, const int index, int ma = 0, const int shift = 0)
{
    MAConfig config = m_indikator.GetMAConfig(index);
    SymbolConfig configSymbol = m_indikator.GetSymbolConfig(indexSymbol);
    double buffer[];
    ArraySetAsSeries(buffer, true);

    if (CopyBuffer(configSymbol.handleMA[index], ma, shift, 1, buffer) > 0)
        return buffer[0];

    return EMPTY_VALUE;
}

double CSignal::_GetBBValue(const int indexSymbol, const int index, int band = 0, const int shift = 0)
{
    BBConfig config = m_indikator.GetBBConfig(index);
    SymbolConfig configSymbol = m_indikator.GetSymbolConfig(indexSymbol);
    double buffer[];
    ArraySetAsSeries(buffer, true);

    if (CopyBuffer(configSymbol.handleBB[index], band, shift, 1, buffer) > 0)
        return buffer[0];

    return EMPTY_VALUE;
}

ENUM_SIGNAL_TYPE CSignal::CalculateMASignal(const int indexSymbol, const int index, const string symbol)
{
    MAConfig config = m_indikator.GetMAConfig(index);
    double ma_current = _GetMAValue(indexSymbol, index);
    double ma_prev = _GetMAValue(indexSymbol, index, 1);
    double close_current = iClose(symbol, config.timeframe, 0);
    double close_prev = iClose(symbol, config.timeframe, 1);

    ENUM_SIGNAL_TYPE signal = SIGNAL_NONE;

    switch (config.type)
    {
    case ENUM_MA_SIGNAL_TYPE::UP_DOWN:
    {
        if (ma_current > ma_prev)
            signal = SIGNAL_BUY;
        else if (ma_current < ma_prev)
            signal = SIGNAL_SELL;
        break;
    }

    case ENUM_MA_SIGNAL_TYPE::UP_DOWN_REVERSE:
    { // Counter trend
        if (ma_current > ma_prev)
            signal = SIGNAL_SELL;
        else if (ma_current < ma_prev)
            signal = SIGNAL_BUY;
        break;
    }
    case ENUM_MA_SIGNAL_TYPE::CROSS_UP:
    {
        if (close_prev < ma_prev && close_current > ma_current)
            signal = SIGNAL_BUY;
        break;
    }
    case ENUM_MA_SIGNAL_TYPE::CROSS_DOWN: // Price crosses MA downward
        if (close_prev > ma_prev && close_current < ma_current)
            signal = SIGNAL_SELL;
        break;
    }

    return signal;
}

ENUM_SIGNAL_TYPE CSignal::CalculateBBSignal(const int indexSymbol, const int index, const string symbol)
{
    Print("signal calculate bb signal index: " + IntegerToString(index));
    BBConfig config = m_indikator.GetBBConfig(index);
    double upper = _GetBBValue(index, UPPER_BAND);
    double lower = _GetBBValue(index, LOWER_BAND);
    double close_current = iClose(symbol, config.timeframe, 0);
    double close_prev = iClose(symbol, config.timeframe, 1);

    ENUM_SIGNAL_TYPE signal = SIGNAL_NONE;

    switch (config.type)
    {
    case ENUM_BB_SIGNAL_TYPE::UP_DOWN:
    { // Price touches bands}
        if (close_current >= upper)
            signal = SIGNAL_SELL;
        else if (close_current <= lower)
            signal = SIGNAL_BUY;
        break;
    }
    case ENUM_BB_SIGNAL_TYPE::UP_DOWN_REVERSE: // Reverse on band touch
        if (close_current >= upper)
            signal = SIGNAL_BUY;
        else if (close_current <= lower)
            signal = SIGNAL_SELL;
        break;

    case ENUM_BB_SIGNAL_TYPE::CROSS_UP: // Cross lower band upward
        if (close_prev <= lower && close_current > lower)
            signal = SIGNAL_BUY;
        break;

    case ENUM_BB_SIGNAL_TYPE::CROSS_DOWN: // Cross upper band downward
        if (close_prev >= upper && close_current < upper)
            signal = SIGNAL_SELL;
        break;
    }

    return signal;
}

void CSignal::SetInitialized()
{
    m_indikator.SetInitialized();
}

void CSignal::CalculateSignal()
{
    for (int i = 0; i < m_indikator.GetTotalSymbol(); i++)
    {
        string symbol = m_indikator.GetSymbolConfig(i).symbol;
        for (int j = 0; j < m_indikator.GetTotalMA(); j++)
        {
            m_indikator.SetSymbolConfig(i, j, CalculateMASignal(i, j, symbol));
            // Print("signal calculate ma signal index: " + IntegerToString(j), "symbol: " + symbol, "signal : " + EnumToString(m_indikator.GetSymbolConfig(i).signal[j]));
            m_indikator.SetSymbolConfig(i, j, CalculateBBSignal(i, j, symbol));
            // Print("signal calculate bb signal index: " + IntegerToString(j), "symbol: " + symbol, "signal : " + EnumToString(m_indikator.GetSymbolConfig(i).signal[j]));
        }
    }
}
