class CTradingTools
{
private:
    double stopLoss;
    double takeProfit;
    int magicNumber;
    string symbol;
    double lotSize;

    // New private members
    double riskPercent;     // Risk per trade in percentage
    double maxSpread;       // Maximum allowed spread
    int slippage;           // Maximum allowed slippage
    bool isTrailingStop;    // Trailing stop flag
    int trailingPoints;     // Trailing stop points
    int breakEvenPoints;    // Break even points
    int breakEvenProfit;    // Break even profit
    datetime lastTradeTime; // Time of last trade
    int minBarsBeforeTrade; // Minimum bars between trades

    // Trade statistics
    int totalTrades;
    int winningTrades;
    int losingTrades;
    double grossProfit;
    double grossLoss;

public:
    CTradingTools(string _symbol = NULL,
                  double _lotSize = 0.1,
                  int _magicNumber = 12345,
                  double _riskPercent = 1.0,
                  double _maxSpread = 0.0,
                  int _slippage = 10)
    {
        symbol = _symbol == NULL ? Symbol() : _symbol;
        lotSize = _lotSize;
        magicNumber = _magicNumber;
        riskPercent = _riskPercent;
        maxSpread = _maxSpread;
        slippage = _slippage;

        // Initialize other members
        isTrailingStop = false;
        trailingPoints = 0;
        breakEvenPoints = 0;
        breakEvenProfit = 0;
        lastTradeTime = 0;
        minBarsBeforeTrade = 1;

        ResetStatistics();
    }
    // Risk Management Methods
    double CalculateLotSize(double stopLossPoints)
    {
        double accountBalance = AccountInfoDouble(ACCOUNT_BALANCE);
        double riskAmount = accountBalance * riskPercent / 100;
        double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
        double calculatedLot = NormalizeDouble(riskAmount / (stopLossPoints * tickValue), 2);

        double minLot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
        double maxLot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);

        return MathMin(MathMax(calculatedLot, minLot), maxLot);
    }

    bool IsSpreadOK()
    {
        if (maxSpread <= 0)
            return true;
        double currentSpread = SymbolInfoInteger(symbol, SYMBOL_SPREAD) * Point();
        return currentSpread <= maxSpread;
    }

    // Enhanced Trading Methods
    bool OpenBuyWithRisk(double slPoints, string comment = "")
    {
        if (!IsSpreadOK())
            return false;
        if (!CheckTimeInterval())
            return false;

        lotSize = CalculateLotSize(slPoints);
        return OpenBuy(comment);
    }

    bool OpenSellWithRisk(double slPoints, string comment = "")
    {
        if (!IsSpreadOK())
            return false;
        if (!CheckTimeInterval())
            return false;

        lotSize = CalculateLotSize(slPoints);
        return OpenSell(comment);
    }

    // Position Management
    void UpdateTrailingStop()
    {
        if (!isTrailingStop || trailingPoints <= 0)
            return;

        for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            if (!PositionSelectByTicket(PositionGetTicket(i)))
                continue;
            if (PositionGetInteger(POSITION_MAGIC) != magicNumber)
                continue;

            double currentSL = PositionGetDouble(POSITION_SL);
            double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);

            if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            {
                double newSL = NormalizeDouble(currentPrice - trailingPoints * Point(), Digits());
                if (newSL > currentSL)
                {
                    ModifyPosition(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP));
                }
            }
            else
            {
                double newSL = NormalizeDouble(currentPrice + trailingPoints * Point(), Digits());
                if (newSL < currentSL || currentSL == 0)
                {
                    ModifyPosition(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP));
                }
            }
        }
    }

    void UpdateBreakEven()
    {
        if (breakEvenPoints <= 0 || breakEvenProfit <= 0)
            return;

        for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            if (!PositionSelectByTicket(PositionGetTicket(i)))
                continue;
            if (PositionGetInteger(POSITION_MAGIC) != magicNumber)
                continue;

            double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
            double currentSL = PositionGetDouble(POSITION_SL);

            if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            {
                if (currentPrice >= openPrice + breakEvenProfit * Point())
                {
                    double newSL = NormalizeDouble(openPrice + breakEvenPoints * Point(), Digits());
                    if (newSL > currentSL)
                    {
                        ModifyPosition(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP));
                    }
                }
            }
            else
            {
                if (currentPrice <= openPrice - breakEvenProfit * Point())
                {
                    double newSL = NormalizeDouble(openPrice - breakEvenPoints * Point(), Digits());
                    if (newSL < currentSL || currentSL == 0)
                    {
                        ModifyPosition(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP));
                    }
                }
            }
        }
    }

    // Statistics Methods
    void UpdateStatistics(double profit)
    {
        totalTrades++;
        if (profit > 0)
        {
            winningTrades++;
            grossProfit += profit;
        }
        else
        {
            losingTrades++;
            grossLoss += MathAbs(profit);
        }
    }

    void ResetStatistics()
    {
        totalTrades = 0;
        winningTrades = 0;
        losingTrades = 0;
        grossProfit = 0;
        grossLoss = 0;
    }

    // Setters
    void SetTrailingStop(bool enable, int points = 0)
    {
        isTrailingStop = enable;
        trailingPoints = points;
    }

    void SetBreakEven(int points, int profit)
    {
        breakEvenPoints = points;
        breakEvenProfit = profit;
    }

    void SetTimeInterval(int bars)
    {
        minBarsBeforeTrade = bars;
    }

    // Symbol management methods
    bool SetSymbol(string newSymbol)
    {
        if (newSymbol == "")
            return false;

        // Try to select symbol in Market Watch
        if (!SymbolSelect(newSymbol, true))
        {
            Print("Error: Cannot select symbol ", newSymbol);
            return false;
        }

        // Verify symbol exists and is available for trading
        if (!SymbolInfoInteger(newSymbol, SYMBOL_SELECT))
        {
            Print("Error: Symbol ", newSymbol, " is not available");
            return false;
        }

        symbol = newSymbol;
        return true;
    }

    string GetSymbol()
    {
        return symbol;
    }

    // Get symbol properties
    double GetPipValue()
    {
        return SymbolInfoDouble(symbol, SYMBOL_POINT);
    }

    double GetMinLot()
    {
        return SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
    }

    double GetMaxLot()
    {
        return SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
    }

    double GetCurrentSpread()
    {
        return SymbolInfoInteger(symbol, SYMBOL_SPREAD) * Point();
    }

    // Original methods remain the same...
    // [Previous methods from the original class continue here]

    // Enhanced symbol validation
    bool IsSymbolValid()
    {
        if (symbol == "")
            return false;

        return SymbolInfoInteger(symbol, SYMBOL_SELECT) != 0;
    }

    // Get current symbol bid price
    double GetBid()
    {
        return SymbolInfoDouble(symbol, SYMBOL_BID);
    }

    // Get current symbol ask price
    double GetAsk()
    {
        return SymbolInfoDouble(symbol, SYMBOL_ASK);
    }

    // Helper Methods
