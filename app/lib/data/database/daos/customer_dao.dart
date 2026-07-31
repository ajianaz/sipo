import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/tables.dart';

part 'customer_dao.g.dart';

@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.db);

  Future<List<Customer>> getAll() => select(customers).get();

  Future<Customer> getById(int id) =>
      (select(customers)..where((t) => t.id.equals(id))).getSingle();

  Future<int> insert(CustomersCompanion entry) => into(customers).insert(entry);

  Future<bool> updateEntry(Customer entry) => update(customers).replace(entry);

  Future<int> deleteById(int id) =>
      (delete(customers)..where((t) => t.id.equals(id))).go();

  Future<List<Customer>> search(String query) =>
      (select(customers)..where((t) => t.nama.contains(query))).get();

  /// Recent customers ordered by id desc (newest first)
  Future<List<Customer>> getRecent({int limit = 5}) => (select(customers)
    ..orderBy([
      (t) => OrderingTerm.desc(t.id),
    ])).get().then((list) => list.take(limit).toList());
}
