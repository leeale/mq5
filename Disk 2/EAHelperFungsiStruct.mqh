// EAHelperFungsiStruct.mqh
// Struktur dan fungsi helper untuk EA trading

// Ini adalah header guard atau include guard dalam C++, yang memiliki fungsi penting untuk:
// Mencegah multiple inclusion(duplikasi) dari file header yang sama
// Menghindari konflik definisi yang bisa menyebabkan compilation error Cara kerjanya :

// #endif  // Akhir dari conditional compilation letakkan di akhir file

// cara kerja if n def seperti di bawah ini
// Include pertama
/*#ifndef EAHELPERFUNGSISTRUCT_MQH // belum ada → lanjut
#define EAHELPERFUNGSISTRUCT_MQH // didefinisikan
// kode diproses
#endif

// Include kedua
#ifndef EAHELPERFUNGSISTRUCT_MQH // sudah ada → dilewati
// kode tidak diproses lagi
#endif*/

#ifndef EAHELPERFUNGSISTRUCT_MQH
#define EAHELPERFUNGSISTRUCT_MQH

#include <Trade/SymbolInfo.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/AccountInfo.mqh>
#include <Trade/OrderInfo.mqh>

struct SymbolInfo
{
    string symbol;
    double bid;
    double ask;
    double point;
    int digits;
    double spread;
    double lot_step;
    double tick_value;
    double tick_size;
    double contract_size;
    double margin_initial;
    double margin_maintenance;
    datetime time;
};

// Fungsi untuk mengambil informasi symbol lengkap
SymbolInfo GetSymbolInfo(string symbol)
{
    SymbolInfo info;
    CSymbolInfo sym;

    if (sym.Name(symbol))
    {
        info.symbol = symbol;
        info.bid = sym.Bid();
        info.ask = sym.Ask();
        info.point = sym.Point();
        info.digits = sym.Digits();
        info.spread = sym.Spread();
        info.lot_step = sym.LotsStep();
        info.tick_value = sym.TickValue();
        info.tick_size = sym.TickSize();
        info.contract_size = sym.ContractSize();
        info.margin_initial = sym.MarginInitial();
        info.margin_maintenance = sym.MarginMaintenance();
        info.time = TimeCurrent();
    }

    return info;
}
struct PositionInfo
{
    long ticket;
    string symbol;
    int type;
    double volume;
    double price_open;
    double sl;
    double tp;
    double price_current;
    double swap;
    double profit;
    datetime time;
    string comment;
};
// Fungsi untuk mengambil informasi position lengkap
PositionInfo GetPositionInfo(long ticket)
{
    PositionInfo info;
    CPositionInfo pos;

    if (pos.SelectByTicket(ticket))
    {
        info.ticket = ticket;
        info.symbol = pos.Symbol();
        info.type = pos.PositionType();
        info.volume = pos.Volume();
        info.price_open = pos.PriceOpen();
        info.sl = pos.StopLoss();
        info.tp = pos.TakeProfit();
        info.price_current = pos.PriceCurrent();
        info.swap = pos.Swap();
        info.profit = pos.Profit();
        info.time = pos.Time();
        info.comment = pos.Comment();
    }

    return info;
}
struct TradingSession
{
    datetime start;
    datetime end;
    bool is_open;
};

// Fungsi untuk validasi trading session
bool IsTradingSessionOpen(TradingSession &session)
{
    datetime now = TimeCurrent();
    session.is_open = (now >= session.start && now <= session.end);
    return session.is_open;
}

struct OrderInfo
{
    long ticket;
    string symbol;
    int type;
    double volume;
    double price;
    double sl;
    double tp;
    datetime time;
    string comment;
};

// Fungsi untuk mendapatkan informasi order
OrderInfo GetOrderInfo(long ticket)
{
    OrderInfo info;
    COrderInfo ord;

    if (ord.Select(ticket))
    {
        info.ticket = ticket;
        info.symbol = ord.Symbol();
        info.type = ord.OrderType();
        info.volume = ord.VolumeCurrent();
        info.price = ord.PriceOpen();
        info.sl = ord.StopLoss();
        info.tp = ord.TakeProfit();
        info.time = ord.TimeSetup();
        info.comment = ord.Comment();
    }

    return info;
}

// Mengelompokkan beberapa data terkait dalam satu struktur
struct SymbolInfo2
{
    string symbol; // nama simbol
    double bid;    // harga bid
    double ask;    // harga ask
    double point;  // nilai point
    int digits;    // jumlah digit
    // ... data lainnya
};
#endif
