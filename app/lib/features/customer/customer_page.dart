import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/customer_repository.dart';
import '../../shared/theme/sipo_colors.dart';
import '../../shared/widgets/sipo_empty_state.dart';
import '../../shared/widgets/sipo_confirm_sheet.dart';
import '../providers/providers.dart';

class CustomerPage extends ConsumerWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(_customersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Customer')),
      body: customersAsync.when(
        data:
            (list) =>
                list.isEmpty
                    ? const SipoEmptyState(
                      title: 'Belum ada customer',
                      subtitle:
                          'Tambahkan supplier dan pelanggan untuk transaksi.',
                      actionLabel: 'Tambah Customer',
                    )
                    : RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(_customersProvider);
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
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.noHp != null) Text(item.noHp!),
                                  if (item.alamat != null) Text(item.alamat!),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected:
                                    (value) =>
                                        _handleMenu(context, ref, value, item),
                                itemBuilder:
                                    (context) => [
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text(
                                          'Hapus',
                                          style: TextStyle(
                                            color: SipoColors.danger,
                                          ),
                                        ),
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
    Customer item,
  ) {
    switch (action) {
      case 'edit':
        _showForm(context, ref, customer: item);
      case 'delete':
        _showDeleteConfirm(context, ref, item);
    }
  }

  void _showForm(BuildContext context, WidgetRef ref, {Customer? customer}) {
    final namaCtrl = TextEditingController(text: customer?.nama ?? '');
    final noHpCtrl = TextEditingController(text: customer?.noHp ?? '');
    final alamatCtrl = TextEditingController(text: customer?.alamat ?? '');
    final catatanCtrl = TextEditingController(text: customer?.catatan ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(ctx).padding.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    customer == null ? 'Tambah Customer' : 'Edit Customer',
                    style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: namaCtrl,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    autofocus: true,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: noHpCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'No HP'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: alamatCtrl,
                    decoration: const InputDecoration(labelText: 'Alamat'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: catatanCtrl,
                    decoration: const InputDecoration(labelText: 'Catatan'),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      if (namaCtrl.text.trim().isEmpty) return;
                      final repo = CustomerRepository(
                        ref.read(customerDaoProvider),
                      );
                      if (customer == null) {
                        await repo.create(
                          nama: namaCtrl.text.trim(),
                          noHp:
                              noHpCtrl.text.trim().isEmpty
                                  ? null
                                  : noHpCtrl.text.trim(),
                          alamat:
                              alamatCtrl.text.trim().isEmpty
                                  ? null
                                  : alamatCtrl.text.trim(),
                          catatan:
                              catatanCtrl.text.trim().isEmpty
                                  ? null
                                  : catatanCtrl.text.trim(),
                        );
                      } else {
                        await repo.update(
                          id: customer.id,
                          nama: namaCtrl.text.trim(),
                          noHp:
                              noHpCtrl.text.trim().isEmpty
                                  ? null
                                  : noHpCtrl.text.trim(),
                          alamat:
                              alamatCtrl.text.trim().isEmpty
                                  ? null
                                  : alamatCtrl.text.trim(),
                          catatan:
                              catatanCtrl.text.trim().isEmpty
                                  ? null
                                  : catatanCtrl.text.trim(),
                        );
                      }
                      ref.invalidate(_customersProvider);
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: Text(customer == null ? 'Tambah' : 'Simpan'),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, Customer item) {
    showModalBottomSheet(
      context: context,
      builder:
          (ctx) => SipoConfirmSheet(
            title: 'Hapus "${item.nama}"?',
            children: const [],
            onConfirm: () async {
              await ref.read(customerDaoProvider).deleteById(item.id);
              ref.invalidate(_customersProvider);
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Customer dihapus')),
                );
              }
            },
            onCancel: () => Navigator.pop(ctx),
          ),
    );
  }
}

final _customersProvider = FutureProvider<List<Customer>>((ref) {
  return ref.watch(customerDaoProvider).getAll();
});
