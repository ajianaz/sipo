import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../database/daos/customer_dao.dart';

class CustomerRepository {
  final CustomerDao _dao;

  CustomerRepository(this._dao);

  Future<List<Customer>> getAll() => _dao.getAll();

  Future<Customer> getById(int id) => _dao.getById(id);

  Future<List<Customer>> search(String query) => _dao.search(query);

  Future<List<Customer>> getRecent({int limit = 5}) =>
      _dao.getRecent(limit: limit);

  Future<int> create({
    required String nama,
    String? noHp,
    String? alamat,
    String? catatan,
  }) {
    return _dao.insert(
      CustomersCompanion(
        nama: Value(nama),
        noHp: Value(noHp),
        alamat: Value(alamat),
        catatan: Value(catatan),
      ),
    );
  }

  Future<bool> update({
    required int id,
    required String nama,
    String? noHp,
    String? alamat,
    String? catatan,
  }) {
    return _dao.updateEntry(
      Customer(
        id: id,
        nama: nama,
        noHp: noHp,
        alamat: alamat,
        catatan: catatan,
      ),
    );
  }

  Future<int> delete(int id) => _dao.deleteById(id);
}
