import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/data/database/app_database.dart';
import 'package:sipo/data/database/daos/satuan_dao.dart';
import 'package:sipo/data/repositories/satuan_repository.dart';

/// Creates an in-memory database for testing.
AppDatabase _createTestDb() {
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  return db;
}

void main() {
  late AppDatabase db;
  late SatuanDao dao;
  late SatuanRepository repo;

  setUp(() {
    db = _createTestDb();
    dao = db.satuanDao;
    repo = SatuanRepository(dao);
  });

  tearDown(() async {
    await db.close();
  });

  group('SatuanDao', () {
    test('insert and getAll returns inserted satuan', () async {
      await dao.insert(
        SatuansCompanion(
          nama: const Value('kg'),
          isActive: const Value(1),
        ),
      );

      final list = await dao.getAll();
      expect(list.length, equals(1));
      expect(list.first.nama, equals('kg'));
    });

    test('getAllActive filters out inactive', () async {
      await dao.insert(
        SatuansCompanion(
          nama: const Value('kg'),
          isActive: const Value(1),
        ),
      );
      await dao.insert(
        SatuansCompanion(
          nama: const Value('liter'),
          isActive: const Value(0),
        ),
      );

      final active = await dao.getAllActive();
      expect(active.length, equals(1));
      expect(active.first.nama, equals('kg'));
    });

    test('getById returns correct satuan', () async {
      final id = await dao.insert(
        SatuansCompanion(
          nama: const Value('pcs'),
          isActive: const Value(1),
        ),
      );

      final satuan = await dao.getById(id);
      expect(satuan.nama, equals('pcs'));
    });

    test('search returns matching satuans', () async {
      await dao.insert(
        SatuansCompanion(
          nama: const Value('kilogram'),
          isActive: const Value(1),
        ),
      );
      await dao.insert(
        SatuansCompanion(
          nama: const Value('liter'),
          isActive: const Value(1),
        ),
      );

      final results = await dao.search('kilo');
      expect(results.length, equals(1));
      expect(results.first.nama, equals('kilogram'));
    });

    test('toggleActive toggles value', () async {
      final id = await dao.insert(
        SatuansCompanion(
          nama: const Value('kg'),
          isActive: const Value(1),
        ),
      );

      await dao.toggleActive(id);
      final satuan = await dao.getById(id);
      expect(satuan.isActive, equals(0));

      await dao.toggleActive(id);
      final satuan2 = await dao.getById(id);
      expect(satuan2.isActive, equals(1));
    });

    test('deleteById removes satuan', () async {
      final id = await dao.insert(
        SatuansCompanion(
          nama: const Value('kg'),
          isActive: const Value(1),
        ),
      );

      await dao.deleteById(id);
      final list = await dao.getAll();
      expect(list.length, equals(0));
    });
  });

  group('SatuanRepository', () {
    test('create inserts via repository', () async {
      final id = await repo.create(nama: 'kg');
      expect(id, greaterThan(0));

      final list = await repo.getAll();
      expect(list.length, equals(1));
      expect(list.first.nama, equals('kg'));
    });

    test('create with description', () async {
      await repo.create(nama: 'kg', deskripsi: 'Kilogram');

      final list = await repo.getAll();
      expect(list.first.deskripsi, equals('Kilogram'));
    });

    test('update changes nama', () async {
      final id = await repo.create(nama: 'kg');
      await repo.update(id: id, nama: 'kilogram', isActive: true);

      final updated = await repo.getById(id);
      expect(updated.nama, equals('kilogram'));
    });

    test('delete removes satuan', () async {
      final id = await repo.create(nama: 'kg');
      await repo.delete(id);

      final list = await repo.getAll();
      expect(list.length, equals(0));
    });
  });
}
