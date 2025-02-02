#include "../Enum.mqh"
// Fungsi untuk mengonversi ENUM_SYMBOL_BASE ke string
string GetBaseSymbolString(ENUM_SYMBOL_BASE baseSymbol)
{
    switch (baseSymbol)
    {
    case USD:
        return "USD";
    case GBP:
        return "GBP";
    case EUR:
        return "EUR";
    case JPY:
        return "JPY";
    case CAD:
        return "CAD";
    case CHF:
        return "CHF";
    case AUD:
        return "AUD";
    case NZD:
        return "NZD";
    }
    return ""; // Default: return empty string jika tidak ada yang cocok
}
string GetBaseSymbolType(ENUM_SYMBOL_TYPE Basesymboltype)
{
    switch (Basesymboltype)
    {
    case SYMBOL_ALL:
        return "SYMBOL_ALL";
    case SYMBOL_BASE:
        return "SYMBOL_BASE";
    case SYMBOL_CURRENT:
        return "SYMBOL_CURRENT";
    case ENUM_SYMBOL_TYPE::SYMBOL_CUSTOM:
        return "SYMBOL_CUSTOM";
    }
    return ""; // Default: return empty string jika tidak ada yang cocok
}