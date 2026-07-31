# Sipo — Simple POS

> Catat pembelian & penjualan dalam 3 langkah.

Sipo adalah aplikasi pencatatan pembelian dan penjualan sederhana untuk UMKM kecil.
Offline-first, zero setup, langsung pakai.

## Fitur (v0.1)

- ✅ Master Satuan (kg, liter, pcs, dll)
- ✅ Master Barang (nama, harga beli, harga jual, satuan)
- ✅ Customer (nama, no HP, alamat)
- ✅ Transaksi Pembelian (pilih supplier → isi barang & jumlah → simpan)
- ✅ Transaksi Penjualan (pilih pelanggan → isi barang & jumlah → simpan)
- ✅ Analitik per barang (total qty + nilai, filter hari/minggu/bulan)

## Tech Stack

- Flutter (Android first)
- Drift (SQLite, type-safe)
- Riverpod (state management)
- GoRouter (navigation)

## Setup

```bash
# Install dependencies
cd app
flutter pub get

# Generate Drift code
dart run build_runner build --delete-conflicting-outputs

# Run
flutter run
```

## Project Structure

```
app/lib/
├── data/database/     ← Drift SQLite
├── data/repositories/  ← Business logic
├── domain/models/      ← Domain objects
├── features/           ← Per feature (barang, pembelian, dll)
├── shared/             ← Reusable widgets + theme
└── routing/            ← GoRouter config
```

## Documentation

Lihat `docs/plans/` untuk PRD, ERD, Architecture, dan Roadmap.

## License

Private — ajianaz
