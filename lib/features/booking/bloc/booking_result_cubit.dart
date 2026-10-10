import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../shared/repositories/booking_repository.dart';
import 'checkout_result.dart';

class BookingResultState {
  const BookingResultState(this.result, {this.refreshing = false});
  final CheckoutResult result;
  final bool refreshing;
}

/// Holds the result screen's state and refreshes it from `GET /bookings/:id`
/// so the screen can always show the backend's view.
class BookingResultCubit extends Cubit<BookingResultState> {
  BookingResultCubit(this._repository, CheckoutResult initial, this.bookingId)
    : super(BookingResultState(initial));

  final BookingRepository _repository;
  final String? bookingId;

  Future<void> refresh() async {
    final id = state.result.booking?.id ?? bookingId;
    if (id == null || state.refreshing) return;
    emit(BookingResultState(state.result, refreshing: true));
    try {
      final booking = await _repository.get(id);
      emit(
        BookingResultState(
          CheckoutResult(booking: booking, intent: state.result.intent),
        ),
      );
    } on ApiFailure catch (f) {
      emit(BookingResultState(state.result.copyWith(failure: () => f)));
    }
  }

  void update(CheckoutResult result) => emit(BookingResultState(result));
}
