import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/utils/rental_period.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/state_views.dart';
import '../../search/bloc/trip_cubit.dart';

/// Pickup and return selection. Times are wall-clock times in the city's
/// time zone and are converted to UTC for the API.
class DatesPage extends StatefulWidget {
  const DatesPage({super.key});

  @override
  State<DatesPage> createState() => _DatesPageState();
}

class _DatesPageState extends State<DatesPage> {
  late final TripCubit _trip = context.read<TripCubit>();
  late DateTime _pickupLocal;
  late DateTime _returnLocal;

  String? get _tz => _trip.state.timezone;

  @override
  void initState() {
    super.initState();
    _trip.ensureDates();
    final s = _trip.state;
    final localNow = ZonedTime.now(_tz, clock: _trip.now);
    final defaults = RentalPeriod.defaultLocalRange(localNow);
    _pickupLocal = s.pickupAt == null
        ? defaults.pickupLocal
        : _naive(ZonedTime.inZone(s.pickupAt!, _tz));
    _returnLocal = s.returnAt == null
        ? defaults.returnLocal
        : _naive(ZonedTime.inZone(s.returnAt!, _tz));
  }

  static DateTime _naive(DateTime d) =>
      DateTime(d.year, d.month, d.day, d.hour, d.minute);

  DateTime _toUtc(DateTime local) => ZonedTime.toUtc(
    year: local.year,
    month: local.month,
    day: local.day,
    hour: local.hour,
    minute: local.minute,
    timezone: _tz,
  );

  RentalPeriodError? get _error => RentalPeriod.validatePeriod(
    pickupAt: _toUtc(_pickupLocal),
    returnAt: _toUtc(_returnLocal),
    now: _trip.now,
  );

  Future<void> _pickDate({required bool pickup}) async {
    final current = pickup ? _pickupLocal : _returnLocal;
    final localNow = ZonedTime.now(_tz, clock: _trip.now);
    final first = DateTime(localNow.year, localNow.month, localNow.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: current.isBefore(first) ? first : current,
      firstDate: first,
      lastDate: first.add(const Duration(days: 211)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      final updated = DateTime(
        picked.year,
        picked.month,
        picked.day,
        current.hour,
        current.minute,
      );
      if (pickup) {
        final length = _returnLocal.difference(_pickupLocal);
        _pickupLocal = updated;
        if (!_returnLocal.isAfter(_pickupLocal)) {
          _returnLocal = _pickupLocal.add(
            length.inHours >= 24 ? length : const Duration(days: 1),
          );
        }
      } else {
        _returnLocal = updated;
      }
    });
  }

  Future<void> _pickTime({required bool pickup}) async {
    final current = pickup ? _pickupLocal : _returnLocal;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current.hour, minute: current.minute),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (picked == null || !mounted) return;
    setState(() {
      final updated = DateTime(
        current.year,
        current.month,
        current.day,
        picked.hour,
        picked.minute,
      );
      if (pickup) {
        _pickupLocal = updated;
      } else {
        _returnLocal = updated;
      }
    });
  }

  void _apply() {
    if (_error != null) return;
    _trip.setDates(
      pickupAt: _toUtc(_pickupLocal),
      returnAt: _toUtc(_returnLocal),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = context.localeTag;
    final error = _error;
    final days = RentalPeriod(
      pickupAt: _toUtc(_pickupLocal),
      returnAt: _toUtc(_returnLocal),
    ).billableDays;
    final city = _trip.state.city;
    final zone = ZonedTime.zoneAbbreviation(_toUtc(_pickupLocal), _tz);
    Widget row(String label, DateTime local, {required bool pickup}) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: RoveSpacing.sm),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: RoveSelectField(
                key: Key('${pickup ? 'pickup' : 'return'}-date'),
                label: l10n.pickDate,
                value: DateFormat('EEE, d MMM y', locale).format(local),
                icon: Icons.calendar_today_outlined,
                onTap: () => _pickDate(pickup: pickup),
              ),
            ),
            const SizedBox(width: RoveSpacing.sm),
            Expanded(
              flex: 2,
              child: RoveSelectField(
                key: Key('${pickup ? 'pickup' : 'return'}-time'),
                label: l10n.pickTime,
                value: DateFormat('HH:mm', locale).format(local),
                icon: Icons.schedule_outlined,
                onTap: () => _pickTime(pickup: pickup),
              ),
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.datesTitle),
        leading: IconButton(
          tooltip: l10n.close,
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(RoveSpacing.md),
        children: [
          row(l10n.pickupLabel, _pickupLocal, pickup: true),
          const SizedBox(height: RoveSpacing.lg),
          row(l10n.returnLabel, _returnLocal, pickup: false),
          const SizedBox(height: RoveSpacing.lg),
          if (city != null) MutedText(l10n.datesTimezoneNote(city.name, zone)),
          const SizedBox(height: RoveSpacing.md),
          if (error != null)
            InlineNotice(
              key: const Key('dates-error'),
              message: l10n.periodError(error),
              tone: NoticeTone.danger,
            )
          else
            Text(
              l10n.daysCount(days),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: RoveColors.textSecondary),
            ),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        child: RoveButton(
          key: const Key('dates-apply'),
          label: l10n.datesApply,
          expand: true,
          onPressed: error == null ? _apply : null,
        ),
      ),
    );
  }
}
