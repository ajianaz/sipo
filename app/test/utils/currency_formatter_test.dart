import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/shared/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter', () {
    test('format whole numbers correctly', () {
      expect(CurrencyFormatter.format(0), 'Rp 0');
      expect(CurrencyFormatter.format(1500), 'Rp 1.500');
      expect(CurrencyFormatter.format(1000000), 'Rp 1.000.000');
    });

    test('format decimal numbers correctly', () {
      expect(CurrencyFormatter.format(1500.50), 'Rp 1.500,50');
      expect(CurrencyFormatter.format(99.99), 'Rp 99,99');
    });

    test('parse handles Rp prefix and dots', () {
      expect(CurrencyFormatter.parse('Rp 1.500'), 1500.0);
      expect(CurrencyFormatter.parse('1.500'), 1500.0);
      expect(CurrencyFormatter.parse('1500'), 1500.0);
      // "Rp 1.000.000" = 1 million
      expect(CurrencyFormatter.parse('Rp 1.000.000'), 1000000.0);
      // Comma as decimal separator
      expect(CurrencyFormatter.parse('1.500,50'), 1500.5);
    });

    test('parse returns 0 for invalid input', () {
      expect(CurrencyFormatter.parse('abc'), 0.0);
      expect(CurrencyFormatter.parse(''), 0.0);
    });
  });
}
