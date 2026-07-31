import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/data/database/app_database.dart';
import 'package:sipo/data/database/daos/barang_dao.dart';
import 'package:sipo/data/database/daos/satuan_dao.dart';
import 'package:sipo/data/repositories/barang_repository.dart';

AppDatabase _createTestDb() => AppDatabase.forTesting(NativeDatabase.memory());

void main() {
  late AppDatabase db;
  late BarangDao barangDao;
  late SatuanDao satuanDao;
  late BarangRepository repo;

  setUp(() {
    db = _createTestDb();
    barangDao = db.barangDao;
    satuanDao = db.satuanDao;
    repo = BarangRepository(barangDao);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> seedSatuan(String nama) => satuanDao.insert(
        SatuansCompanion(nama: Value(nama), isActive: const Value(1)),
      );

  group('BarangDao', () {
    test('insert and getAll', () async {
      final satuanId = await seedSatuan('kg');
      await barangDao.insert(
        BarangsCompanion(
          nama: const Value('Beras'),
          satuanId: Value(satuanId),
          hargaBeli: const Value(10000),
          hargaJual: const Value(12000),
        ),
      );

      final list = await barangDao.getAll();
      expect(list.length, equals(1));
      expect(list.first.nama, equals('Beras'));
    });

    test('getAllWithSatuan joins correctly', () async {
      final satuanId = await seedSatuan('kg');
      await barangDao.insert(
        BarangsCompanion(
          nama: const Value('Beras'),
          satuanId: Value(satuanId),
          hargaBeli: const Value(10000),
          hargaJual: const Value(12000),
        ),
      );

      final withSatuan = await barangDao.getAllWithSatuan();
      expect(withSatuan.length, equals(1));
      expect(withSatuan.first.satuan.nama, equals('kg'));
    });

    test('search finds by name', () async {
      final satuanId = await seedSatuan('kg');
      await barangDao.insert(
        BarangsCompanion(
          nama: const Value('Beras Pandan'),
          satuanId: Value(satuanId),
          hargaBeli: const Value(15000),
          hargaJual: const Value(18000),
        ),
      );
      await barangDao.insert(
        BarangsCompanion(
          nama: const Value('Gula'),
          satuanId: Value(satuanId),
          hargaBeli: const Value(12000),
          hargaJual: const Value(14000),
        ),
      );

      final results = await barangDao.search('Beras');
      expect(results.length, equals(1));
    });

    test('deleteById removes barang', () async {
      final satuanId = await seedSatuan('kg');
      final id = await barangDao.insert(
        BarangsCompanion(
          nama: const Value('Beras'),
          satuanId: Value(satuanId),
          hargaBeli: const Value(10000),
          hargaJual: const Value(12000),
        ),
      );

      await barangDao.deleteById(id);
      final list = await barangDao.getAll();
      expect(list.length, equals(0));
    });
  });

  group('BarangRepository', () {
    test('create inserts with satuan', () async {
      await seedSatuan('kg');
      final list = await satuanDao.getAllActive();
      await repo.create(
        nama: 'Beras',
        satuanId: list.first.id,
        hargaBeli: 10000,
        hargaJual: 12000,
      );

      final barangList = await repo.getAll();
      expect(barangList.length, equals(1));
    });

    test('update changes harga', () async {
      await seedSatuan('kg');
      final satuans = await satuanDao.getAllActive();
      final id = await repo.create(
        nama: 'Beras',
        satuanId: satuans.first.id,
        hargaBeli: 10000,
        hargaJual: 12000,
      );

      await repo.update(
        id: id,
        nama: 'Beras Premium',
        satuanId: satuans.first.id,
        hargaBeli: 15000,
        hargaJual: 18000,
      );

      final updated = await repo.getById(id);
      expect(updated.nama, equals('Beras Premium'));
      expect(updated.hargaBeli, closeTo(15000, 0.01));
    });
  });
}
