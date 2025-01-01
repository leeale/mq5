```mermaid
graph TD;
    A[Start] --> B[Ambil CurrentPrice];
    B --> C[Ambil MAValue];
    C --> D{CurrentPrice > MAValue?};
    D -->|Yes| E[Harga di atas MA];
    D -->|No| F[Harga di bawah MA];
    E --> G[Tampilkan Hasil];
    F --> G[Tampilkan Hasil];
    G --> H[End];
```
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
```mermaid
sequenceDiagram
    participant A as User
    participant B as Server
    A->>B: Login Request
    B-->>A: Login Response
    A->>B: Data Request
    B-->>A: Data Response
```
```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD
    section Phase 1
    Task A :a1, 2023-10-01, 7d
    Task B :after a1, 5d
    section Phase 2
    Task C :2023-10-10, 3d
    Task D :after C, 4d
```
```mermaid
%%{init: {'theme': 'forest'}}%%
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
### Penjelasan:
1. **Start**: Mulai proses.
2. **Ambil CurrentPrice**: Ambil harga saat ini.
3. **Ambil MAValue**: Ambil nilai Moving Average.
4. **CurrentPrice > MAValue?**: Bandingkan harga saat ini dengan nilai MA.
   - Jika **Ya**, lanjut ke "Harga di atas MA".
   - Jika **Tidak**, lanjut ke "Harga di bawah MA".
5. **Tampilkan Hasil**: Tampilkan hasil perbandingan.
6. **End**: Akhiri proses.

---

### Implementasi dalam MQL4/MQL5:
Berikut adalah contoh implementasi logika di atas dalam bahasa MQL4/MQL5:


```mermaid
flowchart TD;
    A[Start] --> B[Ambil CurrentPrice];
    B --> C[Ambil MAValue];
    C --> D{CurrentPrice > MAValue?};
    D -->|Yes| E[Harga di atas MA];
    D -->|No| F[Harga di bawah MA];
    E --> G[ORDER BUY];
    F --> H[ORDER SELL];
```
#
```mermaid
flowchart TD;
    A[Start] -->B[INDIKATOR1]; 
    B -->|Yes| C{PROSES};
```