# Proyek PHP

## Deskripsi

Ini adalah proyek PHP sederhana yang berjalan di atas stack LEMP menggunakan Docker.

## Petunjuk

1. Pastikan Anda telah menginstal Docker dan Docker Compose di sistem Anda.
2. Clone repositori ini ke komputer Anda.
3. Bangun dan jalankan kontainer Docker:
   ```bash
   docker-compose up -d
   ```
4. Jalankan skrip pengaturan:
   ```bash
   ./run.sh
   ```
5. Akses proyek melalui browser Anda di `https://localhost` atau `https://folder_name.test`.

## Catatan

- Folder `php-project` akan secara otomatis mendaftarkan domain contoh dalam format `folder_name.test` untuk pengembangan lokal.
- Skrip `run.sh` digunakan untuk mendaftarkan domain lokal dan mengatur dukungan HTTPS menggunakan `mkcert`. Pastikan `mkcert` telah diinstal dan dipercaya di sistem Anda sebelum menjalankan skrip. Jika `mkcert` belum tersedia di sistem Anda, skrip akan secara otomatis menginstal `mkcert` menggunakan package manager yang sesuai dengan sistem operasi Anda.
- File Docker Compose mencakup layanan untuk Nginx, MySQL, PHPMYADMIN, dan PHP.

## Platform yang Didukung

- [x] Linux
- [x] Windows
- [ ] macOS

## Pengembangan Masa Depan

- Dukungan untuk beberapa versi PHP untuk memungkinkan pengujian dan menjalankan aplikasi berbasis PHP yang berbeda.
- Konfigurasi Nginx yang ditingkatkan untuk mendukung framework dan CMS selain Laravel, seperti WordPress dan platform berbasis PHP lainnya.
- Peningkatan fleksibilitas dalam file `docker-compose.yml` untuk memungkinkan penyesuaian yang lebih mudah untuk berbagai kebutuhan proyek.
- Dokumentasi tambahan untuk mengatur dan mengkonfigurasi beberapa versi PHP dan konfigurasi Nginx.
- Potensi integrasi dengan alat seperti Xdebug untuk debugging di berbagai versi PHP.
- Proses yang disederhanakan untuk menambahkan domain baru dan sertifikat SSL untuk proyek tambahan.
- Pengujian dan dukungan untuk platform Windows dan macOS.
