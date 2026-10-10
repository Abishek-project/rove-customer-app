import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/money/money.dart';

void main() {
  group('Money formatting', () {
    test('AED uses western grouping and a code prefix', () {
      expect(const Money(125000, 'AED').format(), 'AED 1,250.00');
      expect(const Money(82688, 'AED').format(), 'AED 826.88');
      expect(const Money(5, 'AED').format(), 'AED 0.05');
    });

    test('INR uses en_IN lakh grouping and the rupee sign', () {
      expect(const Money(125000, 'INR').format(), '₹1,250.00');
      expect(const Money(12500000, 'INR').format(), '₹1,25,000.00');
      expect(const Money(1234567890, 'INR').format(), '₹1,23,45,678.90');
    });

    test('negative amounts (discounts) keep the sign in front', () {
      expect(const Money(-5000, 'AED').format(), '-AED 50.00');
      expect(const Money(-99, 'INR').format(), '-₹0.99');
    });

    test('compact drops zero minor units only', () {
      expect(const Money(25000, 'AED').formatCompact(), 'AED 250');
      expect(const Money(25050, 'AED').formatCompact(), 'AED 250.50');
      expect(const Money(220000, 'INR').formatCompact(), '₹2,200');
    });
  });

  group('Money arithmetic', () {
    test('adds and subtracts in minor units without floats', () {
      const a = Money(10, 'AED');
      const b = Money(20, 'AED');
      expect((a + b).amountMinor, 30);
      expect((b - a), const Money(10, 'AED'));
      expect((-a).amountMinor, -10);
      expect(a.multiply(3), const Money(30, 'AED'));
    });

    test('refuses to combine different currencies', () {
      expect(
        () => const Money(1, 'AED') + const Money(1, 'INR'),
        throwsArgumentError,
      );
      expect(
        () => const Money(1, 'AED').compareTo(const Money(1, 'INR')),
        throwsArgumentError,
      );
    });

    test('parses JSON money objects exactly', () {
      final m = Money.fromJson({'amountMinor': 82688, 'currency': 'AED'});
      expect(m, const Money(82688, 'AED'));
      expect(m.toJson(), {'amountMinor': 82688, 'currency': 'AED'});
    });
  });

  group('parseMajorToMinor', () {
    test('parses whole and decimal major units', () {
      expect(MoneyFormatter.parseMajorToMinor('250'), 25000);
      expect(MoneyFormatter.parseMajorToMinor('250.5'), 25050);
      expect(MoneyFormatter.parseMajorToMinor('1,500.25'), 150025);
    });

    test('rejects invalid input', () {
      expect(MoneyFormatter.parseMajorToMinor('abc'), isNull);
      expect(MoneyFormatter.parseMajorToMinor('1.234'), isNull);
      expect(MoneyFormatter.parseMajorToMinor('-5'), isNull);
    });
  });
}
