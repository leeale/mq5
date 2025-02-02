#include "Variable_Global.mqh"
#include "Input.mqh"

void SetSymbolType()
{
    // Set the symbol type based on the input parameter
    switch (i_symbolType)
    {
    case SYMBOL_ALL:
        SetAllSymbols();
        break;

    case SYMBOL_BASE:
        SetBaseSymbols();
        break;

    case SYMBOL_CURRENT:
        SetCurrentSymbol();
        break;

    case Symbol_Type::SYMBOL_CUSTOM:
        SetCustomSymbols();
        break;
    }
    // Set the direction of symbols based on the input parameter
    m_direction = EnumToString(i_symbolDirection);
    // Set the base symbol flag based on the input parameter
    if (i_symbolType == Symbol_Type::SYMBOL_BASE)
        m_isSymbolBase = true;
    else
        m_isSymbolBase = false;
    // Ceks symbol base
    if (m_isSymbolBase)
    {
        m_baseSymbol = EnumToString(i_symbolBase);
        m_baseDirection = EnumToString(i_symbolBaseDirection);
    }
    else
    {
        m_baseSymbol = "false";
        m_baseDirection = "false";
    }
}
void SetAllSymbols()
{
    m_totalSymbols = 0;
    ArrayResize(m_symbols, 0);

    for (int i = 0; i < SymbolsTotal(true); i++)
    {
        string symbol = SymbolName(i, true);
        if (symbol != "")
        {
            m_totalSymbols++;
            ArrayResize(m_symbols, m_totalSymbols);
            m_symbols[m_totalSymbols - 1] = symbol;
        }
    }
}

void SetBaseSymbols()
{
    m_totalSymbols = 0;
    ArrayResize(m_symbols, 0);
    string baseStr = EnumToString(i_symbolBase);

    for (int i = 0; i < SymbolsTotal(true); i++)
    {
        string symbol = SymbolName(i, true);
        if (StringFind(symbol, baseStr) != -1)
        {
            m_totalSymbols++;
            ArrayResize(m_symbols, m_totalSymbols);
            m_symbols[m_totalSymbols - 1] = symbol;
        }
    }
}

void SetCurrentSymbol()
{
    m_totalSymbols = 1;
    ArrayResize(m_symbols, 1);
    m_symbols[0] = Symbol();
}

void SetCustomSymbols()
{
    string sep = ",";
    ushort u_sep = StringGetCharacter(sep, 0);
    string temp[];

    m_totalSymbols = StringSplit(i_symbolCustom, u_sep, temp);
    ArrayResize(m_symbols, m_totalSymbols);

    for (int i = 0; i < m_totalSymbols; i++)
    {
        m_symbols[i] = temp[i];
    }
}