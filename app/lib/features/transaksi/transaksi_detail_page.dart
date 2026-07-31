import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/daos/transaksi_dao.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/utils/currency_formatter.dart';
import '../../shared/utils/date_formatter.dart';
import '../providers/providers.dart';

class TransaksiDetailPage extends ConsumerWidget {
  final int transaksiId;
  const TransaksiDetailPage({super.key, required this.transaksiId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(_detailProvider(transaksiId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi')),
      body: detailAsync.when(
        data: (detail) {
          if (detail == null) {
            return const Center(child: Text('Transaksi tidak ditemukan'));
          }
          final isPembelian = detail.transaksi.tipe == 'pembelian';
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isPembelian
                                ? Icons.shopping_cart
                                : Icons.point_of_sale,
                            color:
                                isPembelian
                                    ? SipoColors.warning
                                    : SipoColors.success,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isPembelian ? 'Pembelian' : 'Penjualan',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color:
                                  isPembelian
                                      ? SipoColors.warning
                                      : SipoColors.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateFormatter.dateTimeFromString(
                          detail.transaksi.tanggal,
                        ),
                        style: TextStyle(color: SipoColors.muted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Items
              Text(
                'Item',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...detail.details.map(
                (d) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID Barang: ${d.barangId}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${d.jumlah} × ${CurrencyFormatter.format(d.hargaSatuan)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: SipoColors.muted,
                              ),
                            ),
                            Text(
                              CurrencyFormatter.format(d.subtotal),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Total
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      isPembelian
                          ? SipoColors.warningContainer
                          : SipoColors.successContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      CurrencyFormatter.format(detail.transaksi.totalHarga),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color:
                            isPembelian
                                ? SipoColors.warning
                                : SipoColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

final _detailProvider = FutureProvider.family<TransaksiWithDetails?, int>((
  ref,
  id,
) {
  return ref.watch(transaksiDaoProvider).getWithDetailsById(id);
});
