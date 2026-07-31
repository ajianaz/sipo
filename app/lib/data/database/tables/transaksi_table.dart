import 'package:drift/drift.dart';
import 'customer_table.dart';

class Transaksis extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipe =>
      text().withLength(min: 1, max: 20)(); // 'pembelian' or 'penjualan'
  IntColumn get customerId =>
      integer().nullable().references(Customers, #id)();
  TextColumn get tanggal => text()(); // ISO-8601
  RealColumn get totalHarga => real()();
  TextColumn get catatan => text().withLength(max: 500).nullable()();
}
