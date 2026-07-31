import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shell with bottom navigation (4 tabs per UX principle #19-#20)
class SipoShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const SipoShell({super.key, required this.navigationShell});

  @override
  State<SipoShell> createState() => _SipoShellState();
}

class _SipoShellState extends State<SipoShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      floatingActionButton: FloatingActionButton(
        // Center CTA per UX principle #20
        onPressed: () => _showTransaksiTypeSheet(context),
        elevation: 4,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavIcon(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Beranda',
              index: 0,
              currentIndex: widget.navigationShell.currentIndex,
              onTap: () => _navigate(0),
            ),
            const SizedBox(width: 48), // Space for FAB
            _NavIcon(
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart,
              label: 'Laporan',
              index: 3,
              currentIndex: widget.navigationShell.currentIndex,
              onTap: () => _navigate(3),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(int index) {
    if (index == widget.navigationShell.currentIndex) return;
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _showTransaksiTypeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  child: Icon(Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                title: const Text('Pembelian'),
                subtitle: const Text('Catat pembelian dari supplier'),
                onTap: () {
                  Navigator.pop(ctx);
                  context.push('/pembelian');
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(Icons.point_of_sale,
                      color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text('Penjualan'),
                subtitle: const Text('Catat penjualan ke pelanggan'),
                onTap: () {
                  Navigator.pop(ctx);
                  context.push('/penjualan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    // UX #24: active state has 2+ visual changes (icon + color + weight)
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
