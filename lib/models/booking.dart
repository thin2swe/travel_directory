class Booking {
  int id = 0;
  int userId = 0;
  int packageId = 0;
  double pirce = 0.0;
  int noOfPerson = 1;
  DateTime bookingDate = DateTime.now();

  static Booking emptyBooking = Booking(
      id: 0,
      userId: 0,
      packageId: 0,
      pirce: 0,
      noOfPerson: 1,
      bookingDate: DateTime.now());

  Booking({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.pirce,
    required this.noOfPerson,
    required this.bookingDate,
  });

  Booking.mapWithPackage(dynamic obj, userId) {
    if (obj != null) {
      this.id = 0;
      this.userId = userId;
      this.packageId = obj['id'];
      this.pirce = obj['price'];
      this.noOfPerson = 1;
      this.bookingDate = DateTime.now();
    }
  }
}
