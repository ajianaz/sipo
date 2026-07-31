import 'package:flutter_test/flutter_test.dart';
import 'package:sipo/shared/utils/decimal_validator.dart';

void main() {
  group('DecimalValidator', () {
    test('returns error for empty value', () {
      expect(DecimalValidator.validate(''), isNotNull);
      expect(DecimalValidator.validate(null), isNotNull);
    });

    test('returns error for non-numeric', () {
      expect(DecimalValidator.validate('abc'), isNotNull);
    });

    test('returns null for valid number', () {
      expect(DecimalValidator.validate('10'), isNull);
      expect(DecimalValidator.validate('10.5'), isNull);
    });

    test('returns null for zero', () {
      expect(DecimalValidator.validate('0'), isNull);
    });
  });
}
