#ifndef GETINFOSYMBOL_MQH
#define GETINFOSYMBOL_MQH

#property strict

/**
 *@brief Mengambil harga permintaan saat ini untuk simbol tertentu dan menormalkannya ke sejumlah tempat desimal tertentu.
 *
 *@param[in] simbol Simbol yang digunakan untuk mendapatkan harga permintaan. Defaultnya adalah simbol saat ini jika tidak ditentukan.
 *@param[in] digit Jumlah angka desimal dimana harga permintaan harus dinormalisasi. Defaultnya adalah digit simbol jika tidak ditentukan.
 *@return Harga permintaan yang dinormalisasi untuk simbol yang ditentukan.
 */

double GetDoublePriceAsk(string symbol = NULL, int digits = 0)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    if (digits == 0)
    {
        digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    }
    return NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_ASK), digits);
}

/**
 * @brief Mengambil harga penawaran saat ini untuk simbol tertentu dan menormalkannya ke sejumlah tempat desimal tertentu.
 *
 * @param[in] simbol Simbol yang digunakan untuk mendapatkan harga penawaran. Defaultnya adalah simbol saat ini jika tidak ditentukan.
 * @param[in] digit Jumlah angka desimal dimana harga penawaran harus dinormalisasi. Defaultnya adalah digit simbol jika tidak ditentukan.
 * @return Harga penawaran yang dinormalisasi untuk simbol yang ditentukan.
 */
double GetDoublePriceBid(string symbol = NULL, int digits = 0)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    if (digits == 0)
    {
        digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    }
    return NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_BID), digits);
}
/**
 * @brief Mengambil harga penawaran tertinggi Hari ini untuk simbol tertentu dan menormalkannya ke sejumlah tempat desimal tertentu.
 *
 * @param[in] simbol Simbol yang digunakan untuk mendapatkan harga penawaran tertinggi. Defaultnya adalah simbol saat ini jika tidak ditentukan.
 * @param[in] digit Jumlah angka desimal dimana harga penawaran tertinggi harus dinormalisasi. Defaultnya adalah digit simbol jika tidak ditentukan.
 * @return Harga penawaran tertinggi yang dinormalisasi untuk simbol yang ditentukan.
 */
double GetDoublePriceBidHigh(string symbol = NULL, int digits = 0)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    if (digits == 0)
    {
        digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    }
    return NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_BIDHIGH), digits);
}

/**
 * @brief Mengambil harga penawaran terendah Hari ini untuk simbol tertentu dan menormalkannya ke sejumlah tempat desimal tertentu.
 *
 * @param[in] simbol Simbol yang digunakan untuk mendapatkan harga penawaran terendah. Defaultnya adalah simbol saat ini jika tidak ditentukan.
 * @param[in] digit Jumlah angka desimal dimana harga penawaran terendah harus dinormalisasi. Defaultnya adalah digit simbol jika tidak ditentukan.
 * @return Harga penawaran terendah yang dinormalisasi untuk simbol yang ditentukan.
 */
double GetDoublePriceBidLow(string symbol = NULL, int digits = 0)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    if (digits == 0)
    {
        digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    }
    return NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_BIDLOW), digits);
}

/**
 * @brief Mengambil harga permintaan tertinggi Hari ini untuk simbol tertentu dan menormalkannya ke sejumlah tempat desimal tertentu.
 *
 * @param[in] symbol Simbol yang digunakan untuk mendapatkan harga permintaan tertinggi. Defaultnya adalah simbol saat ini jika tidak ditentukan.
 * @param[in] digits Jumlah angka desimal dimana harga permintaan tertinggi harus dinormalisasi. Defaultnya adalah digit simbol jika tidak ditentukan.
 * @return Harga permintaan tertinggi yang dinormalisasi untuk simbol yang ditentukan.
 */

double GetDobulePriceAskHigh(string symbol = NULL, int digits = 0)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    if (digits == 0)
    {
        digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    }
    return NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_ASKHIGH), digits);
}

/**
 * @brief Mengambil harga permintaan terendah Hari ini untuk simbol tertentu dan menormalkannya ke sejumlah tempat desimal tertentu.
 *
 * @param[in] symbol Simbol yang digunakan untuk mendapatkan harga permintaan terendah. Defaultnya adalah simbol saat ini jika tidak ditentukan.
 * @param[in] digits Jumlah angka desimal dimana harga permintaan terendah harus dinormalisasi. Defaultnya adalah digit simbol jika tidak ditentukan.
 * @return Harga permintaan terendah yang dinormalisasi untuk simbol yang ditentukan.
 */

double GetDobulePriceAskLow(string symbol = NULL, int digits = 0)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    if (digits == 0)
    {
        digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    }
    return NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_ASKLOW), digits);
}
/**
 * @brief Mendapatkan spread (selisih harga jual dan harga beli) sebagai nilai integer
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Spread sebagai nilai integer
 */
int GetIntegerPriceSpread(string symbol = NULL)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    return (int)SymbolInfoInteger(symbol, SYMBOL_SPREAD);
}

/**
 * @brief Mendapatkan jumlah digit desimal untuk simbol tertentu
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Jumlah digit desimal untuk simbol yang ditentukan
 */
int GetIntegerPriceDigits(string symbol = NULL)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    return (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
}
/**
 * @brief Mendapatkan nilai point sebagai nilai double
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Nilai point sebagai nilai double
 */
double GetDoublePricePoints(string symbol = NULL)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    return SymbolInfoDouble(symbol, SYMBOL_POINT);
}

/**
 * @brief Mendapatkan simbol base currency untuk simbol tertentu
 *
 * @param[in] symbol Simbol yang akan diperiksa (default = simbol saat ini)
 * @return Simbol base currency untuk simbol yang ditentukan
 */
string GetStringPriceSymbolBase(string symbol = NULL)
{
    if (symbol == NULL)
    {
        symbol = _Symbol;
    }
    return SymbolInfoString(symbol, SYMBOL_CURRENCY_BASE);
}
//--- Name of the company
string company = AccountInfoString(ACCOUNT_COMPANY);
//--- Name of the client
string name = AccountInfoString(ACCOUNT_NAME);
//--- Account number
long login = AccountInfoInteger(ACCOUNT_LOGIN);
//--- Name of the server
string server = AccountInfoString(ACCOUNT_SERVER);
//--- Account currency
string currency = AccountInfoString(ACCOUNT_CURRENCY);
//--- Demo, contest or real account
ENUM_ACCOUNT_TRADE_MODE account_type = (ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE);
//--- Now transform the value of  the enumeration into an understandable form

string GetStringAccountType(ENUM_ACCOUNT_TRADE_MODE account_mode = NULL)
{
    if (account_mode == NULL)
    {
        account_mode = account_type;
    }
    string trade_mode;
    switch (account_mode)
    {
    case ACCOUNT_TRADE_MODE_DEMO:
        trade_mode = "demo";
        break;
    case ACCOUNT_TRADE_MODE_CONTEST:
        trade_mode = "contest";
        break;
    default:
        trade_mode = "real";
        break;
    }
    return trade_mode;
}
//--- Stop Out is set in percentage or money
ENUM_ACCOUNT_STOPOUT_MODE stop_out_mode = (ENUM_ACCOUNT_STOPOUT_MODE)AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE);
//--- Get the value of the levels when Margin Call and Stop Out occur
double margin_call = AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL);
double stop_out = AccountInfoDouble(ACCOUNT_MARGIN_SO_SO);

#endif
