import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/utils/currency_formatter.dart';
import '../providers/providers.dart';
import '../../data/database/daos/transaksi_dao.dart';

class BerandaPage extends ConsumerWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaySummaryAsync = ref.watch(_todaySummaryProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(_todaySummaryProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 8),
              // Header
              Text(
                'Sipo',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SipoColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Catat pembelian & penjualan',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: SipoColors.muted),
              ),
              const SizedBox(height: 24),

              // Today Summary Cards
              todaySummaryAsync.when(
                data: (summary) => _SummaryCards(summary: summary),
                loading:
                    () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final _todaySummaryProvider = FutureProvider<TodaySummary>((ref) {
  final dao = ref.watch(transaksiDaoProvider);
  final today = DateTime.now().toIso8601String().substring(0, 10);
  return dao.getTodaySummary(today);
});

class _SummaryCards extends StatelessWidget {
  final TodaySummary summary;
  const _SummaryCards({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Hari Ini',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: 'Pembelian',
                value: CurrencyFormatter.format(summary.totalPembelian),
                count: '${summary.countPembelian} transaksi',
                color: SipoColors.warning,
                bgColor: SipoColors.warningContainer,
                icon: Icons.shopping_cart_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'Penjualan',
                value: CurrencyFormatter.format(summary.totalPenjualan),
                count: '${summary.countPenjualan} transaksi',
                color: SipoColors.success,
                bgColor: SipoColors.successContainer,
                icon: Icons.point_of_sale_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String count;
  final Color color;
  final Color bgColor;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.count,
    required this.color,
    required this.bgColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: SipoColors.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(fontSize: 12, color: SipoColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