private:
    bool CheckTimeInterval()
    {
        if (minBarsBeforeTrade <= 1)
            return true;

        datetime currentTime = TimeCurrent();
        if (currentTime - lastTradeTime < PeriodSeconds(PERIOD_CURRENT) * minBarsBeforeTrade)
        {
            return false;
        }

        lastTradeTime = currentTime;
        return true;
    }

    bool ModifyPosition(ulong ticket, double sl, double tp)
    {
        MqlTradeRequest request = {};
        MqlTradeResult result = {};

        request.action = TRADE_ACTION_SLTP;
        request.position = ticket;
        request.symbol = symbol;
        request.sl = sl;
        request.tp = tp;

        return OrderSend(request, result);
    }
    // Open Buy Position
    bool OpenBuy(string comment = "")
    {
        MqlTradeRequest request = {};
        MqlTradeResult result = {};

        request.action = TRADE_ACTION_DEAL;
        request.symbol = symbol;
        request.volume = lotSize;
        request.type = ORDER_TYPE_BUY;
        request.price = SymbolInfoDouble(symbol, SYMBOL_ASK);
        request.deviation = 10;
        request.magic = magicNumber;
        request.comment = comment;

        if (stopLoss > 0)
            request.sl = NormalizeDouble(request.price - stopLoss * Point(), Digits());

        if (takeProfit > 0)
            request.tp = NormalizeDouble(request.price + takeProfit * Point(), Digits());

        return OrderSend(request, result);
    }

    // Open Sell Position
    bool OpenSell(string comment = "")
    {
        MqlTradeRequest request = {};
        MqlTradeResult result = {};

        request.action = TRADE_ACTION_DEAL;
        request.symbol = symbol;
        request.volume = lotSize;
        request.type = ORDER_TYPE_SELL;
        request.price = SymbolInfoDouble(symbol, SYMBOL_BID);
        request.deviation = 10;
        request.magic = magicNumber;
        request.comment = comment;

        if (stopLoss > 0)
            request.sl = NormalizeDouble(request.price + stopLoss * Point(), Digits());

        if (takeProfit > 0)
            request.tp = NormalizeDouble(request.price - takeProfit * Point(), Digits());

        return OrderSend(request, result);
    }

    // Set Stop Loss and Take Profit in points
    void SetStopLossTakeProfit(double _stopLoss, double _takeProfit)
    {
        stopLoss = _stopLoss;
        takeProfit = _takeProfit;
    }

    // Close All Positions
    void CloseAllPositions()
    {
        for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            ulong ticket = PositionGetTicket(i);
            if (ticket <= 0)
                continue;

            if (!PositionSelectByTicket(ticket))
                continue;

            if (PositionGetInteger(POSITION_MAGIC) != magicNumber)
                continue;

            MqlTradeRequest request = {};
            MqlTradeResult result = {};

            request.action = TRADE_ACTION_DEAL;
            request.position = ticket;
            request.symbol = PositionGetString(POSITION_SYMBOL);
            request.volume = PositionGetDouble(POSITION_VOLUME);
            request.deviation = 10;
            request.magic = magicNumber;

            if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            {
                request.price = SymbolInfoDouble(symbol, SYMBOL_BID);
                request.type = ORDER_TYPE_SELL;
            }
            else
            {
                request.price = SymbolInfoDouble(symbol, SYMBOL_ASK);
                request.type = ORDER_TYPE_BUY;
            }

            // OrderSend(request, result);
        }
    }

    // Check if we have open positions
    bool HasOpenPositions()
    {
        for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            ulong ticket = PositionGetTicket(i);
            if (ticket <= 0)
                continue;

            if (!PositionSelectByTicket(ticket))
                continue;

            if (PositionGetInteger(POSITION_MAGIC) == magicNumber)
                return true;
        }
        return false;
    }

    // Modify lot size
    void SetLotSize(double _lotSize)
    {
        lotSize = _lotSize;
    }
};

// Dalam Expert Advisor:
CTradingTools trader; // Buat instance

void OnTick()
{
    trader.SetSymbol("GBPUSD"); // Set symbol
}