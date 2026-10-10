/// Example phone formats shown as helper text (formats, not translations).
String phoneExample(String? countryCode) => switch (countryCode) {
  'IN' => '+91 98123 45678',
  'AE' => '+971 50 123 4567',
  _ => '+971 50 123 4567',
};
