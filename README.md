# Hotel Booking Analysis
Proyek ini bertujuan untuk mengevaluasi performa penjualan dan memahami perilaku pelanggan pada industri perhotelan. Analisis ini memberikan insight strategis terkait tren pendapatan, segmentasi pelanggan, serta preferensi layanan, yang dapat digunakan untuk meningkatkan pendapatan dan kepuasan pelanggan.

## Pengantar
Industri perhotelan menghadapi persaingan yang ketat, di mana keberhasilan sangat dipengaruhi oleh strategi harga, efektivitas channel penjualan, dan kepuasan pelanggan. Melalui analisis data penjualan dan perilaku pelanggan, manajemen hotel dapat mengidentifikasi tren pendapatan, segmen pelanggan yang paling menguntungkan, preferensi metode pembayaran, serta faktor yang membentuk pengalaman tamu. Insight ini menjadi dasar untuk merancang strategi pemasaran yang lebih tepat sasaran, mengoptimalkan operasional, dan meningkatkan daya saing bisnis secara berkelanjutan.

## Tujuan
Proyek ini bertujuan untuk mengevaluasi performa penjualan dan memahami perilaku pelanggan pada industri perhotelan. Analisis ini memberikan insight strategis terkait tren pendapatan, segmen pelanggan, serta preferensi layanan, yang dapat digunakan untuk meningkatkan pendapatan dan kepuasan pelanggan.

## Dataset
Data yang digunakan dalam analisis ini berasal dari dataset transaksi hotel tahun 2024 yang diperoleh dari Kaggle. Dataset tersebut terdiri dari 6.050 baris dan 36 kolom, namun dalam analisis ini hanya digunakan 23 kolom, yaitu:
<div align="center">

| Column Name      | Data Type |
|------------------|-----------|
| Hotel Name       | Varchar   |
| Types            | Varchar   |
| Customer Name    | Varchar   |
| Customer Rating  | Double    |
| Membership       | Varchar   |
| Payment Method   | Varchar   |
| Meal             | Varchar   |
| Customer Segment | Varchar   |
| Room Type        | Varchar   |
| Booking Channel  | Varchar   |
| Price            | Integer   |
| Night            | Integer   |
| Gross            | Integer   |
| Discount         | Decimal   |
| Sales            | Integer   |
| Arrivel Date     | Date      |
| Departure Date   | Date      |
| ADR              | Integer   |
| Customer Review  | Varchar   |

</div>

## Tools
Tools yang digunakan dalam analisis ini diantaranya, yaitu:
- MySQL (data cleaning dan exploratory data analysis (EDA))
- Microsoft PowerBI (visualisasi dan dashboard interaktif)

## Data Preparation
1. Menghapus kolom yang tidak digunakan, diantaranya yaitu reg, state, phone_no, emel, rep_guest, prev_cancel, card_no, resv_status, assgn_room, adult, child, package_, disc_amt, dep, D_S, sales person, pos, dan comm_pay.
2. Mengubah nama kolom agar lebih mudah dibaca dan konsisten, misalnya:
   - ï»¿Hotel_Name menjadi Hotel_Name
   - Types menjadi Hotel_Types
   - Cus_Name menjadi Customer_Name
   - Room-Type menjadi Room_Type
   - Cus_Seg mnjadi Customer_Segment
   - Dis_Channel menjadi Booking_Channel
3. Membersihkan data teks, diantaranya:
   - Menghapus spasi berlebih pada kolom hotel_types, room_type, price, gross, dan sales
   - Menghapus tanda koma pada angka di kolom price, gross, dan sales agar bisa dikonversi ke format numerik.
   - Melakukan standarisasi nama hotel:
     - Le MÃ©ridien, Sabah menjadi Le Meridien
     - Lexis Suites, Penang menjadi Lexis Suites
     - The Hilton, Kuala Lumpur menjadi The Hilton
   - Melakukan standarisasi pada kolom meal
     - BB = Bed & Breakfast
     - FB = Full Board
     - HB = Half Board
     - SC = Self Catering
   - Melakukan standarisasi pada kolom membership: N/A menjadi None
