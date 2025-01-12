#include <Trade/Trade.mqh>        // Library untuk operasi trading
#include <Trade/PositionInfo.mqh> // Library untuk mengelola posisi

CTrade trade;      // Objek untuk operasi trading
CPositionInfo pos; // Objek untuk mendapatkan informasi posisi

// Input parameter
input double ProfitTrigger = 10.0;    // Profit trigger dalam mata uang akun
input double BufferPips = 2.0;        // Buffer untuk Break-Even (pip)
input double MinimalStopLoss = 5.0;   // Minimal Stop Loss jika modifikasi gagal (pip)
input string TargetSymbol = "EURUSD"; // Simbol target




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

struct Pengaturan {
    datetime mulai;
    int nomorBar;
};
 
Pengaturan BuatPengaturan(datetime mulai, int nomorBar) {
    Pengaturan p;
    p.mulai = mulai;
    p.nomorBar = nomorBar;
    return p; // Kembalikan struktur
}
 
struct Pengaturan {
    datetime mulai;
    int nomorBar;
};
 
Pengaturan BuatPengaturan(datetime mulai, int nomorBar) {
    Pengaturan p;
    p.mulai = mulai;
    p.nomorBar = nomorBar;
    return p; // Kembalikan struktur
}
 
void OnStart() {
    Pengaturan p = BuatPengaturan(D'2021.01.01', 1000); // Panggil fungsi dan terima struktur sebagai nilai pengembalian
    Print("Mulai: ", p.mulai, ", Nomor Bar: ", p.nomorBar);
}

struct Pengaturan {
    datetime mulai;
    int nomorBar;
};

void CetakPengaturan(Pengaturan p) {
    Print("Mulai: ", p.mulai, ", Nomor Bar: ", p.nomorBar);
}

void OnStart() {
    Pengaturan p;
    p.mulai = D'2021.01.01';
    p.nomorBar = 1000;
    CetakPengaturan(p); // Memanggil fungsi dengan struktur
}