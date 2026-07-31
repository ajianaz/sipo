import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';
import 'shared/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SipoApp()));
}

class SipoApp extends ConsumerWidget {
  const SipoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Sipo — Simple POS',
      debugShowCheckedModeBanner: false,
      theme: SipoTheme.light,
      routerConfig: router,
    );
  }
}