4. Mengubah format data kolom
   - Mengubah data diskon dari string (xx%) menjadi tipe numerik desimal.
   - Mengubah tipe data Price, Gross, dan Sales menjadi integer.
   - Mengubah Arrival_Date dan Depature_Date dikonversi menjadi tipe date
   - Menambahkan kolom Month_Arrival untuk menyimpan nama bulan dari tanggal kedatangan.

## Struktur Analisis
### 1. Sales Analysis
Tujuan dari analisis ini adalah untuk menilai kinerja penjualan hotel berdasarkan pendapatan, tipe kamar, channel booking, dan metode pembayaran. Hasil analisis ini dapat membantu mengevaluasi efektivitas strategi penjualan yang diterapkan serta memberikan insight untuk mengoptimalkan harga, promosi, dan manajemen channel dalam rangka meningkatkan pertumbuhan revenue/pendapatan.

### 2. Customer Analysis
Analisis ini berfokus pada perilaku pelanggan dengan melakukan segmentasi berdasarkan pola pemesanan, membership, dan tingkat kepuasan. Hasil analisis memberikan gambaran mengenai preferensi pembelian, loyalitas, serta profitabilitas dari berbagai segmen pelanggan, sehingga hotel dapat menyesuaikan layanan, meningkatkan pengalaman tamu, dan memperkuat hubungan jangka panjang dengan pelanggan.

## Exploratory Data Analysis (EDA)
### Sales Analysis
#### 1. Bagaimana tren bulanan total revenue per hotel, dan bagaimana perbedaan revenue antar-hotel sepanjang tahun?
<div align="center">
<img width="784" height="261" alt="image" src="https://github.com/user-attachments/assets/563ab356-9f36-4091-a543-2b54345511e1" />
</div>

Revenue ketiga hotel menunjukkan pola musiman dengan puncak pada Juni–Juli dan penurunan signifikan di April serta Oktober. Le Meridien konsisten unggul sepanjang tahun, mencerminkan daya tarik pasar yang stabil. Lexis Suites mencatat lonjakan tertinggi pada Juli (RM2.130.747), namun turun tajam pada bulan berikutnya sehingga mengindikasikan fluktuasi permintaan yang besar. Sementara itu, The Hilton hanya unggul pada beberapa bulan awal dan pertengahan tahun, namun secara keseluruhan tetap berada di bawah Le Meridien.

#### 2. Bagaimana  tren bulanan Average Daily Rate (ADR) masing-masing hotel?
<div align="center">
<img width="788" height="263" alt="image" src="https://github.com/user-attachments/assets/b1c77bc4-f2de-4f65-9bd9-574352e01c00" />
</div>

Average Daily Rate (ADR) ketiga hotel menunjukkan pola musiman yang berbeda. Le Meridien cenderung stabil di level menengah-tinggi dan mencapai puncaknya pada bulan Oktober, menegaskan citranya sebagai hotel premium. Lexis Suites mengalami naik-turun yang tajam, misalnya melonjak tinggi di bulan April (sekitar RM93) lalu turun drastis di bulan berikutnya. Sementara itu, The Hilton lebih konsisten dengan harga relatif lebih rendah dibanding dua hotel lainnya, menunjukkan strategi menjaga volume pelanggan melalui harga yang lebih terjangkau.

#### 3. Room type mana yang memberikan kontribusi terbesar terhadap total revenue untuk masing-masing hotel?
<div align="center">
<img width="635" height="335" alt="image" src="https://github.com/user-attachments/assets/6348ae04-dc57-4a42-942c-dd1326b50a3a" />
</div>

Studio Room memberikan kontribusi terbesar di semua hotel dengan nilai tertinggi di The Hilton (RM7,2M), diikuti Lexis Suites (RM7,1M) dan Le Meridien (RM6,8M). Deluxe Room konsisten berada di posisi kedua dengan kontribusi sekitar RM4,3–4,6M, sedangkan Single Room menyumbang pendapatan moderat di kisaran RM2,7–2,9M. Royal Suite selalu berada di posisi terbawah (< RM1,6M), sehingga perlu strategi promosi khusus agar kontribusinya meningkat.

#### 4. Channel booking mana yang paling banyak digunakan  untuk melakukan reservasi hotel?
<div align="center">
<img width="509" height="336" alt="image" src="https://github.com/user-attachments/assets/c92c5112-c43a-4371-b47a-696e04b4d8ab" />
</div>

