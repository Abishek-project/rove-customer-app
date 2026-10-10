import '../models/profile.dart';

abstract interface class SupportRepository {
  Future<SupportRequest> create({
    required String subject,
    required String message,
    String? bookingId,
  });

  Future<List<SupportRequest>> list();
}
