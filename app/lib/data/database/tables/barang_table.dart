import 'package:drift/drift.dart';
import 'satuan_table.dart';

class Barangs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text().withLength(min: 1, max: 255)();
  IntColumn get satuanId => integer().references(Satuans, #id)();
  RealColumn get hargaBeli => real()();
  RealColumn get hargaJual => real()();
}