Distribusi total booking menunjukkan kontribusi yang relatif seimbang antara Booking.com (34,60%), Agoda (33,24%), dan pemesanan langsung atau direct (32,17%). Kondisi ini menandakan tidak ada ketergantungan yang dominan pada satu channel, sehingga hotel memiliki fleksibilitas dalam strategi distribusi.

#### 5. Bagaimana distribusi total revenue berdasarkan metode pembayaran, serta metode pembayaran mana yang memberikan kontribusi paling besar terhadap total revenue?
<div align="center">
<img width="509" height="336" alt="image" src="https://github.com/user-attachments/assets/f3715252-f6d8-40d9-84f3-4a66835f0d3c" />
</div>

Analisis metode pembayaran menunjukkan bahwa revenue hotel cukup seimbang di tiga metode, dengan kartu kredit sedikit lebih unggul (36,29%). Online transfer (32,24%) dan cash (31,47%) juga hampir sama besar, sehingga pelanggan punya preferensi yang beragam. Hal ini menandakan pentingnya tetap menyediakan pilihan pembayaran yang fleksibel, sambil memanfaatkan kartu kredit untuk program loyalitas atau promo khusus.

#### Dashbaord Summary
![Dashboard Hotel Github_1](https://github.com/user-attachments/assets/054a6f61-4264-4b5a-a79a-5864cf0fe9d8)

### Customer Analysis
#### 1. Bagaimana tren bulanan total customer per hotel sepanjang tahun?
<div align="center">
<img width="613" height="237" alt="image" src="https://github.com/user-attachments/assets/07e89612-8992-4a7a-907b-87c4967a305b" />
</div>

Lexis Suites mengalami lonjakan signifikan pada Maret (228 customer) dan Juli (238 customer), namun turun tajam pada April (125 customer) dan Oktober (142 customer), sehingga menunjukkan ketergantungan pada periode tertentu. The Hilton relatif lebih stabil sepanjang tahun, dengan puncak pada Maret (213 customer) dan Juli (205 customer), serta titik terendah pada April (120 customer). Sementara itu, Le Meridien menampilkan distribusi yang lebih merata, meskipun tetap mencatat puncak pada Maret (210 customer) dan September (195 customer), serta penurunan pada April (136 customer).

#### 2. Bagaimana perbedaan total booking dan total revenue pada tiap segmen customer (Corporate, Family, Individual)?
<div align="center">
<img width="509" height="336" alt="image" src="https://github.com/user-attachments/assets/a167a961-92bc-4ec8-a148-5a02158c6aac" />
</div>
Segmen Corporate mendominasi dengan kontribusi terbesar sebesar 44,17%, menunjukkan bahwa pelanggan perusahaan merupakan pasar utama bagi hotel. Segmen Individual menyusul dengan 30,21% yang mencerminkan tingginya permintaan untuk perjalanan pribadi, sedangkan segmen Family menyumbang 25,62%.

<div align="center">
<img width="509" height="336" alt="image" src="https://github.com/user-attachments/assets/caf82a20-573c-4fb3-8fad-fdd7bfa1c372" />
</div>
Segmen Corporate memberikan kontribusi revenue terbesar sebesar RM17 juta (35,34%), menegaskan bahwa pelanggan perusahaan merupakan sumber pendapatan utama hotel. Segmen Family menyusul dengan RM16 juta (33,40%), menunjukkan bahwa perjalanan keluarga juga menjadi pilar penting dalam pemasukan. Sementara itu, segmen Individual menyumbang RM15 juta (31,26%), mencerminkan adanya potensi pasar personal traveler yang cukup besar meski kontribusinya sedikit lebih rendah dibanding dua segmen lainnya.

#### 3. Apakah terdapat preferensi jenis kamar tertentu pada masing-masing segmen customer?
<div align="center">
<img width="555" height="359" alt="image" src="https://github.com/user-attachments/assets/f806c82e-9e0e-489e-b50b-8c0c7a0f218a" />
</div>

Setiap segmen pelanggan menunjukkan preferensi yang berbeda dalam memilih jenis kamar. Segmen Corporate didominasi oleh Single Room dan Deluxe Room, mencerminkan kebutuhan efisiensi serta kenyamanan standar untuk mendukung aktivitas bisnis. Segmen Individual lebih banyak memilih Deluxe Room, diikuti Studio Room, yang menandakan kebutuhan akan kenyamanan personal dengan fleksibilitas harga. Sementara itu, segmen Family cenderung memilih Studio Room, karena lebih luas dan sesuai untuk kebutuhan keluarga. Adapun Royal Suite tercatat sebagai kamar dengan jumlah pemesanan paling rendah di semua segmen, sehingga dibutuhkan strategi promosi atau pemasaran khusus agar kontribusinya dapat meningkat.

#### 4. Bagaimana distribusi rating yang diberikan oleh customer terhadap pelananan hotel
<div align="center">
<img width="558" height="362" alt="image" src="https://github.com/user-attachments/assets/29fdef19-007f-4d76-8f60-c4ed6bfd1df1" />
</div>

Ketiga hotel secara umum mendapat penilaian positif dengan rating 5 sebagai yang paling dominan (Lexis Suites 676, The Hilton 648, Le Meridien 634). Meski demikian, masih terdapat porsi signifikan pelanggan yang memberi rating rendah (skor 2–3), terutama di The Hilton (425). Hal ini menunjukkan kepuasan pelanggan cukup tinggi, namun perbaikan layanan dan fasilitas tetap diperlukan agar pengalaman lebih konsisten.

#### 5. Bagaimana distribusi total booking berdasarkan membership (Platinum, Gold, None)?
<div align="center">
<img width="568" height="363" alt="image" src="https://github.com/user-attachments/assets/6a5fce0f-6a90-4721-9073-34b98b298e8b" />
</div>
Jumlah booking didominasi oleh pelanggan dengan membership Platinum (49,88%) dan Gold (48,74%), sehingga dapat disimpulkan bahwa pelanggan membership menjadi kontributor utama. Sementara itu, jumlah booking dari non-member sangat kecil (1,37%), yang menunjukkan bahwa program membership cukup efektif menarik minat pelanggan.

#### 6. Bagaimana distribusi total booking berdasarkan meal plan pada tiap hotel?
<div align="center">
<img width="556" height="360" alt="image" src="https://github.com/user-attachments/assets/a01e66fc-3d16-47e3-b26c-04d579d9b0ea" />
</div>
Bed & Breakfast menjadi pilihan paling dominan di ketiga hotel, dengan jumlah pemesanan tertinggi pada The Hilton (1.356 ). Meal plan Full Board menempati posisi kedua dengan angka yang cukup signifikan, terutama di Lexis Suites (489). Sementara itu, pilihan Half Board, Self Catering, dan Undefined relatif kecil kontribusinya. Hal ini menunjukkan bahwa mayoritas pelanggan lebih menyukai paket sederhana (Bed & Breakfast), sehingga strategi promosi dan penawaran paket bisa difokuskan pada segmen tersebut untuk menarik lebih banyak pelanggan.

#### 7. Bagaimana distribusi review yang diberikan oleh customer terhadap hotel?
<div align="center">
<img width="559" height="364" alt="image" src="https://github.com/user-attachments/assets/eefb87d8-ab07-4927-a465-39609061891f" />
</div>

Rating yang diberikan oleh customer untuk masing-masing hotel didominasi penilaian Excellent, dengan jumlah tertinggi pada Lexis Suites (676), diikuti The Hilton (648), dan Le Meridien (634). Rating Very Good juga cukup kuat di semua hotel, menempati posisi kedua setelah Excellent. Sementara itu, rating Good dan Poor jumlahnya lebih rendah, meskipun masih menunjukkan adanya variasi pengalaman pelanggan. Secara umum, hal ini menandakan bahwa mayoritas pelanggan merasa sangat puas dengan layanan hotel, namun masih ada ruang perbaikan untuk mengurangi pengalaman “Poor” agar kualitas pelayanan lebih konsisten.

#### Dashbaord Summary
![Dashboard Hotel Github_2](https://github.com/user-attachments/assets/6cac2142-7813-4ec5-be2b-3a4aa4f8df70)

## Rekomendasi
















