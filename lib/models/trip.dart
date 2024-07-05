class Trip {
  int? _tripId;
  int? _rating;
  String? _title;
  String? _trip_plan;
  int? _price;
  DateTime? _start_date;
  DateTime? _return_date;
  int? _total_available;
  int? _no_of_available;
  String? _departure;
  String? _arrival;
  double? _discount;

  Trip(
    this._tripId,
    this._rating,
    this._title,
    this._trip_plan,
    this._price,
    this._start_date,
    this._return_date,
    this._total_available,
    this._no_of_available,
    this._departure,
    this._arrival,
    this._discount,
  );
}
