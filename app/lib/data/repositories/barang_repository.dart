import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../database/daos/barang_dao.dart';

class BarangRepository {
  final BarangDao _dao;

  BarangRepository(this._dao);

  Future<List<Barang>> getAll() => _dao.getAll();

  Future<Barang> getById(int id) => _dao.getById(id);

  Future<List<BarangWithSatuan>> getAllWithSatuan() =>
      _dao.getAllWithSatuan();

  Future<List<BarangWithSatuan>> searchWithSatuan(String query) =>
      _dao.searchWithSatuan(query);

  Future<List<Barang>> search(String query) => _dao.search(query);

  Future<int> create({
    required String nama,
    required int satuanId,
    required double hargaBeli,
    required double hargaJual,
  }) {
    return _dao.insert(
      BarangsCompanion(
        nama: Value(nama),
        satuanId: Value(satuanId),
        hargaBeli: Value(hargaBeli),
        hargaJual: Value(hargaJual),
      ),
    );
  }

  Future<bool> update({
    required int id,
    required String nama,
    required int satuanId,
    required double hargaBeli,
    required double hargaJual,
  }) {
    return _dao.updateEntry(
      Barang(
        id: id,
        nama: nama,
        satuanId: satuanId,
        hargaBeli: hargaBeli,
        hargaJual: hargaJual,
      ),
    );
  }

  Future<int> delete(int id) => _dao.deleteById(id);
}
