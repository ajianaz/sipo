import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/tables.dart';

part 'barang_dao.g.dart';

@DriftAccessor(tables: [Barangs, Satuans])
class BarangDao extends DatabaseAccessor<AppDatabase>
    with _$BarangDaoMixin {
  BarangDao(super.db);

  Future<List<Barang>> getAll() {
    final query = select(barangs);
    return query.get();
  }

  Future<Barang> getById(int id) =>
      (select(barangs)..where((t) => t.id.equals(id))).getSingle();

  Future<int> insert(BarangsCompanion entry) => into(barangs).insert(entry);

  Future<bool> updateEntry(Barang entry) =>
      update(barangs).replace(entry);

  Future<int> deleteById(int id) =>
      (delete(barangs)..where((t) => t.id.equals(id))).go();

  Future<List<Barang>> search(String query) => (select(barangs)
        ..where((t) => t.nama.contains(query)))
      .get();

  /// Join with satuan to get satuan name
  Future<List<BarangWithSatuan>> getAllWithSatuan() {
    final query = select(barangs).join([
      innerJoin(satuans, satuans.id.equalsExp(barangs.satuanId)),
    ]);
    return query.map((row) {
      final barang = row.readTable(barangs);
      final satuan = row.readTable(satuans);
      return BarangWithSatuan(barang: barang, satuan: satuan);
    }).get();
  }

  Future<List<BarangWithSatuan>> searchWithSatuan(String query) {
    final q = select(barangs).join([
      innerJoin(satuans, satuans.id.equalsExp(barangs.satuanId)),
    ]);
    q.where(barangs.nama.contains(query));
    return q.map((row) {
      final barang = row.readTable(barangs);
      final satuan = row.readTable(satuans);
      return BarangWithSatuan(barang: barang, satuan: satuan);
    }).get();
  }
}

class BarangWithSatuan {
  final Barang barang;
  final Satuan satuan;
  BarangWithSatuan({required this.barang, required this.satuan});
}
