import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: SipoApp()));
}

class SipoApp extends StatelessWidget {
  const SipoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sipo — Simple POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2563EB),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const Scaffold(
        body: Center(child: Text('Sipo — Simple POS\nv0.1.0')),
      ),
    );
  }
}
