import 'package:equatable/equatable.dart';

import '../../core/time/zoned_time.dart';
import '../models/enums.dart';
import '../models/reference.dart';
import '../models/vehicle.dart';

/// Query for `GET /vehicles`. Availability filtering is done by the backend
/// when both dates are supplied.
class VehicleQuery extends Equatable {
  const VehicleQuery({
    required this.countryCode,
    this.cityId,
    this.pickupAt,
    this.returnAt,
    this.category,
    this.transmission,
    this.minSeats,
    this.maxDailyRateMinor,
    this.deliveryAvailable,
    this.fuelType,
    this.featured,
    this.sort = VehicleSort.relevance,
    this.page = 1,
    this.pageSize = 20,
  });

  final String countryCode;
  final String? cityId;
  final DateTime? pickupAt;
  final DateTime? returnAt;
  final VehicleCategory? category;
  final Transmission? transmission;
  final int? minSeats;
  final int? maxDailyRateMinor;
  final bool? deliveryAvailable;
  final FuelType? fuelType;
  final bool? featured;
  final VehicleSort sort;
  final int page;
  final int pageSize;

  bool get hasDates => pickupAt != null && returnAt != null;

  /// Number of filters set beyond location and dates.
  int get activeFilterCount => [
    category,
    transmission,
    minSeats,
    maxDailyRateMinor,
    deliveryAvailable == true ? true : null,
    fuelType,
  ].where((e) => e != null).length;

  Map<String, dynamic> toQueryParameters() => {
    'countryCode': countryCode,
    'cityId': cityId,
    if (hasDates) 'pickupAt': ZonedTime.toIso(pickupAt!),
    if (hasDates) 'returnAt': ZonedTime.toIso(returnAt!),
    'category': category?.wire,
    'transmission': transmission?.wire,
    'minSeats': minSeats,
    'maxDailyRateMinor': maxDailyRateMinor,
    if (deliveryAvailable == true) 'deliveryAvailable': true,
    'fuelType': fuelType?.wire,
    if (featured == true) 'featured': true,
    'sort': sort.wire,
    'page': page,
    'pageSize': pageSize,
  };

  VehicleQuery copyWith({
    String? countryCode,
    String? Function()? cityId,
    DateTime? Function()? pickupAt,
    DateTime? Function()? returnAt,
    VehicleCategory? Function()? category,
    Transmission? Function()? transmission,
    int? Function()? minSeats,
    int? Function()? maxDailyRateMinor,
    bool? Function()? deliveryAvailable,
    FuelType? Function()? fuelType,
    bool? Function()? featured,
    VehicleSort? sort,
    int? page,
    int? pageSize,
  }) => VehicleQuery(
    countryCode: countryCode ?? this.countryCode,
    cityId: cityId != null ? cityId() : this.cityId,
    pickupAt: pickupAt != null ? pickupAt() : this.pickupAt,
    returnAt: returnAt != null ? returnAt() : this.returnAt,
    category: category != null ? category() : this.category,
    transmission: transmission != null ? transmission() : this.transmission,
    minSeats: minSeats != null ? minSeats() : this.minSeats,
    maxDailyRateMinor: maxDailyRateMinor != null
        ? maxDailyRateMinor()
        : this.maxDailyRateMinor,
    deliveryAvailable: deliveryAvailable != null
        ? deliveryAvailable()
        : this.deliveryAvailable,
    fuelType: fuelType != null ? fuelType() : this.fuelType,
    featured: featured != null ? featured() : this.featured,
    sort: sort ?? this.sort,
    page: page ?? this.page,
    pageSize: pageSize ?? this.pageSize,
  );

  /// Same search with all optional filters removed.
  VehicleQuery clearFilters() => VehicleQuery(
    countryCode: countryCode,
    cityId: cityId,
    pickupAt: pickupAt,
    returnAt: returnAt,
    sort: sort,
    pageSize: pageSize,
  );

  @override
  List<Object?> get props => [
    countryCode,
    cityId,
    pickupAt,
    returnAt,
    category,
    transmission,
    minSeats,
    maxDailyRateMinor,
    deliveryAvailable,
    fuelType,
    featured,
    sort,
    page,
    pageSize,
  ];
}

abstract interface class VehicleRepository {
  Future<Paged<VehicleSummary>> search(VehicleQuery query);

  /// With dates, the response says whether the vehicle is available and
  /// carries an estimated total.
  Future<VehicleDetail> getVehicle(
    String vehicleId, {
    DateTime? pickupAt,
    DateTime? returnAt,
  });
}
