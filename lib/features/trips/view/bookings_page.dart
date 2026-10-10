import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/repositories/booking_repository.dart';
import '../bloc/booking_list_cubit.dart';
import 'booking_tile.dart';

/// My Bookings: upcoming, pending, active, completed and cancelled.
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: BookingGroup.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.bookingsTitle),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: RoveColors.border,
            indicatorColor: RoveColors.primary,
            labelColor: RoveColors.primary,
            unselectedLabelColor: RoveColors.textSecondary,
            tabs: [
              for (final g in BookingGroup.values)
                Tab(key: ValueKey('tab-${g.name}'), text: l10n.bookingGroup(g)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final g in BookingGroup.values)
              BlocProvider(
                key: ValueKey(g),
                create: (context) =>
                    BookingListCubit(context.read<BookingRepository>(), g)
                      ..load(),
                child: const _BookingList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _BookingList extends StatefulWidget {
  const _BookingList();

  @override
  State<_BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<_BookingList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;
    return BlocBuilder<BookingListCubit, BookingListState>(
      builder: (context, state) {
        final cubit = context.read<BookingListCubit>();
        switch (state.status) {
          case LoadStatus.initial:
          case LoadStatus.loading when state.bookings.isEmpty:
            return const Padding(
              padding: EdgeInsets.all(RoveSpacing.md),
              child: ListSkeleton(),
            );
          case LoadStatus.failure when state.bookings.isEmpty:
            return ErrorState(failure: state.failure!, onRetry: cubit.load);
          case LoadStatus.empty:
            return RefreshIndicator(
              onRefresh: cubit.load,
              child: ListView(
                children: [
                  const SizedBox(height: RoveSpacing.xxl),
                  EmptyState(
                    message: l10n.bookingGroupEmpty(state.group),
                    actionLabel: l10n.findACar,
                    onAction: () => context.go(Routes.explore),
                  ),
                ],
              ),
            );
          default:
            return RefreshIndicator(
              onRefresh: cubit.load,
              child: NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  if (n.metrics.extentAfter < 400) cubit.loadMore();
                  return false;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(RoveSpacing.md),
                  itemCount: state.bookings.length,
                  itemBuilder: (context, i) {
                    final booking = state.bookings[i];
                    return BookingTile(
                      key: ValueKey('booking-${booking.id}'),
                      booking: booking,
                      onTap: () async {
                        await context.push(Routes.booking(booking.id));
                        await cubit.load();
                      },
                    );
                  },
                ),
              ),
            );
        }
      },
    );
  }
}
