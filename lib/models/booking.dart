class Booking {
  int? _bookingId;
  int? _userId;
  int? _tripId;
  DateTime? _bookingDate;
  int? _no_of_person;
  double? _total_payment;
  String? _status;

  Booking(this._bookingId, this._userId, this._tripId, this._bookingDate,
      this._no_of_person, this._total_payment, this._status);
}
