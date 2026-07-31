import '../database/daos/transaksi_dao.dart';

class TransaksiRepository {
  final TransaksiDao _dao;

  TransaksiRepository(this._dao);

  Future<int> createPembelian({
    required int customerId,
    required double totalHarga,
    required List<TransaksiDetailItem> items,
    String? catatan,
  }) {
    return _dao.insertTransaction(
      tipe: 'pembelian',
      customerId: customerId,
      tanggal: DateTime.now().toIso8601String(),
      totalHarga: totalHarga,
      catatan: catatan,
      items: items,
    );
  }

  Future<int> createPenjualan({
    int? customerId,
    required double totalHarga,
    required List<TransaksiDetailItem> items,
    String? catatan,
  }) {
    return _dao.insertTransaction(
      tipe: 'penjualan',
      customerId: customerId,
      tanggal: DateTime.now().toIso8601String(),
      totalHarga: totalHarga,
      catatan: catatan,
      items: items,
    );
  }

  Future<List<TransaksiWithDetails>> getAllWithDetails() =>
      _dao.getAllWithDetails();

  Future<TransaksiWithDetails?> getWithDetailsById(int id) =>
      _dao.getWithDetailsById(id);

  Future<List<TransaksiWithDetails>> getByTypeAndDateRange({
    required String tipe,
    required String startDate,
    required String endDate,
  }) =>
      _dao.getByTypeAndDateRange(
        tipe: tipe,
        startDate: startDate,
        endDate: endDate,
      );

  Future<TodaySummary> getTodaySummary() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return _dao.getTodaySummary(today);
  }
}
