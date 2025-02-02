
struct Mahasiswa
{
    string nama;
    int umur;
};
class ClassInduk
{
private:
    Mahasiswa mahasiswa;
    int data[];

public:
    ClassInduk(/* args */)
    {
        Print("constructor");
        // mahasiswa.nama = "ali";
        // mahasiswa.umur = 20;
    }
    ~ClassInduk()
    {
        Print("destructor");
        // mahasiswa.nama = "";
        // mahasiswa.umur = 0;
        // Print(mahasiswa.nama);
        // Print(mahasiswa.umur);
    }
    void setmahasiswa(string nama, int umur)
    {
        mahasiswa.nama = nama;
        mahasiswa.umur = umur;
    }
    Mahasiswa getmahasiswa()
    {
        return mahasiswa;
    }
};
