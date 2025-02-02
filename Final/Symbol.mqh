#include "Input.mqh";
// #include "Indikator.mqh"
struct SymbolData
{
    string symbol;
    int handlema[];
    int handlebb[];
    ENUM_SIGNAL_TYPE signalma[];
    ENUM_SIGNAL_TYPE signalbb[];
    int signal;
};

class CSymbol
{ //  methods Helper
public:
    int m_totalsymbol;
    SymbolData m_symbol[];
    CSymbol();
    ~CSymbol();

    int GetSymbolAll();
    int GetSymbolBase();
    int GetSymbolCurrent();
    int GetSymbolCustom();
};

CSymbol::CSymbol(/* args */)
{
}

CSymbol::~CSymbol()
{
    ArrayFree(m_symbol);
    Print("data m_symbol di hapus");
}

int CSymbol::GetSymbolAll()
{
    Print("All Symbol");
    int total = SymbolsTotal(true);
    ArrayResize(m_symbol, total);
    for (int i = 0; i < total; i++)
    {
        m_symbol[i].symbol = SymbolName(i, true);
        m_symbol[i].signal = 0;
    }
    return m_totalsymbol;
}
int CSymbol::GetSymbolBase()
{
    Print("Base Symbol");
    int total = SymbolsTotal(true);
    string baseStr = EnumToString(i_symbolBase);

    m_totalsymbol = 0;
    for (int i = 0; i < total; i++)
    {
        string symbol = SymbolName(i, true);
        if (StringFind(symbol, baseStr) != -1)
        {
            m_totalsymbol++;
            ArrayResize(m_symbol, m_totalsymbol);
            m_symbol[m_totalsymbol - 1].symbol = symbol;
            m_symbol[m_totalsymbol - 1].signal = 0;
        }
    }
    return m_totalsymbol;
}
int CSymbol::GetSymbolCurrent()
{
    Print("Current Symbol");
    m_totalsymbol = 1;
    ArrayResize(m_symbol, 1);
    m_symbol[m_totalsymbol - 1].symbol = Symbol();
    m_symbol[m_totalsymbol - 1].signal = 0;
    m_totalsymbol = 1;
    return m_totalsymbol;
}
int CSymbol::GetSymbolCustom()
{
    Print("Custom Symbol");
    string sep = ",";
    ushort u_sep = StringGetCharacter(sep, 0);
    string temp[];

    m_totalsymbol = StringSplit(i_symbolCustom, u_sep, temp);
    ArrayResize(m_symbol, m_totalsymbol);
    for (int i = 0; i < m_totalsymbol; i++)
    {
        m_symbol[i].symbol = temp[i];
        m_symbol[i].signal = 0;
    }
    return m_totalsymbol;
}
