#property strict

// #include "Input.mqh"
// #include "Symbol.mqh"
// #include "Indikator.mqh"
#include "Signal.mqh"
// #include "Ea.mqh";
// CEa Ea;
// CIndikator Cind;
// CSymbol Csymbol;
CSignal Csignal;

int OnInit()
{
    // Csymbol.SetInitialized();
    // Cind.SetInitialized();
    // Print("Total Symbol: main ", Csymbol.GetTotalSymbol());
    Csignal.SetInitialized();
    EventSetTimer(5);
    return (INIT_SUCCEEDED);
}
void OnDeinit(const int reason)
{

    EventKillTimer();
}
void OnTimer()
{
}
void OnTick()
{
    Csignal.CalculateSignal();
}