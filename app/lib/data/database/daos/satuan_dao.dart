import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/tables.dart';

part 'satuan_dao.g.dart';

@DriftAccessor(tables: [Satuans])
class SatuanDao extends DatabaseAccessor<AppDatabase> with _$SatuanDaoMixin {
  SatuanDao(super.db);

  Future<List<Satuan>> getAllActive() =>
      (select(satuans)..where((t) => t.isActive.equals(1))).get();

  Future<List<Satuan>> getAll() => select(satuans).get();

  Future<Satuan> getById(int id) =>
      (select(satuans)..where((t) => t.id.equals(id))).getSingle();

  Future<int> insert(SatuansCompanion entry) => into(satuans).insert(entry);

  Future<bool> updateEntry(Satuan entry) => update(satuans).replace(entry);

  Future<int> softDeleteEntry(int id) => (update(satuans)..where(
    (t) => t.id.equals(id),
  )).write(SatuansCompanion(isActive: const Value(0)));

  Future<int> deleteById(int id) =>
      (delete(satuans)..where((t) => t.id.equals(id))).go();

  Future<List<Satuan>> search(String query) =>
      (select(satuans)
        ..where((t) => t.nama.contains(query) & t.isActive.equals(1))).get();

  Future<int> toggleActive(int id) async {
    final satuan = await getById(id);
    return (update(satuans)..where(
      (t) => t.id.equals(id),
    )).write(SatuansCompanion(isActive: Value(satuan.isActive == 1 ? 0 : 1)));
  }
}
