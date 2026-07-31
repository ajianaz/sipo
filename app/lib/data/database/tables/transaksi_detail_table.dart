import 'package:drift/drift.dart';
import 'barang_table.dart';
import 'transaksi_table.dart';

class TransaksiDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transaksiId =>
      integer().references(Transaksis, #id, onDelete: KeyAction.cascade)();
  IntColumn get barangId =>
      integer().references(Barangs, #id, onDelete: KeyAction.restrict)();
  RealColumn get jumlah => real()();
  RealColumn get hargaSatuan => real()();
  RealColumn get subtotal => real()();
}
