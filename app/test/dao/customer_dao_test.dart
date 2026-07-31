import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/data/database/app_database.dart';
import 'package:sipo/data/database/daos/customer_dao.dart';
import 'package:sipo/data/repositories/customer_repository.dart';

AppDatabase _createTestDb() => AppDatabase.forTesting(NativeDatabase.memory());

void main() {
  late AppDatabase db;
  late CustomerDao dao;
  late CustomerRepository repo;

  setUp(() {
    db = _createTestDb();
    dao = db.customerDao;
    repo = CustomerRepository(dao);
  });

  tearDown(() async {
    await db.close();
  });

  group('CustomerDao', () {
    test('insert and getAll', () async {
      await dao.insert(
        CustomersCompanion(
          nama: const Value('Toko Makmur'),
          noHp: const Value('081234567890'),
        ),
      );

      final list = await dao.getAll();
      expect(list.length, equals(1));
      expect(list.first.nama, equals('Toko Makmur'));
    });

    test('getRecent returns latest entries', () async {
      for (int i = 1; i <= 5; i++) {
        await dao.insert(
          CustomersCompanion(nama: Value('Customer $i')),
        );
      }

      final recent = await dao.getRecent(limit: 3);
      expect(recent.length, equals(3));
      // Most recent first (ordered by id desc)
      expect(recent.first.nama, equals('Customer 5'));
    });

    test('search finds by name', () async {
      await dao.insert(
        CustomersCompanion(nama: const Value('Toko Makmur')),
      );
      await dao.insert(
        CustomersCompanion(nama: const Value('Toko Jaya')),
      );

      final results = await dao.search('Makmur');
      expect(results.length, equals(1));
    });

    test('deleteById removes customer', () async {
      final id = await dao.insert(
        CustomersCompanion(nama: const Value('Toko')),
      );

      await dao.deleteById(id);
      final list = await dao.getAll();
      expect(list.length, equals(0));
    });
  });

  group('CustomerRepository', () {
    test('create with all fields', () async {
      await repo.create(
        nama: 'Toko Makmur',
        noHp: '081234567890',
        alamat: 'Jl. Contoh No. 1',
        catatan: 'Supplier beras',
      );

      final list = await repo.getAll();
      expect(list.length, equals(1));
      expect(list.first.noHp, equals('081234567890'));
      expect(list.first.alamat, equals('Jl. Contoh No. 1'));
    });

    test('create with nullable fields', () async {
      await repo.create(nama: 'Toko Makmur');

      final list = await repo.getAll();
      expect(list.first.noHp, isNull);
      expect(list.first.alamat, isNull);
    });

    test('update changes name and phone', () async {
      final id = await repo.create(nama: 'Toko', noHp: '081');

      await repo.update(
        id: id,
        nama: 'Toko Baru',
        noHp: '082',
        alamat: null,
        catatan: null,
      );

      final updated = await repo.getById(id);
      expect(updated.nama, equals('Toko Baru'));
      expect(updated.noHp, equals('082'));
    });
  });
}
