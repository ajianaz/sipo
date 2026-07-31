import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/database/daos/transaksi_dao.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/utils/currency_formatter.dart';
import '../../shared/utils/date_formatter.dart';
import '../../shared/widgets/sipo_empty_state.dart';
import '../providers/providers.dart';

/// Transaksi hub — shows pembelian + penjualan history
class TransaksiPage extends ConsumerWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaksiAsync = ref.watch(_transaksiListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi')),
      body: transaksiAsync.when(
        data:
            (list) =>
                list.isEmpty
                    ? const SipoEmptyState(
                      title: 'Belum ada transaksi',
                      subtitle:
                          'Tap tombol + untuk mencatat pembelian atau penjualan.',
                    )
                    : RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(_transaksiListProvider);
                      },
                      child: ListView.builder(
                        itemCount: list.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final item = list[index];
                          final isPembelian =
                              item.transaksi.tipe == 'pembelian';
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    isPembelian
                                        ? SipoColors.warningContainer
                                        : SipoColors.successContainer,
                                child: Icon(
                                  isPembelian
                                      ? Icons.shopping_cart
                                      : Icons.point_of_sale,
                                  color:
                                      isPembelian
                                          ? SipoColors.warning
                                          : SipoColors.success,
                                  size: 20,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    isPembelian ? 'Pembelian' : 'Penjualan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isPembelian
                                              ? SipoColors.warning
                                              : SipoColors.success,
                                    ),
                                  ),
                                  Text(
                                    ' • ${item.countItems} item',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: SipoColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                DateFormatter.dateTimeFromString(
                                  item.transaksi.tanggal,
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: SipoColors.muted,
                                ),
                              ),
                              trailing: Text(
                                CurrencyFormatter.format(
                                  item.transaksi.totalHarga,
                                ),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              onTap:
                                  () => context.push(
                                    '/transaksi/${item.transaksi.id}',
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

final _transaksiListProvider = FutureProvider<List<TransaksiWithDetails>>((
  ref,
) {
  return ref.watch(transaksiDaoProvider).getAllWithDetails();
});
