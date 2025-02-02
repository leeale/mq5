//+------------------------------------------------------------------+
//| OrderInfo.mqh                                                      |
//| Class for managing order information in MQL5                       |
//+------------------------------------------------------------------+
class COrderInfo
{
private:
    // Order properties
    ulong m_ticket;            // Order ticket
    ulong m_magic;             // Expert Advisor ID (magic number)
    string m_symbol;           // Trading symbol
    int m_type;                // Order type
    double m_volume;           // Order volume
    double m_price;            // Order price
    double m_stopLoss;         // Stop Loss level
    double m_takeProfit;       // Take Profit level
    string m_comment;          // Order comment
    datetime m_timeSetup;      // Order setup time
    datetime m_timeExpiration; // Order expiration time
    int m_state;               // Order state
    // Order properties getters
    int m_totalMarketOrders;  // Total market order (posisi terbuka)
    int m_totalPendingOrders; // Total pending order
    int m_totalBuyOrders;     // Total order beli (market + pending)
    int m_totalSellOrders;    // Total order jual (market + pending)
    string m_currentSymbol;

private:
    // Internal methods
    void Reset();                            // Reset all values
    bool SelectByTicket(const ulong ticket); // Select order by ticket

public:
    // Constructor and destructor
    COrderInfo();
    ~COrderInfo();

    // Main methods
    bool Select(const ulong ticket);
    bool SelectByIndex(const int index);

    // Order properties getters
    ulong Ticket() const { return m_ticket; }
    ulong Magic() const { return m_magic; }
    string Symbol() const { return m_symbol; }
    int Type() const { return m_type; }
    double Volume() const { return m_volume; }
    double Price() const { return m_price; }
    double StopLoss() const { return m_stopLoss; }
    double TakeProfit() const { return m_takeProfit; }
    string Comment() const { return m_comment; }
    datetime TimeSetup() const { return m_timeSetup; }
    datetime TimeExpiration() const { return m_timeExpiration; }
    int State() const { return m_state; }

    // Additional methods
    string TypeDescription() const;
    string StateDescription() const;
    bool IsLong() const;
    bool IsShort() const;
    bool IsBuyOrder() const;
    bool IsSellOrder() const;
    bool IsStopOrder() const;
    bool IsLimitOrder() const;
    bool IsMarketOrder() const;
    bool IsPendingOrder() const;
    double ProfitInPoints() const;
    double StopLossInPoints() const;
    double TakeProfitInPoints() const;

    // Getter untuk total order
    bool UpdateTotals(const string symbol = NULL);
    int TotalMarketOrders() const { return m_totalMarketOrders; }
    int TotalPendingOrders() const { return m_totalPendingOrders; }
    // total order
    int TotalOrders() const;
    int TotalBuyOrders() const { return m_totalBuyOrders; }
    int TotalSellOrders() const { return m_totalSellOrders; }
    void ResetTotals();
    bool HasOrders() const;
};

//+------------------------------------------------------------------+
//| Constructor                                                        |
//+------------------------------------------------------------------+
COrderInfo::COrderInfo()
{
    Reset();
}

//+------------------------------------------------------------------+
//| Destructor                                                         |
//+------------------------------------------------------------------+
COrderInfo::~COrderInfo()
{
}

//+------------------------------------------------------------------+
//| Reset all data                                                     |
//+------------------------------------------------------------------+
void COrderInfo::Reset()
{
    m_ticket = 0;
    m_magic = 0;
    m_symbol = "";
    m_type = -1;
    m_volume = 0.0;
    m_price = 0.0;
    m_stopLoss = 0.0;
    m_takeProfit = 0.0;
    m_comment = "";
    m_timeSetup = 0;
    m_timeExpiration = 0;
    m_state = -1;
}

//+------------------------------------------------------------------+
//| Select order by ticket                                             |
//+------------------------------------------------------------------+
bool COrderInfo::Select(const ulong ticket)
{
    if (!OrderSelect(ticket))
        return false;

    m_ticket = OrderGetInteger(ORDER_TICKET);
    m_magic = OrderGetInteger(ORDER_MAGIC);
    m_symbol = OrderGetString(ORDER_SYMBOL);
    m_type = (int)OrderGetInteger(ORDER_TYPE);
    m_volume = OrderGetDouble(ORDER_VOLUME_INITIAL);
    m_price = OrderGetDouble(ORDER_PRICE_OPEN);
    m_stopLoss = OrderGetDouble(ORDER_SL);
    m_takeProfit = OrderGetDouble(ORDER_TP);
    m_comment = OrderGetString(ORDER_COMMENT);
    m_timeSetup = (datetime)OrderGetInteger(ORDER_TIME_SETUP);
    m_timeExpiration = (datetime)OrderGetInteger(ORDER_TIME_EXPIRATION);
    m_state = (int)OrderGetInteger(ORDER_STATE);

    return true;
}

