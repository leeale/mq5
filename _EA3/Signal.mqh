#include "Indikator.mqh"
// #include "Input.mqh"
class CSignal : public CIndikator
{
private:
    double _GetMAValue(const int indexSymbol, const int indexma, int total, int prev = 0);
    double _GetBBValue(const int indexSymbol, const int indexbb, const int band = 0);

public:
    ENUM_SIGNAL_TYPE CalculateMASignal(const int indexSymbol, const int indexma, const string symbol);
    ENUM_SIGNAL_TYPE CalculateBBSignal(const int indexSymbol, const int indexbb, const string symbol);
    void UpdateSignal();
};
void CSignal::UpdateSignal()
{

    for (int i = 0; i < CIndikator::m_totalsymbol; i++)
    {
        for (int j = 0; j < CIndikator::GetTotalMA(); j++)
        {
            CalculateMASignal(i, j, CIndikator::m_symbol[i].symbol);
            CIndikator::m_symbol[i].signalma[j] = CalculateMASignal(i, j, CIndikator::m_symbol[i].symbol);
            Print("Symbol : " + CIndikator::m_symbol[i].symbol + " MA : " + EnumToString(CIndikator::m_symbol[i].signalma[j]));
        }
        for (int j = 0; j < CIndikator::GetTotalBB(); j++)
        {
            CalculateBBSignal(i, j, CIndikator::m_symbol[i].symbol);
            CIndikator::m_symbol[i].signalbb[j] = CalculateBBSignal(i, j, CIndikator::m_symbol[i].symbol);
            Print("Symbol : " + CIndikator::m_symbol[i].symbol + " BB : " + EnumToString(CIndikator::m_symbol[i].signalbb[j]));
        }
    }
}

double CSignal::_GetMAValue(const int indexSymbol, const int index, int total = 2, int prev = 0)
{
    double buffer[];
    ArraySetAsSeries(buffer, true);

    if (CopyBuffer(CIndikator::m_symbol[indexSymbol].handlema[index], 0, 0, total, buffer) > 0)
        return buffer[prev];

    return EMPTY_VALUE;
}

double CSignal::_GetBBValue(const int indexSymbol, const int index, int band = 0)
{
    double buffer[];
    ArraySetAsSeries(buffer, true);

    if (CopyBuffer(CIndikator::m_symbol[indexSymbol].handlebb[index], band, 0, 1, buffer) > 0)
        return buffer[0];

    return EMPTY_VALUE;
}

ENUM_SIGNAL_TYPE CSignal::CalculateMASignal(const int indexSymbol, const int indexma, const string symbol)
{
    MAConfig config = GetMAConfig(indexma);
    double ma_current = _GetMAValue(indexSymbol, indexma, 1);
    double ma_prev = _GetMAValue(indexSymbol, indexma, 2, 1);
    double close_current = iClose(symbol, config.timeframe, 0);
    double close_prev = iClose(symbol, config.timeframe, 1);

    ENUM_SIGNAL_TYPE signal = SIGNAL_NONE;

    switch (config.type)
    {
    case ENUM_MA_SIGNAL_TYPE::UP_DOWN:
    {
        Print("MA_UP_DOWN", "MA Current : ", ma_current, " MA Prev : ", ma_prev);
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

ENUM_SIGNAL_TYPE CSignal::CalculateBBSignal(const int indexSymbol, const int indexbb, const string symbol)
{
    BBConfig config = GetBBConfig(indexbb);
    double upper = _GetBBValue(indexSymbol, indexbb, UPPER_BAND);
    double lower = _GetBBValue(indexSymbol, indexbb, LOWER_BAND);
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