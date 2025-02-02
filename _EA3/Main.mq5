#property strict

#include "Input.mqh"
#include "Symbol.mqh"
#include "Indikator.mqh"
#include "Signal.mqh"
// #include "Ea.mqh";
// CEa Ea;
CIndikator Cind;
CSignal Csignal;

// CSymbol Csymbol;
int OnInit()
{
    if (!Cind.SetInitialized())
    {
        Print("Gagal Set inialized inidaktor");
        return (INIT_FAILED);
    }

    EventSetTimer(5);
    return (INIT_SUCCEEDED);
}
void OnDeinit(const int reason)
{
    Cind.CleanUp();
    Cind.CleanUp();
    Cind.CleanUp();
    // Delete objects
}
void OnTick()
{
    Csignal.UpdateSignal();
}
void OnTimer()
{
}