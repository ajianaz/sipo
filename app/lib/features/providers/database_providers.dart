import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/database/daos/daos.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final satuanDaoProvider = Provider<SatuanDao>((ref) {
  return ref.watch(databaseProvider).satuanDao;
});

final barangDaoProvider = Provider<BarangDao>((ref) {
  return ref.watch(databaseProvider).barangDao;
});

final customerDaoProvider = Provider<CustomerDao>((ref) {
  return ref.watch(databaseProvider).customerDao;
});

final transaksiDaoProvider = Provider<TransaksiDao>((ref) {
  return ref.watch(databaseProvider).transaksiDao;
});

final analitikDaoProvider = Provider<AnalitikDao>((ref) {
  return ref.watch(databaseProvider).analitikDao;
});
