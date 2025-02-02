#include <Trade/Trade.mqh>
#include <ChartObjects/ChartObjectsTxtControls.mqh>

#property strict

enum CloseMethod
{
    CLOSE_BY_DOLLAR,
    CLOSE_BY_POINTS
};
CTrade trade;

// Variabel untuk status boolean
bool isFeatureEnabled = false;

// Fungsi untuk menggambar tombol di chart
void CreateButtons()
{
    // Menghapus tombol jika sudah ada
    ObjectDelete(0, "ButtonOn");
    ObjectDelete(0, "ButtonOff");

    // Membuat tombol ON
    if (!ObjectCreate(0, "ButtonOn", OBJ_BUTTON, 0, 0, 0))
    {
        Print("Error creating ButtonOn: ", GetLastError());
    }
    ObjectSetInteger(0, "ButtonOn", OBJPROP_XSIZE, 100);
    ObjectSetInteger(0, "ButtonOn", OBJPROP_YSIZE, 30);
    ObjectSetInteger(0, "ButtonOn", OBJPROP_XDISTANCE, 10);
    ObjectSetInteger(0, "ButtonOn", OBJPROP_YDISTANCE, 10);
    ObjectSetString(0, "ButtonOn", OBJPROP_TEXT, "Enable Feature");
    ObjectSetInteger(0, "ButtonOn", OBJPROP_COLOR, clrGreen);
    ObjectSetInteger(0, "ButtonOn", OBJPROP_FONTSIZE, 12);

    // Membuat tombol OFF
    if (!ObjectCreate(0, "ButtonOff", OBJ_BUTTON, 0, 0, 0))
    {
        Print("Error creating ButtonOff: ", GetLastError());
    }
    ObjectSetInteger(0, "ButtonOff", OBJPROP_XSIZE, 100);
    ObjectSetInteger(0, "ButtonOff", OBJPROP_YSIZE, 30);
    ObjectSetInteger(0, "ButtonOff", OBJPROP_XDISTANCE, 120);
    ObjectSetInteger(0, "ButtonOff", OBJPROP_YDISTANCE, 10);
    ObjectSetString(0, "ButtonOff", OBJPROP_TEXT, "Disable Feature");
    ObjectSetInteger(0, "ButtonOff", OBJPROP_COLOR, clrRed);
    ObjectSetInteger(0, "ButtonOff", OBJPROP_FONTSIZE, 12);
}

// Fungsi untuk menangani klik tombol
void OnButtonClick(string buttonName)
{
    if (buttonName == "ButtonOn")
    {
        isFeatureEnabled = true;
        Print("Feature enabled.");
    }
    else if (buttonName == "ButtonOff")
    {
        isFeatureEnabled = false;
        Print("Feature disabled.");
    }
}

// Fungsi untuk menangani event chart
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    if (id == CHARTEVENT_OBJECT_CLICK)
    {
        OnButtonClick(sparam);
    }
}

// Fungsi untuk menutup semua posisi berdasarkan persentase dari total profit
void CloseAllByPercentage(double percentage)
{
    double totalProfit = 0;

    // Hitung total profit dari semua posisi terbuka
    for (int i = 0; i < PositionsTotal(); i++)
    {
        if (PositionSelect(_Symbol))
        {
            totalProfit += PositionGetDouble(POSITION_PROFIT);
        }
    }

    // Hitung batas profit berdasarkan persentase
    double targetProfit = totalProfit * (percentage / 100.0);

    // Tutup semua posisi jika total profit mencapai batas
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (PositionSelect(_Symbol))
        {
            double profit = PositionGetDouble(POSITION_PROFIT);
            ulong ticket = PositionGetInteger(POSITION_TICKET);

            if (profit >= targetProfit)
            {
                trade.PositionClose(ticket);
            }
        }
    }
}

// Fungsi untuk membuka order secara bergantian (buy dan sell)
void OpenAlternatingOrders(string symbol, double lotSize, int numberOfOrders)
{
    for (int i = 0; i < numberOfOrders; i++)
    {
        if (i % 2 == 0) // Jika i genap, buka order buy
        {
            trade.Buy(lotSize, symbol, 0, 0, 0, "Buy Order");
        }
        else // Jika i ganjil, buka order sell
        {
            trade.Sell(lotSize, symbol, 0, 0, 0, "Sell Order");
        }
    }
}

// Fungsi untuk mengatur trailing stop
void SetTrailingStop(string symbol, double trailingStopDistance)
{
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (PositionSelect(i)) // Memilih posisi berdasarkan indeks
        {
            double currentPrice = SymbolInfoDouble(symbol, SYMBOL_BID);
            double orderOpenPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            ulong ticket = PositionGetInteger(POSITION_TICKET);
            double stopLoss = PositionGetDouble(POSITION_SL);

            // Menghitung level stop loss baru
            double newStopLoss = currentPrice - trailingStopDistance;

            // Hanya mengatur trailing stop jika harga saat ini lebih tinggi dari harga buka
            if (currentPrice > orderOpenPrice && newStopLoss > stopLoss)
            {
                trade.PositionModify(ticket, newStopLoss, 0);
            }
        }
    }
}

// Fungsi untuk menutup semua posisi berdasarkan metode yang dipilih
void CloseAllPositions(CloseMethod method, double value)
{
    for (int i = PositionsTotal() - 1; i >= 0; i--)
    {
        if (PositionSelect(i)) // Memilih posisi berdasarkan indeks
        {
            double profit = PositionGetDouble(POSITION_PROFIT);
            ulong ticket = PositionGetInteger(POSITION_TICKET);
            string symbol = PositionGetString(POSITION_SYMBOL);
            double Point = SymbolInfoDouble(symbol, SYMBOL_POINT);

            if (method == CLOSE_BY_DOLLAR && profit >= value)
            {
                trade.PositionClose(ticket);
            }
            else if (method == CLOSE_BY_POINTS && profit >= value * Point)
            {
                trade.PositionClose(ticket);
            }
        }
    }
}

// Fungsi untuk mengelola grid trading
void ManageGrid(string symbol, double gridDistance, double lotSize, int maxLevels, double takeProfit)
{
    double currentPrice = SymbolInfoDouble(symbol, SYMBOL_BID);
    int totalOrders = 0;

    // Hitung jumlah order yang sudah terbuka
    for (int i = 0; i < PositionsTotal(); i++)
    {
        if (PositionSelect(i) && PositionGetString(POSITION_SYMBOL) == symbol)
        {
            totalOrders++;
        }
    }

    // Jika belum ada order, buka order pertama
    if (totalOrders == 0)
    {
        trade.Buy(lotSize, symbol, currentPrice, 0, 0, "Grid Order");
    }
    else
    {
        // Periksa apakah harga telah mencapai jarak grid untuk membuka order baru
        double lastOrderPrice = PositionGetDouble(POSITION_PRICE_OPEN);
        if (currentPrice <= lastOrderPrice - gridDistance)
        {
            if (totalOrders < maxLevels)
            {
                trade.Buy(lotSize, symbol, currentPrice, 0, 0, "Grid Order");
            }
        }
    }

    // Mengelola posisi yang sudah ada
    for (int i = 0; i < PositionsTotal(); i++)
    {
        if (PositionSelect(i) && PositionGetString(POSITION_SYMBOL) == symbol)
        {
            double orderProfit = PositionGetDouble(POSITION_PROFIT);
            if (orderProfit >= takeProfit)
            {
                ulong ticket = PositionGetInteger(POSITION_TICKET);
                trade.PositionClose(ticket);
            }
        }
    }
}
