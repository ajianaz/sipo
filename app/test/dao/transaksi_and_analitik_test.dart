import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/data/database/app_database.dart';
import 'package:sipo/data/database/daos/satuan_dao.dart';
import 'package:sipo/data/database/daos/barang_dao.dart';
import 'package:sipo/data/database/daos/customer_dao.dart';
import 'package:sipo/data/database/daos/transaksi_dao.dart';
import 'package:sipo/data/database/daos/analitik_dao.dart';
import 'package:sipo/data/repositories/transaksi_repository.dart';

AppDatabase _createTestDb() => AppDatabase.forTesting(NativeDatabase.memory());

void main() {
  late AppDatabase db;
  late TransaksiDao transaksiDao;
  late AnalitikDao analitikDao;
  late SatuanDao satuanDao;
  late BarangDao barangDao;
  late CustomerDao customerDao;
  late TransaksiRepository transaksiRepo;

  setUp(() {
    db = _createTestDb();
    transaksiDao = db.transaksiDao;
    analitikDao = db.analitikDao;
    satuanDao = db.satuanDao;
    barangDao = db.barangDao;
    customerDao = db.customerDao;
    transaksiRepo = TransaksiRepository(transaksiDao);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> seedSatuan(String nama) => satuanDao.insert(
    SatuansCompanion(nama: Value(nama), isActive: const Value(1)),
  );

  Future<int> seedBarang(String nama, int satuanId, double beli, double jual) =>
      barangDao.insert(
        BarangsCompanion(
          nama: Value(nama),
          satuanId: Value(satuanId),
          hargaBeli: Value(beli),
          hargaJual: Value(jual),
        ),
      );

  Future<int> seedCustomer(String nama) =>
      customerDao.insert(CustomersCompanion(nama: Value(nama)));

  group('TransaksiDao', () {
    test('insertTransaction creates header and details', () async {
      final satuanId = await seedSatuan('kg');
      final barangId = await seedBarang('Beras', satuanId, 10000, 12000);
      final customerId = await seedCustomer('Toko');

      final headerId = await transaksiDao.insertTransaction(
        tipe: 'pembelian',
        customerId: customerId,
        tanggal: '2026-07-31T10:00:00',
        totalHarga: 20000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 2,
            hargaSatuan: 10000,
            subtotal: 20000,
          ),
        ],
      );

      expect(headerId, greaterThan(0));

      // Verify detail exists
      final detail = await transaksiDao.getWithDetailsById(headerId);
      expect(detail, isNotNull);
      expect(detail!.details.length, equals(1));
      expect(detail.transaksi.tipe, equals('pembelian'));
    });

    test('insertTransaction for penjualan with nullable customer', () async {
      final satuanId = await seedSatuan('pcs');
      final barangId = await seedBarang('Kopi', satuanId, 5000, 8000);

      final headerId = await transaksiDao.insertTransaction(
        tipe: 'penjualan',
        customerId: null, // Walk-in
        tanggal: '2026-07-31T14:00:00',
        totalHarga: 16000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 2,
            hargaSatuan: 8000,
            subtotal: 16000,
          ),
        ],
      );

      final detail = await transaksiDao.getWithDetailsById(headerId);
      expect(detail!.transaksi.customerId, isNull);
    });

    test('getTodaySummary calculates correctly', () async {
      final satuanId = await seedSatuan('kg');
      final barangId = await seedBarang('Beras', satuanId, 10000, 12000);
      final custId = await seedCustomer('Toko');

      await transaksiDao.insertTransaction(
        tipe: 'pembelian',
        customerId: custId,
        tanggal: '2026-07-31T10:00:00',
        totalHarga: 10000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 1,
            hargaSatuan: 10000,
            subtotal: 10000,
          ),
        ],
      );

      final summary = await transaksiDao.getTodaySummary('2026-07-31');
      expect(summary.countPembelian, equals(1));
      expect(summary.countPenjualan, equals(0));
      expect(summary.totalPembelian, closeTo(10000, 0.01));
    });
  });

  group('TransaksiRepository', () {
    test('createPembelian creates complete pembelian', () async {
      final satuanId = await seedSatuan('kg');
      final barangId = await seedBarang('Beras', satuanId, 10000, 12000);
      final custId = await seedCustomer('Supplier');

      final id = await transaksiRepo.createPembelian(
        customerId: custId,
        totalHarga: 20000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 2,
            hargaSatuan: 10000,
            subtotal: 20000,
          ),
        ],
      );

      final detail = await transaksiRepo.getWithDetailsById(id);
      expect(detail, isNotNull);
      expect(detail!.transaksi.tipe, equals('pembelian'));
      expect(detail.details.length, equals(1));
    });

    test('createPenjualan with null customer works', () async {
      final satuanId = await seedSatuan('pcs');
      final barangId = await seedBarang('Kopi', satuanId, 5000, 8000);

      final id = await transaksiRepo.createPenjualan(
        customerId: null,
        totalHarga: 8000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 1,
            hargaSatuan: 8000,
            subtotal: 8000,
          ),
        ],
      );

      final detail = await transaksiRepo.getWithDetailsById(id);
      expect(detail!.transaksi.customerId, isNull);
    });
  });

  group('AnalitikDao', () {
    test('getSummaryByBarang returns correct aggregates', () async {
      final satuanId = await seedSatuan('kg');
      final barangId = await seedBarang('Beras', satuanId, 10000, 12000);
      final custId = await seedCustomer('Toko');

      // Pembelian: 5kg @ 10000 = 50000
      await transaksiDao.insertTransaction(
        tipe: 'pembelian',
        customerId: custId,
        tanggal: '2026-07-31',
        totalHarga: 50000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 5,
            hargaSatuan: 10000,
            subtotal: 50000,
          ),
        ],
      );

      // Penjualan: 3kg @ 12000 = 36000
      await transaksiDao.insertTransaction(
        tipe: 'penjualan',
        customerId: null,
        tanggal: '2026-07-31',
        totalHarga: 36000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 3,
            hargaSatuan: 12000,
            subtotal: 36000,
          ),
        ],
      );

      final summary = await analitikDao.getSummaryByBarang(
        startDate: '2026-07-01',
        endDate: '2026-07-31',
      );

      expect(summary.length, equals(1));
      expect(summary.first.totalQtyPembelian, closeTo(5, 0.01));
      expect(summary.first.totalQtyPenjualan, closeTo(3, 0.01));
      expect(summary.first.nettoQty, closeTo(-2, 0.01)); // 3 - 5 = -2
      expect(summary.first.totalNilaiPembelian, closeTo(50000, 0.01));
      expect(summary.first.totalNilaiPenjualan, closeTo(36000, 0.01));
    });

    test('getTotal returns zero when no data', () async {
      final total = await analitikDao.getTotal(
        startDate: '2026-01-01',
        endDate: '2026-12-31',
      );
      expect(total.totalQtyPembelian, equals(0));
      expect(total.totalNilaiPenjualan, equals(0));
    });

    test('getSummaryByBarang filters by date range', () async {
      final satuanId = await seedSatuan('kg');
      final barangId = await seedBarang('Beras', satuanId, 10000, 12000);
      final custId = await seedCustomer('Toko');

      await transaksiDao.insertTransaction(
        tipe: 'pembelian',
        customerId: custId,
        tanggal: '2026-07-15',
        totalHarga: 10000,
        items: [
          TransaksiDetailItem(
            barangId: barangId,
            jumlah: 1,
            hargaSatuan: 10000,
            subtotal: 10000,
          ),
        ],
      );

      // Query for August — should be empty
      final summary = await analitikDao.getSummaryByBarang(
        startDate: '2026-08-01',
        endDate: '2026-08-31',
      );
      expect(summary.length, equals(0));
    });
  });
}
