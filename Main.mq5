#include <SymbolManager.mq5>

input Symbol_Type i_symbolType = Symbol_Type::SYMBOL_ALL;                         // Jenis simbol
input Symbol_Base i_symbolBase = Symbol_Base::USD;                                // Simbol dasar
input string i_symbolCustom = "GBPUSD,GBPJPY,GBPCHF,GBPAUD,GBPNZD,GBPCAD,EURGBP"; // Simbol kustom

void OnStart()
{
    // Inisialisasi objek SymbolManager
    SymbolManager symbolManager(i_symbolType, i_symbolBase, i_symbolCustom);

    // Memanggil metode untuk mendapatkan semua simbol
    symbolManager.GetAllSymbols();

    // Memanggil metode untuk mencari simbol dasar
    symbolManager.FindBaseSymbols();

    // Mencetak simbol kustom
    symbolManager.PrintCustomSymbols();

    // Mendapatkan simbol saat ini dari grafik
    string currentSymbol = symbolManager.GetCurrentSymbol();
    Print("Current Symbol: ", currentSymbol); // Mencetak simbol saat ini
}
