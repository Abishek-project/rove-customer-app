import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// An exact amount of money in integer minor units (paise, fils).
///
/// Never constructed from floating point and never summed across currencies.
class Money extends Equatable implements Comparable<Money> {
  const Money(this.amountMinor, this.currency);

  const Money.zero(this.currency) : amountMinor = 0;

  factory Money.fromJson(Map<String, dynamic> json) =>
      Money((json['amountMinor'] as num).toInt(), json['currency'] as String);

  final int amountMinor;
  final String currency;

  Map<String, dynamic> toJson() => {
    'amountMinor': amountMinor,
    'currency': currency,
  };

  bool get isZero => amountMinor == 0;
  bool get isNegative => amountMinor < 0;

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money(amountMinor + other.amountMinor, currency);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money(amountMinor - other.amountMinor, currency);
  }

  Money operator -() => Money(-amountMinor, currency);

  Money abs() => Money(amountMinor.abs(), currency);

  Money multiply(int factor) => Money(amountMinor * factor, currency);

  void _assertSameCurrency(Money other) {
    if (other.currency != currency) {
      throw ArgumentError(
        'Cannot combine $currency with ${other.currency} amounts',
      );
    }
  }

  @override
  int compareTo(Money other) {
    _assertSameCurrency(other);
    return amountMinor.compareTo(other.amountMinor);
  }

  /// Formats with full minor units, e.g. `AED 1,250.00` or `₹1,25,000.00`.
  String format({String? locale}) =>
      MoneyFormatter.format(this, locale: locale);

  /// Formats without minor units when they are zero, e.g. `AED 250`.
  String formatCompact({String? locale}) =>
      MoneyFormatter.format(this, locale: locale, compact: true);

  @override
  List<Object?> get props => [amountMinor, currency];

  @override
  String toString() => 'Money($amountMinor $currency)';
}

/// Currency display rules. Integer-only: the major and minor parts are
/// formatted separately, so no floating point is involved.
class MoneyFormatter {
  const MoneyFormatter._();

  static const _minorDigits = <String, int>{'INR': 2, 'AED': 2};

  /// The number-grouping locale for a currency: Indian lakh/crore grouping
  /// for INR, western grouping otherwise.
  static String localeFor(String currency) => switch (currency) {
    'INR' => 'en_IN',
    _ => 'en',
  };

  static String symbolFor(String currency) => switch (currency) {
    'INR' => '₹',
    _ => '$currency ',
  };

  static String format(Money money, {String? locale, bool compact = false}) {
    final digits = _minorDigits[money.currency] ?? 2;
    final divisor = _pow10(digits);
    final absolute = money.amountMinor.abs();
    final major = absolute ~/ divisor;
    final minor = absolute % divisor;
    final numberLocale = locale ?? localeFor(money.currency);
    final pattern = NumberFormat.decimalPattern(numberLocale);
    final majorText = pattern.format(major);
    final showMinor = !(compact && minor == 0) && digits > 0;
    final decimalSep = pattern.symbols.DECIMAL_SEP;
    final body = showMinor
        ? '$majorText$decimalSep${minor.toString().padLeft(digits, '0')}'
        : majorText;
    final sign = money.amountMinor < 0 ? '-' : '';
    return '$sign${symbolFor(money.currency)}$body';
  }

  static int _pow10(int digits) {
    var result = 1;
    for (var i = 0; i < digits; i++) {
      result *= 10;
    }
    return result;
  }

  /// Parses user-entered major units ("1500" or "1500.50") to minor units
  /// without floating point. Returns null when the input is not a number.
  static int? parseMajorToMinor(String input, {int digits = 2}) {
    final trimmed = input.trim().replaceAll(',', '');
    final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(trimmed);
    if (match == null) return null;
    final major = int.parse(match.group(1)!);
    final minorText = (match.group(2) ?? '').padRight(digits, '0');
    return major * _pow10(digits) + int.parse(minorText);
  }
}
