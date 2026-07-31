import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../database/daos/daos.dart';

class SatuanRepository {
  final SatuanDao _dao;

  SatuanRepository(this._dao);

  Future<List<Satuan>> getAllActive() => _dao.getAllActive();

  Future<List<Satuan>> getAll() => _dao.getAll();

  Future<Satuan> getById(int id) => _dao.getById(id);

  Future<List<Satuan>> search(String query) => _dao.search(query);

  Future<int> create({
    required String nama,
    String? deskripsi,
  }) {
    return _dao.insert(
      SatuansCompanion(
        nama: Value(nama),
        deskripsi: Value(deskripsi),
        isActive: const Value(1),
      ),
    );
  }

  Future<bool> update({
    required int id,
    required String nama,
    String? deskripsi,
    required bool isActive,
  }) async {
    final existing = await _dao.getById(id);
    return _dao.updateEntry(
      Satuan(
        id: id,
        nama: nama,
        deskripsi: existing.deskripsi,
        isActive: isActive ? 1 : 0,
      ),
    );
  }

  Future<int> toggleActive(int id) => _dao.toggleActive(id);

  Future<int> delete(int id) => _dao.deleteById(id);
}
