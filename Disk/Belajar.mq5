#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

// Define global variables for data storage
struct TradeData
{
    double openPrice;
    double stopLoss;
    double takeProfit;
    int magicNumber;
    datetime openTime;
};

// Array to store multiple trade data
TradeData tradeHistory[];

// Custom function to save trade data
void SaveTradeData(double price, double sl, double tp)
{
    int size = ArraySize(tradeHistory);
    ArrayResize(tradeHistory, size + 1);

    tradeHistory[size].openPrice = price;
    tradeHistory[size].stopLoss = sl;
    tradeHistory[size].takeProfit = tp;
    tradeHistory[size].openTime = TimeCurrent();
    tradeHistory[size].magicNumber = MathRand();
}

// Function to implement your trading logic
bool ExecuteTradeLogic()
{
    double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
    double stopLoss = currentPrice - 100 * Point();
    double takeProfit = currentPrice + 200 * Point();

    // Your trading algorithm here
    if (true)
    {
        SaveTradeData(currentPrice, stopLoss, takeProfit);
        return true;
    }
    return false;
}

int OnInit()
{
    EventSetTimer(60);
    ArrayResize(tradeHistory, 0); // Initialize array
    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    EventKillTimer();
    // Clean up data if needed
    ArrayFree(tradeHistory);
}

void OnTick()
{
    // Implement your main trading logic here
    if (ExecuteTradeLogic())
    {
        // Additional actions after successful trade
    }
}