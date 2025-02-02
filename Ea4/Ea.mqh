// #include "Input.mqh"
#include "Symbol.mqh"
#include "Indikator.mqh"
#include "Signal.mqh"
// struct SymbolConfig
// {
//     string symbol;
//     int handle[];
//     ENUM_SIGNAL_TYPE signal[];
// };
class CEa
{
private:
    // SymbolConfig m_symbolConfig[];
    CSymbol m_symbol;       // Pengelola symbol
    CIndikator m_indicator; // Pengelola indikator
    CSignal m_signal;       // Pengelola signal

    // Helper methods
    // void ProcessSignals();

public:
    void OnInit();
    void OnTick();
};
void CEa::OnInit()
{
    // 1. Inisialisasi Symbol
    m_symbol.SetInitialized();

    // 2. Inisialisasi Indikator
    m_indicator.SetInitialized();
}

void CEa::OnTick()
{
}