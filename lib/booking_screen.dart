import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:travel_directory/controller/booking_controller.dart';
import 'package:travel_directory/home.dart';
import 'package:travel_directory/models/booking.dart';
import 'package:travel_directory/models/package.dart';

class TourBookingForm extends StatefulWidget {
  Package pack = Package.emptyPackge;

  TourBookingForm(_package, {super.key}) {
    pack = _package;
  }

  @override
  _TourBookingFormState createState() => _TourBookingFormState();
}

class _TourBookingFormState extends State<TourBookingForm> {
  final _formKey = GlobalKey<FormState>();
  String? _tourType;
  DateTime _expectedDate = DateTime.now();
  int _adults = 1;

  final BookingController ctrl = Get.put(BookingController());
  Booking booking = Booking.emptyBooking;
  int userId = 0;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    userId = await SessionManager().get("userId");
    print("userId =====================> $userId");
    ctrl.booking.value = Booking.mapWithPackage(widget.pack, userId);
  }

  double calculateTotalPrice() {
    return _adults * widget.pack.price;
  }

  String formatPrice(double price) {
    NumberFormat formatter = NumberFormat.currency(
      locale: 'en_US',
      //symbol: '\$',
      symbol: 'MMK ',
      decimalDigits: 2,
    );
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Booking'),
        backgroundColor: Color.fromARGB(255, 15, 180, 209),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pack.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Duration: ${widget.pack.duration}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Price: ${formatPrice(widget.pack.price)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: List.generate(
                      5,
                      (idx) => Icon(
                        Icons.star,
                        size: 20,
                        color: idx < widget.pack.rating
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildNumberField(
                          label: 'Number of Adults',
                          onChanged: (value) {
                            setState(() {
                              _adults = int.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the number of adults';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        _buildDateField(),
                        SizedBox(height: 20),
                        Text(
                          "Total Amount: ${formatPrice(calculateTotalPrice())}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              backgroundColor:
                                  Color.fromARGB(255, 15, 180, 209),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ctrl.book(_adults, _expectedDate);
                                Get.to(() => HomePage(1));
                              }
                            },
                            child: Text(
                              "BOOK NOW",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Expected Date of Arrival',
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                _expectedDate = pickedDate;
              });
            }
          },
        ),
      ),
      validator: (value) {
        if (_expectedDate == null) {
          return 'Please select a date';
        }
        return null;
      },
      readOnly: true,
      controller: TextEditingController(
        text: _expectedDate == null
            ? ''
            : '${_expectedDate.toLocal()}'.split(' ')[0],
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: "1",
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
