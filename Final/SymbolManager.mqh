#include "Input.mqh"
class SymbolManager
{
private:
    Symbol_Type i_symbolType; // Jenis simbol
    Symbol_Base i_symbolBase; // Simbol dasar
    string i_symbolCustom;    // Simbol kustom

public:
    // Konstruktor
    SymbolManager(Symbol_Type ji, Symbol_Base k, string d)
    {
        i_symbolType = ji;
        i_symbolBase = k;
        i_symbolCustom = d;
    }

    // Metode untuk mendapatkan semua simbol yang tersedia
    void GetAllSymbols(string &symbolname)
    {
        int totalSymbols = SymbolsTotal(true); // Mengambil total simbol di Market Watch
        for (int i = 0; i < totalSymbols; i++)
        {
            symbolname = SymbolName(i, true);
            Print("Symbol: ", symbolname); // Mencetak nama simbol
        }
    }

    // Metode untuk mencari pasangan simbol berdasarkan simbol dasar
    void FindBaseSymbols()
    {
        string baseSymbol = EnumToString(i_symbolBase);
        int totalSymbols = SymbolsTotal(true);
        for (int i = 0; i < totalSymbols; i++)
        {
            string symbolName = SymbolName(i, true);
            if (StringFind(symbolName, baseSymbol) != -1)
            {
                Print("Base Symbol: ", symbolName); // Mencetak pasangan simbol yang mengandung simbol dasar
            }
        }
    }

    // Metode untuk mendapatkan simbol saat ini dari grafik
    string GetCurrentSymbol()
    {
        return Symbol(); // Mengembalikan simbol saat ini dari grafik
    }

    // Metode untuk mendapatkan simbol kustom
    void PrintCustomSymbols()
    {
        Print("Custom Symbols: ", i_symbolCustom); // Mencetak simbol kustom
    }
};
