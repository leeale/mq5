//+------------------------------------------------------------------+
//|                                                      CustomMA_EA.mq5 |
//|                        Copyright 2023, Your Name                 |
//|                                       https://www.yourwebsite.com |
//+------------------------------------------------------------------+
input int maPeriod = 14;                  // Period for Moving Average
input ENUM_MA_METHOD maMethod = MODE_SMA; // Type of Moving Average
input double lotSize = 0.1;               // Lot size for trading
input double takeProfit = 50;             // Take profit in points
input double stopLoss = 50;               // Stop loss in points

//+------------------------------------------------------------------+
//| Expert initialization function                                     |
//+------------------------------------------------------------------+
int OnInit()
{
    // Initialization code here
    return (INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                   |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    // Cleanup code here
}

//+------------------------------------------------------------------+
//| Expert tick function                                              |
//+------------------------------------------------------------------+
void OnTick()
{
    double maValue = iMA(Symbol(), maPeriod, 0, maMethod, PRICE_CLOSE, 0);
    double closePrices[2];
    CopyClose(Symbol(), 0, 1, 2, closePrices);

    // Trading logic here
    // Example: Open buy position if price is above MA
    if (Close[1] < maValue && Close[0] > maValue)
    {
        // Check if trading is allowed
        if (IsTradeAllowed())
        {
            // Open buy order
            double price = Ask;
            double sl = price - stopLoss * Point;
            double tp = price + takeProfit * Point;
            OrderSend(Symbol(), OP_BUY, lotSize, price, 3, sl, tp, "Buy Order", 0, 0, clrGreen);
        }
    }
    // Example: Open sell position if price is below MA
    else if (Close[1] > maValue && Close[0] < maValue)
    {
        // Check if trading is allowed
        if (IsTradeAllowed())
        {
            // Open sell order
            double price = Bid;
            double sl = price + stopLoss * Point;
            double tp = price - takeProfit * Point;
            int result = OrderSend(Symbol(), OP_SELL, lotSize, price, 3, sl, tp, "Sell Order", 0, 0, clrRed);
            if (result < 0)
            {
                Print("Error opening sell order: ", GetLastError());
            }
        }
    }
}
//+------------------------------------------------------------------+
