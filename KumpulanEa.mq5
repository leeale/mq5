#include <Trade/Trade.mqh>        // Library untuk operasi trading
#include <Trade/PositionInfo.mqh> // Library untuk mengelola posisi

CTrade trade;      // Objek untuk operasi trading
CPositionInfo pos; // Objek untuk mendapatkan informasi posisi

// Input parameter
input double ProfitTrigger = 10.0;    // Profit trigger dalam mata uang akun
input double BufferPips = 2.0;        // Buffer untuk Break-Even (pip)
input double MinimalStopLoss = 5.0;   // Minimal Stop Loss jika modifikasi gagal (pip)
input string TargetSymbol = "EURUSD"; // Simbol target

// Fungsi untuk mengatur Break-Even dengan fallback Stop Loss
void SetBreakEven(string symbol, double profitTrigger, double buffer, double minimalStopLoss)
{
   // Iterasi semua posisi
   for (int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if (!pos.SelectByIndex(i)) // Pilih posisi berdasarkan indeks
         continue;

      // Hanya proses posisi pada simbol yang sesuai
      if (pos.Symbol() != symbol)
         continue;

      // Informasi simbol dan nilai point
      string positionSymbol = pos.Symbol();
      double point = SymbolInfoDouble(positionSymbol, SYMBOL_POINT); // Nilai _Point untuk simbol posisi

      // Informasi posisi
      ulong ticket = pos.Ticket();
      double openPrice = pos.PriceOpen();
      double currentProfit = pos.Profit();
      double stopLoss = pos.StopLoss();
      ENUM_POSITION_TYPE positionType = pos.PositionType();

      // Cek apakah posisi memenuhi syarat profit trigger
      if (currentProfit >= profitTrigger)
      {
         double newStopLoss = 0.0;

         if (positionType == POSITION_TYPE_BUY)
         {
            newStopLoss = openPrice + buffer * point; // Tambahkan buffer
         }
         else if (positionType == POSITION_TYPE_SELL)
         {
            newStopLoss = openPrice - buffer * point; // Tambahkan buffer
         }

         // Update Stop Loss hanya jika belum disetel atau lebih buruk dari Break-Even
         if ((positionType == POSITION_TYPE_BUY && (stopLoss < newStopLoss || stopLoss == 0)) ||
             (positionType == POSITION_TYPE_SELL && (stopLoss > newStopLoss || stopLoss == 0)))
         {
            if (trade.PositionModify(ticket, newStopLoss, pos.TakeProfit()))
            {
               Print("Stop Loss dipindahkan ke Break-Even untuk posisi ", ticket, " pada simbol ", positionSymbol);
            }
            else
            {
               Print("Gagal memodifikasi Stop Loss untuk posisi ", ticket, ". Mencoba set Stop Loss minimal.");

               // Coba atur Stop Loss minimal jika modifikasi gagal
               if (positionType == POSITION_TYPE_BUY)
               {
                  newStopLoss = openPrice - minimalStopLoss * point; // Minimal SL di bawah harga buka
               }
               else if (positionType == POSITION_TYPE_SELL)
               {
                  newStopLoss = openPrice + minimalStopLoss * point; // Minimal SL di atas harga buka
               }

               if (trade.PositionModify(ticket, newStopLoss, pos.TakeProfit()))
               {
                  Print("Stop Loss minimal berhasil disetel untuk posisi ", ticket, " pada simbol ", positionSymbol);
               }
               else
               {
                  Print("Gagal menetapkan Stop Loss minimal untuk posisi ", ticket);
               }
            }
         }
      }
   }
}

// Event handler OnInit
int OnInit()
{
   // Set timer untuk memeriksa posisi secara periodik
   EventSetTimer(60); // Timer setiap 60 detik
   Print("EA diinisialisasi. Timer diaktifkan.");
   return (INIT_SUCCEEDED);
}

// Event handler OnTimer
void OnTimer()
{
   // Periksa posisi dan jalankan Break-Even
   Print("Timer dipanggil. Memeriksa posisi...");
   SetBreakEven(TargetSymbol, ProfitTrigger, BufferPips, MinimalStopLoss);
}

// Event handler OnTick
void OnTick()
{
   // Periksa posisi pada setiap tick
   Print("Tick baru diterima. Memeriksa posisi...");
   SetBreakEven(TargetSymbol, ProfitTrigger, BufferPips, MinimalStopLoss);
}

// Event handler OnDeinit
void OnDeinit(const int reason)
{
   // Hapus timer saat EA dihentikan
   EventKillTimer();
   Print("EA dihentikan. Timer dinonaktifkan.");
}

// Event handler OnEvent
void OnEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   // Tambahkan logika jika ingin memproses event khusus
   Print("Event ID: ", id, ", lparam: ", lparam, ", dparam: ", dparam, ", sparam: ", sparam);
}