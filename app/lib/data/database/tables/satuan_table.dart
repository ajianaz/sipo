import 'package:drift/drift.dart';

class Satuans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text().withLength(min: 1, max: 50).unique()();
  TextColumn get deskripsi => text().withLength(max: 255).nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
}
