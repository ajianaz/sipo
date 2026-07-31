import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/database/daos/barang_dao.dart';
import '../../data/repositories/barang_repository.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/utils/currency_formatter.dart';
import '../../shared/widgets/sipo_empty_state.dart';
import '../../shared/widgets/sipo_confirm_sheet.dart';
import '../providers/providers.dart';

class BarangPage extends ConsumerWidget {
  const BarangPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barangAsync = ref.watch(_barangWithSatuanProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Barang')),
      body: barangAsync.when(
        data: (list) => list.isEmpty
            ? const SipoEmptyState(
                title: 'Belum ada barang',
                subtitle: 'Tambahkan barang untuk mulai mencatat transaksi.',
                actionLabel: 'Tambah Barang',
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(_barangWithSatuanProvider);
                },
                child: ListView.builder(
                  itemCount: list.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(item.barang.nama),
                        subtitle: Text(
                          '${item.satuan.nama} • ${CurrencyFormatter.format(item.barang.hargaBeli)} / ${CurrencyFormatter.format(item.barang.hargaJual)}',
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) => _handleMenu(
                            context, ref, value, item.barang,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'edit', child: Text('Edit')),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Hapus',
                                  style: TextStyle(color: SipoColors.danger)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleMenu(
    BuildContext context,
    WidgetRef ref,
    String action,
    Barang barang,
  ) {
    switch (action) {
      case 'edit':
        _showForm(context, ref, barang: barang);
      case 'delete':
        _showDeleteConfirm(context, ref, barang);
    }
  }

  void _showForm(BuildContext context, WidgetRef ref, {Barang? barang}) async {
    final namaCtrl = TextEditingController(text: barang?.nama ?? '');
    final hargaBeliCtrl =
        TextEditingController(text: barang?.hargaBeli.toStringAsFixed(2) ?? '');
    final hargaJualCtrl =
        TextEditingController(text: barang?.hargaJual.toStringAsFixed(2) ?? '');

    // Load satuans for dropdown
    final satuans = await ref.read(satuanDaoProvider).getAllActive();
    if (!context.mounted) return;

    final selectedSatuanId = ValueNotifier<int?>(barang?.satuanId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).padding.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              barang == null ? 'Tambah Barang' : 'Edit Barang',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<int?>(
              valueListenable: selectedSatuanId,
              builder: (_, value, __) => DropdownButtonFormField<int>(
                initialValue: value,
                decoration: const InputDecoration(labelText: 'Satuan'),
                items: satuans
                    .map((s) => DropdownMenuItem(
                          value: s.id,
                          child: Text(s.nama),
                        ))
                    .toList(),
                onChanged: (v) => selectedSatuanId.value = v,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: hargaBeliCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Harga Beli',
                      prefixText: 'Rp ',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: hargaJualCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Harga Jual',
                      prefixText: 'Rp ',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                if (namaCtrl.text.trim().isEmpty ||
                    selectedSatuanId.value == null) {
                  return;
                }
                final repo = BarangRepository(ref.read(barangDaoProvider));
                if (barang == null) {
                  await repo.create(
                    nama: namaCtrl.text.trim(),
                    satuanId: selectedSatuanId.value!,
                    hargaBeli: double.parse(hargaBeliCtrl.text),
                    hargaJual: double.parse(hargaJualCtrl.text),
                  );
                } else {
                  await repo.update(
                    id: barang.id,
                    nama: namaCtrl.text.trim(),
                    satuanId: selectedSatuanId.value!,
                    hargaBeli: double.parse(hargaBeliCtrl.text),
                    hargaJual: double.parse(hargaJualCtrl.text),
                  );
                }
                ref.invalidate(_barangWithSatuanProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(barang == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, Barang barang) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SipoConfirmSheet(
        title: 'Hapus "${barang.nama}"?',
        children: const [],
        onConfirm: () async {
          await ref.read(barangDaoProvider).deleteById(barang.id);
          ref.invalidate(_barangWithSatuanProvider);
          if (ctx.mounted) Navigator.pop(ctx);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Barang dihapus')),
            );
          }
        },
        onCancel: () => Navigator.pop(ctx),
      ),
    );
  }
}

final _barangWithSatuanProvider =
    FutureProvider<List<BarangWithSatuan>>((ref) {
  return ref.watch(barangDaoProvider).getAllWithSatuan();
});
