import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/daos/analitik_dao.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/utils/currency_formatter.dart';
import '../../shared/utils/date_formatter.dart';
import '../providers/providers.dart';

class AnalitikPage extends ConsumerStatefulWidget {
  const AnalitikPage({super.key});

  @override
  ConsumerState<AnalitikPage> createState() => _AnalitikPageState();
}

class _AnalitikPageState extends ConsumerState<AnalitikPage> {
  int _selectedFilter = 0; // 0=hari ini, 1=7 hari, 2=30 hari, 3=custom
  final List<String> _filterLabels = [
    'Hari Ini',
    '7 Hari',
    '30 Hari',
    'Custom',
  ];

  String get _startDate {
    switch (_selectedFilter) {
      case 0:
        return DateFormatter.today();
      case 1:
        return DateFormatter.daysAgo(6);
      case 2:
        return DateFormatter.daysAgo(29);
      default:
        return DateFormatter.today();
    }
  }

  String get _endDate => DateFormatter.today();

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(_summaryProvider((_startDate, _endDate)));

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan')),
      body: Column(
        children: [
          // Date filter chips
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children:
                  _filterLabels.asMap().entries.map((entry) {
                    final i = entry.key;
                    final label = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          label,
                          style: const TextStyle(fontSize: 12),
                        ),
                        selected: _selectedFilter == i,
                        onSelected: (_) => setState(() => _selectedFilter = i),
                      ),
                    );
                  }).toList(),
            ),
          ),

          // Summary data
          Expanded(
            child: summaryAsync.when(
              data: (list) {
                if (list.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          size: 64,
                          color: SipoColors.muted,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Belum ada data transaksi',
                          style: TextStyle(color: SipoColors.muted),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(_summaryProvider((_startDate, _endDate)));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: list.length + 1, // +1 for header
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const _AnalitikHeader();
                      }
                      final item = list[index - 1];
                      return _AnalitikRow(summary: item);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}

final _summaryProvider =
    FutureProvider.family<List<AnalitikSummary>, (String, String)>((
      ref,
      range,
    ) {
      return ref
          .watch(analitikDaoProvider)
          .getSummaryByBarang(startDate: range.$1, endDate: range.$2);
    });

class _AnalitikHeader extends StatelessWidget {
  const _AnalitikHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: SipoColors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Barang',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              'Beli (qty)',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              'Beli (Rp)',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              'Jual (qty)',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              'Jual (Rp)',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              'Netto',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalitikRow extends StatelessWidget {
  final AnalitikSummary summary;
  const _AnalitikRow({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                summary.barangNama,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                summary.totalQtyPembelian.toStringAsFixed(1),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              width: 70,
              child: Text(
                CurrencyFormatter.format(summary.totalNilaiPembelian),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                summary.totalQtyPenjualan.toStringAsFixed(1),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              width: 70,
              child: Text(
                CurrencyFormatter.format(summary.totalNilaiPenjualan),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                summary.nettoQty.toStringAsFixed(1),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      summary.nettoQty >= 0
                          ? SipoColors.success
                          : SipoColors.danger,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
