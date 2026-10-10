import 'package:json_annotation/json_annotation.dart';

/// Postgres `numeric` columns may arrive as strings; accept both.
class LenientDoubleConverter implements JsonConverter<double?, Object?> {
  const LenientDoubleConverter();

  @override
  double? fromJson(Object? json) => switch (json) {
    null => null,
    final num n => n.toDouble(),
    final String s => double.tryParse(s),
    _ => null,
  };

  @override
  Object? toJson(double? object) => object;
}
