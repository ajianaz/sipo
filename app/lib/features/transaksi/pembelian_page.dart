import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/database/app_database.dart';
import '../../data/database/daos/transaksi_dao.dart';
import '../../data/repositories/transaksi_repository.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/utils/currency_formatter.dart';
import '../../shared/widgets/quantity_stepper.dart';
import '../../shared/widgets/sipo_confirm_sheet.dart';
import '../providers/providers.dart';

/// Pembelian form page
class PembelianPage extends ConsumerStatefulWidget {
  const PembelianPage({super.key});

  @override
  ConsumerState<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends ConsumerState<PembelianPage> {
  Customer? _selectedCustomer;
  final List<_CartItem> _cart = [];
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(_customersProvider);
    final barangsAsync = ref.watch(_barangProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembelian'),
        actions: [
          if (_cart.isNotEmpty)
            TextButton(
              onPressed: _showReviewSheet,
              child: Text(
                '${_cart.length} item • ${CurrencyFormatter.format(_total)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: SipoColors.primary,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1: Select Customer
            Text(
              'Supplier',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            customersAsync.when(
              data:
                  (list) => _CustomerSelector(
                    customers: list,
                    selected: _selectedCustomer,
                    onSelected: (c) => setState(() => _selectedCustomer = c),
                  ),
              loading:
                  () => const SizedBox(
                    height: 48,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 24),

            // Step 2: Add Items
            Row(
              children: [
                Text(
                  'Tambah Barang',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            barangsAsync.when(
              data:
                  (list) => _BarangSelector(
                    barangs: list,
                    cart: _cart,
                    onAdd: (barang) {
                      setState(() {
                        _cart.add(
                          _CartItem(
                            barang: barang,
                            jumlah: 1,
                            hargaSatuan: barang.hargaBeli,
                          ),
                        );
                      });
                    },
                  ),
              loading:
                  () => const SizedBox(
                    height: 48,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 16),

            // Cart Items
            if (_cart.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Keranjang',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ..._cart.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.barang.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Rp ${item.hargaSatuan.toStringAsFixed(2)} / item',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: SipoColors.muted,
                                ),
                              ),
                              const SizedBox(height: 8),
                              QuantityStepper(
                                initialValue: item.jumlah,
                                step: 0.5,
                                onChanged: (val) {
                                  setState(() => item.jumlah = val);
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              CurrencyFormatter.format(item.subtotal),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: SipoColors.danger,
                              ),
                              onPressed: () {
                                setState(() => _cart.removeAt(i));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 12),
              // Total
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: SipoColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      CurrencyFormatter.format(_total),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: SipoColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isSaving ? null : _showReviewSheet,
                  icon:
                      _isSaving
                          ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Icon(Icons.save),
                  label: const Text('Simpan Pembelian'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double get _total => _cart.fold(0.0, (sum, item) => sum + item.subtotal);

  void _showReviewSheet() {
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih supplier dulu')));
      return;
    }
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tambahkan barang dulu')));
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (ctx) => SipoConfirmSheet(
            title: 'Konfirmasi Pembelian',
            subtitle: 'Supplier: ${_selectedCustomer!.nama}',
            children: [
              ..._cart.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${item.barang.nama} × ${item.jumlah}'),
                      ),
                      Text(CurrencyFormatter.format(item.subtotal)),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    CurrencyFormatter.format(_total),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: SipoColors.primary,
                    ),
                  ),
                ],
              ),
            ],
            onConfirm: () async {
              Navigator.pop(ctx);
              await _save();
            },
            onCancel: () => Navigator.pop(ctx),
          ),
    );
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      final repo = TransaksiRepository(ref.read(transaksiDaoProvider));
      await repo.createPembelian(
        customerId: _selectedCustomer!.id,
        totalHarga: _total,
        items:
            _cart
                .map(
                  (c) => TransaksiDetailItem(
                    barangId: c.barang.id,
                    jumlah: c.jumlah,
                    hargaSatuan: c.hargaSatuan,
                    subtotal: c.subtotal,
                  ),
                )
                .toList(),
      );

      if (mounted) {
        setState(() {
          _cart.clear();
          _selectedCustomer = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Pembelian berhasil disimpan!'),
            backgroundColor: SipoColors.success,
          ),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }
}

class _CartItem {
  Barang barang;
  double jumlah;
  double hargaSatuan;

  _CartItem({
    required this.barang,
    required this.jumlah,
    required this.hargaSatuan,
  });

  double get subtotal => jumlah * hargaSatuan;
}

final _customersProvider = FutureProvider<List<Customer>>((ref) {
  return ref.watch(customerDaoProvider).getRecent(limit: 10);
});

final _barangProvider = FutureProvider<List<Barang>>((ref) {
  return ref.watch(barangDaoProvider).getAll();
});

class _CustomerSelector extends StatelessWidget {
  final List<Customer> customers;
  final Customer? selected;
  final ValueChanged<Customer> onSelected;

  const _CustomerSelector({
    required this.customers,
    this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (customers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Belum ada customer. Tambahkan di tab Customer dulu.',
          style: TextStyle(color: SipoColors.muted, fontSize: 13),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          customers.map((c) {
            final isSelected = selected?.id == c.id;
            return ChoiceChip(
              label: Text(c.nama),
              selected: isSelected,
              onSelected: (_) => onSelected(c),
            );
          }).toList(),
    );
  }
}

class _BarangSelector extends StatefulWidget {
  final List<Barang> barangs;
  final List<_CartItem> cart;
  final ValueChanged<Barang> onAdd;

  const _BarangSelector({
    required this.barangs,
    required this.cart,
    required this.onAdd,
  });

  @override
  State<_BarangSelector> createState() => _BarangSelectorState();
}

class _BarangSelectorState extends State<_BarangSelector> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered =
        _query.isEmpty
            ? widget.barangs
            : widget.barangs
                .where(
                  (b) => b.nama.toLowerCase().contains(_query.toLowerCase()),
                )
                .toList();

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Cari barang...',
            prefixIcon: Icon(Icons.search),
            isDense: true,
          ),
          onChanged: (v) => setState(() => _query = v),
        ),
        const SizedBox(height: 8),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Tidak ditemukan',
              style: TextStyle(color: SipoColors.muted),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              filtered.map((b) {
                final inCart = widget.cart.any((c) => c.barang.id == b.id);
                return ActionChip(
                  avatar: Icon(
                    inCart ? Icons.check_circle : Icons.add_circle_outline,
                    size: 18,
                    color: inCart ? SipoColors.success : SipoColors.muted,
                  ),
                  label: Text(
                    '${b.nama} (${CurrencyFormatter.format(b.hargaBeli)})',
                    style: const TextStyle(fontSize: 12),
                  ),
                  onPressed: inCart ? null : () => widget.onAdd(b),
                );
              }).toList(),
        ),
      ],
    );
  }
}
