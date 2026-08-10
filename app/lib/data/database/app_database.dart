import 'package:drift/drift.dart';
import 'connection/native.dart' if (dart.library.html) 'connection/web.dart';
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
  AppDatabase() : super(openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}
