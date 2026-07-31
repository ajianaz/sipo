import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/tables.dart';

part 'transaksi_dao.g.dart';

@DriftAccessor(tables: [Transaksis, TransaksiDetails])
class TransaksiDao extends DatabaseAccessor<AppDatabase>
    with _$TransaksiDaoMixin {
  TransaksiDao(super.db);

  /// Insert a complete transaction (header + details) atomically
  Future<int> insertTransaction({
    required String tipe,
    required int? customerId,
    required String tanggal,
    required double totalHarga,
    String? catatan,
    required List<TransaksiDetailItem> items,
  }) {
    return transaction(() async {
      final headerId = await into(transaksis).insert(
        TransaksisCompanion(
          tipe: Value(tipe),
          customerId: Value(customerId),
          tanggal: Value(tanggal),
          totalHarga: Value(totalHarga),
          catatan: Value(catatan),
        ),
      );

      for (final item in items) {
        await into(transaksiDetails).insert(
          TransaksiDetailsCompanion(
            transaksiId: Value(headerId),
            barangId: Value(item.barangId),
            jumlah: Value(item.jumlah),
            hargaSatuan: Value(item.hargaSatuan),
            subtotal: Value(item.subtotal),
          ),
        );
      }

      return headerId;
    });
  }

  /// Get all transactions with details
  Future<List<TransaksiWithDetails>> getAllWithDetails() {
    final query = select(transaksis).join([
      innerJoin(transaksiDetails,
          transaksiDetails.transaksiId.equalsExp(transaksis.id)),
    ]);

    return query.map((row) {
      final transaksi = row.readTable(transaksis);
      final detail = row.readTable(transaksiDetails);
      return TransaksiRow(
        transaksi: transaksi,
        detail: detail,
      );
    }).get().then(_groupDetails);
  }

  /// Get transactions filtered by type and date range
  Future<List<TransaksiWithDetails>> getByTypeAndDateRange({
    required String tipe,
    required String startDate,
    required String endDate,
  }) {
    final query = select(transaksis).join([
      innerJoin(transaksiDetails,
          transaksiDetails.transaksiId.equalsExp(transaksis.id)),
    ]);

    query
      .where(transaksis.tipe.equals(tipe) &
          transaksis.tanggal.isBiggerOrEqualValue(startDate) &
          transaksis.tanggal.isSmallerOrEqualValue(endDate));

    return query.map((row) {
      final transaksi = row.readTable(transaksis);
      final detail = row.readTable(transaksiDetails);
      return TransaksiRow(transaksi: transaksi, detail: detail);
    }).get().then(_groupDetails);
  }

  /// Get a single transaction with all its details
  Future<TransaksiWithDetails?> getWithDetailsById(int id) async {
    final query = select(transaksis).join([
      innerJoin(transaksiDetails,
          transaksiDetails.transaksiId.equalsExp(transaksis.id)),
    ])..where(transaksis.id.equals(id));

    final rows = await query.map((row) {
      final transaksi = row.readTable(transaksis);
      final detail = row.readTable(transaksiDetails);
      return TransaksiRow(transaksi: transaksi, detail: detail);
    }).get();

    final grouped = _groupDetails(rows);
    return grouped.isEmpty ? null : grouped.first;
  }

  /// Get today's summary
  Future<TodaySummary> getTodaySummary(String todayDate) async {
    // Validate input format to prevent injection
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(todayDate)) {
      return TodaySummary(
        totalPembelian: 0,
        totalPenjualan: 0,
        countPembelian: 0,
        countPenjualan: 0,
      );
    }

    final pembelianQuery = select(transaksis)
      ..where((t) => t.tipe.equals('pembelian') &
          t.tanggal.like('$todayDate%'));

    final penjualanQuery = select(transaksis)
      ..where((t) => t.tipe.equals('penjualan') &
          t.tanggal.like('$todayDate%'));

    final pembelianList = await pembelianQuery.get();
    final penjualanList = await penjualanQuery.get();

    return TodaySummary(
      totalPembelian: pembelianList.fold(
          0.0, (sum, t) => sum + t.totalHarga),
      totalPenjualan: penjualanList.fold(
          0.0, (sum, t) => sum + t.totalHarga),
      countPembelian: pembelianList.length,
      countPenjualan: penjualanList.length,
    );
  }

  List<TransaksiWithDetails> _groupDetails(List<TransaksiRow> rows) {
    final Map<int, TransaksiWithDetails> grouped = {};
    for (final row in rows) {
      grouped.putIfAbsent(
        row.transaksi.id,
        () => TransaksiWithDetails(
          transaksi: row.transaksi,
          details: [],
          customer: null,
        ),
      );
      grouped[row.transaksi.id]!.details.add(row.detail);
    }
    return grouped.values.toList()
      ..sort((a, b) => b.transaksi.tanggal.compareTo(a.transaksi.tanggal));
  }
}

class TransaksiDetailItem {
  final int barangId;
  final double jumlah;
  final double hargaSatuan;
  final double subtotal;

  TransaksiDetailItem({
    required this.barangId,
    required this.jumlah,
    required this.hargaSatuan,
    required this.subtotal,
  });
}

class TransaksiRow {
  final Transaksi transaksi;
  final TransaksiDetail detail;
  TransaksiRow({required this.transaksi, required this.detail});
}

class TransaksiWithDetails {
  final Transaksi transaksi;
  final List<TransaksiDetail> details;
  final Customer? customer;
  TransaksiWithDetails({
    required this.transaksi,
    required this.details,
    this.customer,
  });

  int get countItems => details.length;
}

class TodaySummary {
  final double totalPembelian;
  final double totalPenjualan;
  final int countPembelian;
  final int countPenjualan;

  TodaySummary({
    required this.totalPembelian,
    required this.totalPenjualan,
    required this.countPembelian,
    required this.countPenjualan,
  });
}
