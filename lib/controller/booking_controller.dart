import 'dart:ffi';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:travel_directory/database/database_helper.dart';
import 'package:travel_directory/models/booking.dart';

class BookingController extends GetxController {
  final booking = Booking.emptyBooking.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void book() async {
    await DatabaseHelper().insertBooking(booking.value);
  }
}
