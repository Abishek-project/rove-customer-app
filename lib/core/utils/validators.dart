/// Pure form validators. They return an error key (not a message) so the UI
/// can localise it and tests can assert on it.
enum FieldError {
  required,
  tooShort,
  tooLong,
  invalidPhone,
  invalidEmail,
  invalidDate,
  underage,
}

abstract final class Validators {
  static FieldError? requiredText(String? value, {int min = 1, int max = 200}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return FieldError.required;
    if (text.length < min) return FieldError.tooShort;
    if (text.length > max) return FieldError.tooLong;
    return null;
  }

  static FieldError? fullName(String? value) =>
      requiredText(value, min: 2, max: 100);

  /// E.164-ish: optional +, 8–15 digits, spaces and dashes allowed.
  static FieldError? phone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return FieldError.required;
    final digits = text.replaceAll(RegExp(r'[\s\-()]'), '');
    if (!RegExp(r'^\+?\d{8,15}$').hasMatch(digits)) {
      return FieldError.invalidPhone;
    }
    return null;
  }

  static FieldError? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return FieldError.required;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
      return FieldError.invalidEmail;
    }
    return null;
  }

  /// Driver must be at least [minAge] on [today].
  static FieldError? dateOfBirth(
    DateTime? value, {
    required DateTime today,
    int minAge = 21,
  }) {
    if (value == null) return FieldError.required;
    if (value.isAfter(today)) return FieldError.invalidDate;
    if (ageOn(value, today) < minAge) return FieldError.underage;
    return null;
  }

  static int ageOn(DateTime birth, DateTime today) {
    var age = today.year - birth.year;
    if (today.month < birth.month ||
        (today.month == birth.month && today.day < birth.day)) {
      age--;
    }
    return age;
  }

  /// Support request message: 10–2000 characters.
  static FieldError? supportMessage(String? value) =>
      requiredText(value, min: 10, max: 2000);

  static FieldError? supportSubject(String? value) =>
      requiredText(value, min: 3, max: 120);
}
