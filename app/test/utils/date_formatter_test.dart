import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/shared/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('dateTimeFromString parses ISO string', () {
      final result = DateFormatter.dateTimeFromString('2025-01-15T10:30:00');
      expect(result, contains('15 Jan 2025'));
      expect(result, contains('10:30'));
    });

    test('today returns yyyy-MM-dd format', () {
      final result = DateFormatter.today();
      expect(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(result), true);
    });

    test('daysAgo returns yyyy-MM-dd format', () {
      final result = DateFormatter.daysAgo(7);
      expect(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(result), true);
    });

    test('daysAgo(0) equals today', () {
      expect(DateFormatter.daysAgo(0), DateFormatter.today());
    });

    test('parse converts yyyy-MM-dd to DateTime', () {
      final dt = DateFormatter.parse('2025-01-15');
      expect(dt.year, 2025);
      expect(dt.month, 1);
      expect(dt.day, 15);
    });
  });
}
