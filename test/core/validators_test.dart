import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/utils/validators.dart';

void main() {
  group('form validation', () {
    test('full name', () {
      expect(Validators.fullName(''), FieldError.required);
      expect(Validators.fullName('  '), FieldError.required);
      expect(Validators.fullName('A'), FieldError.tooShort);
      expect(Validators.fullName('Aisha Khan'), isNull);
      expect(Validators.fullName('x' * 101), FieldError.tooLong);
    });

    test('phone accepts international formats', () {
      expect(Validators.phone('+971 50 123 4567'), isNull);
      expect(Validators.phone('+91 98123-45678'), isNull);
      expect(Validators.phone('12345'), FieldError.invalidPhone);
      expect(Validators.phone('+97150abc4567'), FieldError.invalidPhone);
      expect(Validators.phone(null), FieldError.required);
    });

    test('email', () {
      expect(Validators.email('customer@rove.test'), isNull);
      expect(Validators.email('nope'), FieldError.invalidEmail);
      expect(Validators.email(''), FieldError.required);
    });

    test('driver date of birth: 21+', () {
      final today = DateTime(2026, 10, 10);
      expect(Validators.dateOfBirth(null, today: today), FieldError.required);
      expect(
        Validators.dateOfBirth(DateTime(2005, 10, 10), today: today),
        isNull,
      );
      expect(
        Validators.dateOfBirth(DateTime(2005, 10, 11), today: today),
        FieldError.underage,
      );
      expect(
        Validators.dateOfBirth(DateTime(2027, 1, 1), today: today),
        FieldError.invalidDate,
      );
    });

    test('support request', () {
      expect(Validators.supportSubject('Hi'), FieldError.tooShort);
      expect(Validators.supportMessage('short'), FieldError.tooShort);
      expect(
        Validators.supportMessage('My pickup time needs to change.'),
        isNull,
      );
    });
  });
}
