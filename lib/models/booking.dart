import 'package:travel_directory/models/package.dart';

class Booking {
  int id = 0;
  int userId = 0;
  int packageId = 0;
  double pirce = 0.0;
  int noOfPerson = 1;
  String bookingDate = DateTime.now().toIso8601String();

  static Booking emptyBooking = Booking(
      id: 0,
      userId: 0,
      packageId: 0,
      pirce: 0,
      noOfPerson: 1,
      bookingDate: DateTime.now().toIso8601String());

  Booking({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.pirce,
    required this.noOfPerson,
    required this.bookingDate,
  });

  Booking.mapWithPackage(Package obj, int userId) {
    if (obj != null) {
      this.id = 0;
      this.packageId = obj.id;
      this.userId = userId;
      this.pirce = obj.price;
      this.noOfPerson = 1;
      this.bookingDate = DateTime.now().toIso8601String();
    } else {
      Booking.emptyBooking;
    }
  }

  Booking.map(dynamic obj) {
    if (obj != null) {
      this.id = obj['id'];
      this.packageId = obj['package_id'];
      this.userId = obj['user_id'];
      this.pirce = obj['price'];
      this.noOfPerson = obj['no_of_person'];
      this.bookingDate = obj['booking_date'];
    } else {
      Booking.emptyBooking;
    }
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['package_id'] = packageId;
    map['user_id'] = userId;
    map['price'] = pirce;
    map['no_of_person'] = noOfPerson;
    map['booking_date'] = bookingDate;
    return map;
  }

  factory Booking.fromJson(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      packageId: map['package_id'],
      userId: map['user_id'],
      pirce: map['price'],
      noOfPerson: map['no_of_person'],
      bookingDate: map['booking_date'],
    );
  }
}
