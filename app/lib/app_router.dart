import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/beranda/beranda_page.dart';
import '../features/transaksi/transaksi_page.dart';
import '../features/transaksi/pembelian_page.dart';
import '../features/transaksi/penjualan_page.dart';
import '../features/transaksi/transaksi_detail_page.dart';
import '../features/satuan/satuan_page.dart';
import '../features/barang/barang_page.dart';
import '../features/customer/customer_page.dart';
import '../features/analitik/analitik_page.dart';
import '../shared/navigation/sipo_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            SipoShell(navigationShell: navigationShell),
        branches: [
          // Branch 0: Beranda
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const BerandaPage(),
              ),
            ],
          ),
          // Branch 1: Barang (swipeable)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/barang',
                builder: (context, state) => const BarangPage(),
              ),
            ],
          ),
          // Branch 2: Customer (swipeable)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customer',
                builder: (context, state) => const CustomerPage(),
              ),
            ],
          ),
          // Branch 3: Laporan
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/laporan',
                builder: (context, state) => const AnalitikPage(),
              ),
            ],
          ),
        ],
      ),
      // Transaksi pages (full screen, not in bottom nav)
      GoRoute(
        path: '/pembelian',
        builder: (context, state) => const PembelianPage(),
      ),
      GoRoute(
        path: '/penjualan',
        builder: (context, state) => const PenjualanPage(),
      ),
      GoRoute(
        path: '/transaksi/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return TransaksiDetailPage(transaksiId: id);
        },
      ),
      // Master data pages (accessible from settings or direct link)
      GoRoute(
        path: '/satuan',
        builder: (context, state) => const SatuanPage(),
      ),
      GoRoute(
        path: '/transaksi',
        builder: (context, state) => const TransaksiPage(),
      ),
    ],
  );
});