//+------------------------------------------------------------------+
//| Select order by index                                              |
//+------------------------------------------------------------------+
bool COrderInfo::SelectByIndex(const int index)
{
    ulong ticket = OrderGetTicket(index);
    if (ticket == 0)
        return false;

    return Select(ticket);
}

//+------------------------------------------------------------------+
//| Get order type as string                                           |
//+------------------------------------------------------------------+
string COrderInfo::TypeDescription() const
{
    switch (m_type)
    {
    case ORDER_TYPE_BUY:
        return "buy";
    case ORDER_TYPE_SELL:
        return "sell";
    case ORDER_TYPE_BUY_LIMIT:
        return "buy limit";
    case ORDER_TYPE_SELL_LIMIT:
        return "sell limit";
    case ORDER_TYPE_BUY_STOP:
        return "buy stop";
    case ORDER_TYPE_SELL_STOP:
        return "sell stop";
    case ORDER_TYPE_BUY_STOP_LIMIT:
        return "buy stop limit";
    case ORDER_TYPE_SELL_STOP_LIMIT:
        return "sell stop limit";
    default:
        return "unknown";
    }
}

//+------------------------------------------------------------------+
//| Get order state as string                                          |
//+------------------------------------------------------------------+
string COrderInfo::StateDescription() const
{
    switch (m_state)
    {
    case ORDER_STATE_STARTED:
        return "started";
    case ORDER_STATE_PLACED:
        return "placed";
    case ORDER_STATE_CANCELED:
        return "canceled";
    case ORDER_STATE_PARTIAL:
        return "partial";
    case ORDER_STATE_FILLED:
        return "filled";
    case ORDER_STATE_REJECTED:
        return "rejected";
    case ORDER_STATE_EXPIRED:
        return "expired";
    case ORDER_STATE_REQUEST_ADD:
        return "request add";
    case ORDER_STATE_REQUEST_MODIFY:
        return "request modify";
    case ORDER_STATE_REQUEST_CANCEL:
        return "request cancel";
    default:
        return "unknown";
    }
}

//+------------------------------------------------------------------+
//| Check if order is long                                            |
//+------------------------------------------------------------------+
bool COrderInfo::IsLong() const
{
    return (m_type == ORDER_TYPE_BUY || m_type == ORDER_TYPE_BUY_LIMIT ||
            m_type == ORDER_TYPE_BUY_STOP || m_type == ORDER_TYPE_BUY_STOP_LIMIT);
}

//+------------------------------------------------------------------+
//| Check if order is short                                           |
//+------------------------------------------------------------------+
bool COrderInfo::IsShort() const
{
    return (m_type == ORDER_TYPE_SELL || m_type == ORDER_TYPE_SELL_LIMIT ||
            m_type == ORDER_TYPE_SELL_STOP || m_type == ORDER_TYPE_SELL_STOP_LIMIT);
}

//+------------------------------------------------------------------+
//| Check if order is buy                                             |
//+------------------------------------------------------------------+
bool COrderInfo::IsBuyOrder() const
{
    return m_type == ORDER_TYPE_BUY;
}

//+------------------------------------------------------------------+
//| Check if order is sell                                            |
//+------------------------------------------------------------------+
bool COrderInfo::IsSellOrder() const
{
    return m_type == ORDER_TYPE_SELL;
}

//+------------------------------------------------------------------+
//| Check if order is stop order                                      |
//+------------------------------------------------------------------+
bool COrderInfo::IsStopOrder() const
{
    return (m_type == ORDER_TYPE_BUY_STOP || m_type == ORDER_TYPE_SELL_STOP ||
            m_type == ORDER_TYPE_BUY_STOP_LIMIT || m_type == ORDER_TYPE_SELL_STOP_LIMIT);
}

