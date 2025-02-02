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
    bool isbuy;
    bool issell;
    bool firstOrder;
    bool gridOrder;
    double lot;
    double lot_grid;
    int magic;
};

class CSymbol
{
private:
    bool m_inisialized;
    bool m_issignalbase;
    bool m_isoneside;
    bool m_isbothside;
    bool m_isbuyOnly;  // hanya di gunakan untuk SYMBOLDIRECON :: BUY
    bool m_issellOnly; // hanya di gunakan untuk SYMBOLDIRECON :: SELL
    string m_baseSymbol;

    //  methods Helper
    void SymbolAll();
    void SymbolBase();
    void SymbolCurrent();
    void SymbolCustom();
    void _SymbolType();
    // void _symboldata();

public:
    int m_totalsymbol;

    SymbolData m_symbol[];
    CSymbol();
    ~CSymbol();
    bool SetInitialized();
    string GetSymbol(const int index);
    SymbolData GetSymbolData(const int index);
    int GetTotalSymbol();
};

CSymbol::CSymbol(/* args */)
{
    m_totalsymbol = 0;
    m_issignalbase = false;
    m_isoneside = false;
    m_isbothside = false;
    m_inisialized = false;
    m_isbuyOnly = false;
    m_issellOnly = false;
}

CSymbol::~CSymbol()
{
    ArrayFree(m_symbol);
    Print("data m_symbol di hapus");
}
bool CSymbol::SetInitialized()
{
    // RULE ORDER
    if (i_symbolType == SYMBOL_BASE)
    {
        m_issignalbase = true;
        m_isoneside = true;
    }
    switch (i_symbolDirection)
    {
    case BOOTH_SIDE:
        m_isbothside = true;
        break;
    case ONE_SIDE:
        m_isoneside = true;
        break;
    case Symbol_Direction::BUY:
    {
        m_isoneside = true;
        m_isbuyOnly = true;
        break;
    }
    case Symbol_Direction::SELL:
    {
        m_isoneside = true;
        m_issellOnly = true;
        break;
    }
    default:
        break;
    }
    m_inisialized = true;
    // Print("CSymbol Initialized");
    _SymbolType();

    return m_inisialized;
}
void CSymbol::_SymbolType()
{
    if (!m_inisialized)
        return;
    switch (i_symbolType)
    {
    case SYMBOL_ALL:
        SymbolAll();
        break;
    case SYMBOL_BASE:
        SymbolBase();
        break;
    case Symbol_Type::SYMBOL_CUSTOM:
        SymbolCustom();
        break;
    case SYMBOL_CURRENT:
        SymbolCurrent();
        break;
    }
}
void CSymbol::SymbolAll()
{
    Print("All Symbol");
    int total = SymbolsTotal(true);
    if (total == 0)
    {
        Print("No Symbol");
        return;
    }
    m_totalsymbol = ArrayResize(m_symbol, total);
    for (int i = 0; i < total; i++)
    {
        m_symbol[i].symbol = SymbolName(i, true);
        m_symbol[i].signal = 0;
        m_symbol[i].isbuy = false;
        m_symbol[i].issell = false;
        m_symbol[i].firstOrder = false;
        m_symbol[i].gridOrder = false;
        m_symbol[i].lot = 0.0;
        m_symbol[i].lot_grid = 0.0;
        m_symbol[i].magic = 0;
    }
}
void CSymbol::SymbolBase()
{
    Print("Base Symbol");
    int total = SymbolsTotal(true);
    if (total == 0)
    {
        Print("No Symbol");
        return;
    }
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
            m_symbol[m_totalsymbol - 1].isbuy = false;
            m_symbol[m_totalsymbol - 1].issell = false;
            m_symbol[m_totalsymbol - 1].firstOrder = false;
            m_symbol[m_totalsymbol - 1].gridOrder = false;
            m_symbol[m_totalsymbol - 1].lot = 0.0;
            m_symbol[m_totalsymbol - 1].lot_grid = 0.0;
            m_symbol[m_totalsymbol - 1].magic = 0;
        }
    }
}
void CSymbol::SymbolCurrent()
{
    Print("Current Symbol");
    m_totalsymbol = 1;
    ArrayResize(m_symbol, 1);
    m_symbol[m_totalsymbol - 1].symbol = Symbol();
    m_symbol[m_totalsymbol - 1].signal = 0;
    m_symbol[m_totalsymbol - 1].isbuy = false;
    m_symbol[m_totalsymbol - 1].issell = false;
    m_symbol[m_totalsymbol - 1].firstOrder = false;
    m_symbol[m_totalsymbol - 1].gridOrder = false;
    m_symbol[m_totalsymbol - 1].lot = 0.0;
    m_symbol[m_totalsymbol - 1].lot_grid = 0.0;
    m_symbol[m_totalsymbol - 1].magic = 0;
    m_totalsymbol = 1;
}
void CSymbol::SymbolCustom()
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
        m_symbol[i].isbuy = false;
        m_symbol[i].issell = false;
        m_symbol[i].firstOrder = false;
        m_symbol[i].gridOrder = false;
        m_symbol[i].lot = 0.0;
        m_symbol[i].lot_grid = 0.0;
        m_symbol[i].magic = 0;
    }
}

int CSymbol::GetTotalSymbol()
{
    return m_totalsymbol;
}

string CSymbol::GetSymbol(const int index)
{
    if (index < 0 || index >= m_totalsymbol)
    {
        Print("Invalid symbol index: " + IntegerToString(index));
        return "";
    }
    return m_symbol[index].symbol;
}

SymbolData CSymbol::GetSymbolData(const int index)
{
    if (index < 0 || index >= m_totalsymbol)
    {
        Print("Invalid symbol index: " + IntegerToString(index));
        return SymbolData();
    }
    return m_symbol[index];
}