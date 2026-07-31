class CurrencyFormatter {
  /// Format currency as Rp xxx with thousand separators
  static String format(double amount) {
    if (amount == amount.truncateToDouble()) {
      return 'Rp ${_formatInt(amount.toInt())}';
    }
    // For decimals: format the integer part with dots, append decimal part
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = int.parse(parts[0]);
    return 'Rp ${_formatInt(intPart)},${parts[1]}';
  }

  static String _formatInt(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => '.',
    );
  }

  /// Parse Indonesian Rupiah format back to double.
  /// Indonesian format: dots = thousand separator, comma = decimal separator.
  /// Handles: "Rp 1.500.000", "1.500", "1500", "Rp 1.500,50", "1.500,50"
  static double parse(String value) {
    if (value.isEmpty) return 0.0;
    // If there's a comma, it's the decimal separator
    if (value.contains(',')) {
      // "1.500,50" → split on comma → ["1.500", "50"]
      // Remove dots from integer part → "1500.50"
      final parts = value.split(',');
      final intPart = parts[0].replaceAll(RegExp(r'[^\d]'), '');
      final decPart = parts[1].replaceAll(RegExp(r'[^\d]'), '');
      return double.tryParse('$intPart.$decPart') ?? 0.0;
    }
    // No comma → all dots are thousand separators, strip everything non-digit
    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }
}
