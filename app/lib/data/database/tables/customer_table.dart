import 'package:drift/drift.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text().withLength(min: 1, max: 255)();
  TextColumn get noHp => text().withLength(max: 20).nullable()();
  TextColumn get alamat => text().withLength(max: 500).nullable()();
  TextColumn get catatan => text().withLength(max: 500).nullable()();
}
