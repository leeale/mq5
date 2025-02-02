string m_symbols[]; // Array to store symbols
int m_totalSymbols; // Total number of symbols
string m_direction; // Direction of symbols
bool m_isSymbolBase;
string m_baseSymbol;
string m_baseDirection;

struct FirstOrder
{
    string symbol;
    int final_signal;
    double lot;
};
FirstOrder firstOrder;

struct GridOrder
{
    string symbol;
    int signal;
    double lot;
}