//+------------------------------------------------------------------+
//| Check if order is limit order                                     |
//+------------------------------------------------------------------+
bool COrderInfo::IsLimitOrder() const
{
    return (m_type == ORDER_TYPE_BUY_LIMIT || m_type == ORDER_TYPE_SELL_LIMIT);
}

//+------------------------------------------------------------------+
//| Check if order is market order                                    |
//+------------------------------------------------------------------+
bool COrderInfo::IsMarketOrder() const
{
    return (m_type == ORDER_TYPE_BUY || m_type == ORDER_TYPE_SELL);
}

//+------------------------------------------------------------------+
//| Check if order is pending order                                   |
//+------------------------------------------------------------------+
bool COrderInfo::IsPendingOrder() const
{
    return (!IsMarketOrder());
}

//+------------------------------------------------------------------+
//| Calculate profit in points                                        |
//+------------------------------------------------------------------+
double COrderInfo::ProfitInPoints() const
{
    if (m_symbol == "")
        return 0.0;

    double point = SymbolInfoDouble(m_symbol, SYMBOL_POINT);
    if (point == 0)
        return 0.0;

    double currentPrice = IsLong() ? SymbolInfoDouble(m_symbol, SYMBOL_BID)
                                   : SymbolInfoDouble(m_symbol, SYMBOL_ASK);

    return (IsLong() ? currentPrice - m_price : m_price - currentPrice) / point;
}

//+------------------------------------------------------------------+
//| Calculate StopLoss in points                                      |
//+------------------------------------------------------------------+
double COrderInfo::StopLossInPoints() const
{
    if (m_stopLoss == 0 || m_symbol == "")
        return 0.0;

    double point = SymbolInfoDouble(m_symbol, SYMBOL_POINT);
    if (point == 0)
        return 0.0;

    return MathAbs(m_price - m_stopLoss) / point;
}

//+------------------------------------------------------------------+
//| Calculate TakeProfit in points                                    |
//+------------------------------------------------------------------+
double COrderInfo::TakeProfitInPoints() const
{
    if (m_takeProfit == 0 || m_symbol == "")
        return 0.0;

    double point = SymbolInfoDouble(m_symbol, SYMBOL_POINT);
    if (point == 0)
        return 0.0;

    return MathAbs(m_takeProfit - m_price) / point;
}
// Update total untuk symbol tertentu
bool COrderInfo::UpdateTotals(const string symbol = NULL)
{
    ResetTotals();
    m_currentSymbol = symbol;

    // Hitung market orders (posisi terbuka)
    for (int i = 0; i < PositionsTotal(); i++)
    {
        ulong ticket = PositionGetTicket(i);
        if (ticket <= 0)
            continue;

        if (symbol == NULL || symbol == PositionGetString(POSITION_SYMBOL))
        {
            m_totalMarketOrders++;

            if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                m_totalBuyOrders++;
            else if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                m_totalSellOrders++;
        }
    }

    // Hitung pending orders
    for (int i = 0; i < OrdersTotal(); i++)
    {
        ulong ticket = OrderGetTicket(i);
        if (ticket <= 0)
            continue;

        if (symbol == NULL || symbol == OrderGetString(ORDER_SYMBOL))
        {
            m_totalPendingOrders++;
            ENUM_ORDER_TYPE type = (ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE);

            // Check buy orders
            if (type == ORDER_TYPE_BUY_LIMIT ||
                type == ORDER_TYPE_BUY_STOP ||
                type == ORDER_TYPE_BUY_STOP_LIMIT)
            {
                m_totalBuyOrders++;
            }
            // Check sell orders
            else if (type == ORDER_TYPE_SELL_LIMIT ||
                     type == ORDER_TYPE_SELL_STOP ||
                     type == ORDER_TYPE_SELL_STOP_LIMIT)
            {
                m_totalSellOrders++;
            }
        }
    }

    return true;
}

// Get total semua orders (market + pending)
int COrderInfo::TotalOrders() const
{
    return m_totalMarketOrders + m_totalPendingOrders;
}

// Check apakah ada orders
bool COrderInfo::HasOrders() const
{
    return TotalOrders() > 0;
}

// Reset semua total ke 0
void COrderInfo::ResetTotals()
{
    m_totalMarketOrders = 0;
    m_totalPendingOrders = 0;
    m_totalBuyOrders = 0;
    m_totalSellOrders = 0;
}