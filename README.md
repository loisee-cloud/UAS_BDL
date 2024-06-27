ERD
![ERD drawio](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/a6784eea-5481-40f7-9de0-6f87efac9754)

Deskripsi project
Basis data Toko ini dirancang untuk mendukung operasi bisnis sehari-hari dari sebuah toko yang menjual berbagai produk kepada pelanggan. 
Sistem ini mencakup modul untuk manajement produk, pelanggan, transaksi penjualan, serta detail penjualan.
Dengan basis data ini, toko dapat melacak inventaris, penjualan, dan interaksi pelanggan secara efisien.
Desain basis data ini memfasilitasi penyimpanan data yang terstruktur, integritas data, serta kemudahan akses dan analisis.

Berikut adalah SQL untuk membuat tabel berdasarkan ERD di atas:
1. Buat Database
![Screenshot 2024-06-26 125658](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/686c76a8-2392-4211-a608-df23250e280a)
2. Buat Table 
   a. Tabel Customer
![Screenshot 2024-06-27 090053](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/e543fad4-d80e-4ee5-a69b-90d5ac6c5c55)
   b. Table Product
![Screenshot 2024-06-27 090230](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/e2585627-6745-4ffa-8ff7-ec66cbeafb6f)
   c. Table Sales
![Screenshot 2024-06-27 090348](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/ffcb6301-4126-4e1c-b5ba-d6fa0a6cad95)
   d. table SalesDetail
![Screenshot 2024-06-27 090437](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/7f1fb9b2-4e6c-4e35-9648-4d235a1147f0)
3. Insert data table
   a. Customer
![Screenshot 2024-06-27 090522](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/8338591f-427c-4754-bc6b-ea444460f80d)
   b. Product
![Screenshot 2024-06-27 090629](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/5ff40346-e505-4349-96c5-79169685e864)
   c. Sales
![Screenshot 2024-06-27 090752](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/dcd317db-4950-49cb-89d4-e871ae6854b4)
   d. SalesDetail
![Screenshot 2024-06-27 090911](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/48dde88e-67fd-40d8-8033-ffd395eb5d99)
4. Relasi
   a. Customer - Sales: 1 ke banyak (1) = Seorang pelanggan dapat melakukan banyak penjualan
   b. Sales - SalesDetail: 1 ke banyak (1) = Setiap penjualan dapat terdiri dari banyak produk.
   c. Product - SalesDetail: 1 ke banyak (1) = Setiap produk dapat dijual di banyak penjualan.
5. Trigger
   a. Trigger ini akan mengurangi stok produk saat setelah penjualan 
![Screenshot 2024-06-26 133549](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/b76a20a5-cc3a-4f61-bd79-c99e2e266c8c)
  b. Trigger ini untuk memeriksa stok produk sebelum penjualan supaya mencegah penjualan dengan stok tidak cukup.
![Screenshot 2024-06-26 133645](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/f330019d-9e63-4b01-818e-2f54a3c70ec0)
6. View 
View ini menampilkan informasi detail penjualan beserta nama pelanggan 
![Screenshot 2024-06-27 091139](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/2f56a9ff-d254-4dc7-a481-0b2c18b30d0b)
7. Agregat 
Menampilkan Total Pendapatan dari Penjualan
Screenshot 2024-06-27 091550](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/8297cc5e-5939-4907-a6a2-a8b74235fede)
8. Index
   ![Screenshot 2024-06-27 091638](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/8f6dc20c-02f8-4930-b007-81e64d51e0ac)
   a. Indeks pada Kolom CustomerID di Tabel Sales
   b. Indeks pada Kolom ProductName di Tabel Product
   c. Indeks pada Kolom SalesDate di Tabel Sales
   d. Indeks Komposit pada Kolom ProductID dan SalesID di Tabel SalesDetail
9. Left Join
   Left Join digunakan untuk mengembalikan semua data dari tabel sebelah kiri dan data yang cocok dari tabel sebelah kanan.
   Jika tidak ada kecocokan, maka NULL akan ditampilkan untuk tabel sebelah kanan.
   Contoh Query: Menampilkan semua penjualan termasuk yang tidak memiliki detail penjualan (produk). 
   ![Screenshot 2024-06-26 143600](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/7c266903-163d-496f-b955-07d9cdbea8fc)
11. Inner Join
   Inner Join digunakan untuk mengembalikan data yang memiliki kecocokan pada kedua tabel yang di-join.
   Contoh Query: Menampilkan detail penjualan yang memiliki kecocokan antara tabel penjualan dan produk.
   ![Screenshot 2024-06-26 143609](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/cf54dace-9d09-4b7a-92cc-9164de2fdba4)
12. Subquary
   Subquery digunakan untuk mengeksekusi query di dalam query lainnya.
   Contoh Query: Menampilkan produk yang hanya dibeli oleh pelanggan dengan ID 1.
   ![Screenshot 2024-06-26 143952](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/12c2831f-9d30-4c1e-b2fb-641adb5a9f3b)
13. Having
   Having digunakan untuk menyaring data setelah pengelompokan (GROUP BY).
   Contoh Query: Menampilkan pelanggan yang total pembeliannya lebih dari $100.
   ![Screenshot 2024-06-26 144019](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/81553483-2b88-4f18-b180-fc1d2e276677)
14. Wildcard
    Wildcard digunakan untuk mencocokkan pola pada string dalam operasi pencarian.
    Contoh Query: Menampilkan produk yang nama produknya mengandung kata 'top'.
   ![Screenshot 2024-06-26 144047](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/a6fa8066-2e48-4c02-9a9e-f1887e939c6b)
15. Dump
    ![Screenshot 2024-06-26 172341](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/9be31f72-7c14-4c50-98c8-0c7b5596cb64)
16. Replika
   ![Screenshot 2024-06-26 172504](https://github.com/loisee-cloud/UAS_BDL/assets/173968345/6aded823-64da-40a3-acc4-c7d97cbb70a8)



