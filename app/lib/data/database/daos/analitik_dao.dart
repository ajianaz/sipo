import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/tables.dart';

part 'analitik_dao.g.dart';

@DriftAccessor(tables: [Transaksis, TransaksiDetails, Barangs])
class AnalitikDao extends DatabaseAccessor<AppDatabase>
    with _$AnalitikDaoMixin {
  AnalitikDao(super.db);

  /// Summary per barang within a date range
  /// Returns: barang_id, barang_nama, total_qty_pembelian, total_nilai_pembelian,
  ///          total_qty_penjualan, total_nilai_penjualan
  Future<List<AnalitikSummary>> getSummaryByBarang({
    required String startDate,
    required String endDate,
    int? barangId,
  }) async {
    // Custom SQL for aggregation — much cleaner than Drift DSL for GROUP BY
    final results = await customSelect(
      '''
        SELECT
          b.id AS barang_id,
          b.nama AS barang_nama,
          b.satuan_id,
          COALESCE(SUM(CASE WHEN t.tipe = 'pembelian' THEN td.jumlah ELSE 0 END), 0) AS total_qty_pembelian,
          COALESCE(SUM(CASE WHEN t.tipe = 'pembelian' THEN td.subtotal ELSE 0 END), 0) AS total_nilai_pembelian,
          COALESCE(SUM(CASE WHEN t.tipe = 'penjualan' THEN td.jumlah ELSE 0 END), 0) AS total_qty_penjualan,
          COALESCE(SUM(CASE WHEN t.tipe = 'penjualan' THEN td.subtotal ELSE 0 END), 0) AS total_nilai_penjualan
        FROM transaksi_details td
        INNER JOIN transaksis t ON t.id = td.transaksi_id
        INNER JOIN barangs b ON b.id = td.barang_id
        WHERE t.tanggal >= ? AND t.tanggal <= ?
        ${barangId != null ? 'AND b.id = ?' : ''}
        GROUP BY b.id, b.nama, b.satuan_id
        ORDER BY b.nama ASC
      ''',
      variables: [
        Variable<String>(startDate),
        Variable<String>(endDate),
        if (barangId != null) Variable<int>(barangId),
      ],
    ).get();

    return results.map((row) => AnalitikSummary(
          barangId: row.read<int>('barang_id'),
          barangNama: row.read<String>('barang_nama'),
          satuanId: row.read<int>('satuan_id'),
          totalQtyPembelian: row.read<double>('total_qty_pembelian'),
          totalNilaiPembelian: row.read<double>('total_nilai_pembelian'),
          totalQtyPenjualan: row.read<double>('total_qty_penjualan'),
          totalNilaiPenjualan: row.read<double>('total_nilai_penjualan'),
        )).toList();
  }

  /// Total summary across all barang for a date range
  Future<AnalitikTotal> getTotal({
    required String startDate,
    required String endDate,
  }) async {
    final result = await customSelect(
      '''
        SELECT
          COALESCE(SUM(CASE WHEN t.tipe = 'pembelian' THEN td.jumlah ELSE 0 END), 0) AS total_qty_pembelian,
          COALESCE(SUM(CASE WHEN t.tipe = 'pembelian' THEN td.subtotal ELSE 0 END), 0) AS total_nilai_pembelian,
          COALESCE(SUM(CASE WHEN t.tipe = 'penjualan' THEN td.jumlah ELSE 0 END), 0) AS total_qty_penjualan,
          COALESCE(SUM(CASE WHEN t.tipe = 'penjualan' THEN td.subtotal ELSE 0 END), 0) AS total_nilai_penjualan
        FROM transaksi_details td
        INNER JOIN transaksis t ON t.id = td.transaksi_id
        WHERE t.tanggal >= ? AND t.tanggal <= ?
      ''',
      variables: [
        Variable<String>(startDate),
        Variable<String>(endDate),
      ],
    ).getSingleOrNull();

    if (result == null) {
      return AnalitikTotal(
        totalQtyPembelian: 0,
        totalNilaiPembelian: 0,
        totalQtyPenjualan: 0,
        totalNilaiPenjualan: 0,
      );
    }

    return AnalitikTotal(
      totalQtyPembelian: result.read<double>('total_qty_pembelian'),
      totalNilaiPembelian: result.read<double>('total_nilai_pembelian'),
      totalQtyPenjualan: result.read<double>('total_qty_penjualan'),
      totalNilaiPenjualan: result.read<double>('total_nilai_penjualan'),
    );
  }
}

class AnalitikSummary {
  final int barangId;
  final String barangNama;
  final int satuanId;
  final double totalQtyPembelian;
  final double totalNilaiPembelian;
  final double totalQtyPenjualan;
  final double totalNilaiPenjualan;

  AnalitikSummary({
    required this.barangId,
    required this.barangNama,
    required this.satuanId,
    this.totalQtyPembelian = 0,
    this.totalNilaiPembelian = 0,
    this.totalQtyPenjualan = 0,
    this.totalNilaiPenjualan = 0,
  });

  double get nettoQty => totalQtyPenjualan - totalQtyPembelian;
  double get nettoNilai => totalNilaiPenjualan - totalNilaiPembelian;
}

class AnalitikTotal {
  final double totalQtyPembelian;
  final double totalNilaiPembelian;
  final double totalQtyPenjualan;
  final double totalNilaiPenjualan;

  AnalitikTotal({
    required this.totalQtyPembelian,
    required this.totalNilaiPembelian,
    required this.totalQtyPenjualan,
    required this.totalNilaiPenjualan,
  });

  double get nettoQty => totalQtyPenjualan - totalQtyPembelian;
  double get nettoNilai => totalNilaiPenjualan - totalNilaiPembelian;
}
