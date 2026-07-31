import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/tables.dart';
import 'daos/satuan_dao.dart';
import 'daos/barang_dao.dart';
import 'daos/customer_dao.dart';
import 'daos/transaksi_dao.dart';
import 'daos/analitik_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Satuans, Barangs, Customers, Transaksis, TransaksiDetails],
  daos: [SatuanDao, BarangDao, CustomerDao, TransaksiDao, AnalitikDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sipo.db'));
    return NativeDatabase.createInBackground(file);
  });
}
