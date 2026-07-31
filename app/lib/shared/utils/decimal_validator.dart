class DecimalValidator {
  /// Validate decimal input — max 2 decimal places, min 0
  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Wajib diisi';
    final parsed = double.tryParse(value);
    if (parsed == null) return 'Format angka tidak valid';
    if (parsed < 0) return 'Tidak boleh negatif';
    if (value.contains('.') && value.split('.').last.length > 2) {
      return 'Maksimal 2 digit desimal';
    }
    return null;
  }

  /// Parse string to double with 2 decimal precision
  static double parse(String value) {
    final parsed = double.parse(value);
    return double.parse(parsed.toStringAsFixed(2));
  }

  /// Format double to 2 decimal string
  static String format(double value) => value.toStringAsFixed(2);
}
