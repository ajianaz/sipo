import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/satuan_repository.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/widgets/sipo_empty_state.dart';
import '../../shared/widgets/sipo_confirm_sheet.dart';
import '../providers/providers.dart';

class SatuanPage extends ConsumerWidget {
  const SatuanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final satuansAsync = ref.watch(_satuansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Satuan'),
      ),
      body: satuansAsync.when(
        data: (list) => list.isEmpty
            ? const SipoEmptyState(
                title: 'Belum ada satuan',
                subtitle: 'Tambahkan satuan seperti kg, liter, pcs, dll.',
                actionLabel: 'Tambah Satuan',
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(_satuansProvider);
                },
                child: ListView.builder(
                  itemCount: list.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(item.nama),
                        subtitle: item.deskripsi != null
                            ? Text(item.deskripsi!)
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (item.isActive != 1)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: SipoColors.dangerContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Nonaktif',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: SipoColors.danger,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            PopupMenuButton<String>(
                              onSelected: (value) => _handleMenuAction(
                                context, ref, value, item,
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: item.isActive == 1 ? 'deactivate' : 'activate',
                                  child: Text(item.isActive == 1
                                      ? 'Nonaktifkan'
                                      : 'Aktifkan'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Hapus',
                                      style: TextStyle(color: SipoColors.danger)),
                                ),
                              ],
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

  void _handleMenuAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    Satuan item,
  ) {
    switch (action) {
      case 'edit':
        _showForm(context, ref, item: item);
      case 'deactivate':
      case 'activate':
        ref.read(satuanDaoProvider).toggleActive(item.id).then((_) {
          ref.invalidate(_satuansProvider);
        });
      case 'delete':
        _showDeleteConfirm(context, ref, item);
    }
  }

  void _showForm(BuildContext context, WidgetRef ref, {Satuan? item}) {
    final namaCtrl = TextEditingController(text: item?.nama ?? '');
    final deskripsiCtrl =
        TextEditingController(text: item?.deskripsi ?? '');

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
              item == null ? 'Tambah Satuan' : 'Edit Satuan',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama Satuan',
                hintText: 'Contoh: kg, liter, pcs',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: deskripsiCtrl,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Opsional',
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                if (namaCtrl.text.trim().isEmpty) return;
                final repo = SatuanRepository(ref.read(satuanDaoProvider));
                if (item == null) {
                  await repo.create(
                    nama: namaCtrl.text.trim(),
                    deskripsi: deskripsiCtrl.text.trim().isEmpty
                        ? null
                        : deskripsiCtrl.text.trim(),
                  );
                } else {
                  await repo.update(
                    id: item.id,
                    nama: namaCtrl.text.trim(),
                    deskripsi: deskripsiCtrl.text.trim().isEmpty
                        ? null
                        : deskripsiCtrl.text.trim(),
                    isActive: item.isActive == 1,
                  );
                }
                ref.invalidate(_satuansProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(item == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, Satuan item) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SipoConfirmSheet(
        title: 'Hapus "${item.nama}"?',
        subtitle: 'Satuan yang sudah dipakai di barang tidak bisa dihapus.',
        children: const [],
        onConfirm: () async {
          await ref.read(satuanDaoProvider).deleteById(item.id);
          ref.invalidate(_satuansProvider);
          if (ctx.mounted) Navigator.pop(ctx);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Satuan dihapus')),
            );
          }
        },
        onCancel: () => Navigator.pop(ctx),
      ),
    );
  }
}

final _satuansProvider = FutureProvider<List<Satuan>>((ref) {
  return ref.watch(satuanDaoProvider).getAll();
});
