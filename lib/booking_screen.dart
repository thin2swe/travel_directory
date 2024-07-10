import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
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
  int _children = 0;
  String _specialRequest = '';
  String _name = '';
  String _email = '';
  String _phone = '';

  final BookingController ctrl = Get.put(BookingController());
  Booking booking = Booking.emptyBooking;
  int userId = 0;
  @override
  void initState() {
    super.initState();
  }

  _TourBookingFormState() {
    loadUser();
  }

  void loadUser() async {
    userId = await SessionManager().get("userId");
    print("userId =====================> ${userId}");
    ctrl.booking.value = Booking.mapWithPackage(widget.pack, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smile Tour'),
        backgroundColor: Color.fromARGB(255, 25, 173, 199),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
              SizedBox(height: 20),
              Text(
                "Duration : ${widget.pack.duration}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Price : ${widget.pack.price}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: List.generate(
                  5,
                  (idx) => Icon(
                    Icons.star,
                    size: 20,
                    color:
                        idx < widget.pack.rating ? Colors.yellow : Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildNumberField(
                label: 'Number of Adults ',
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
              Container(
                constraints: BoxConstraints(
                  minHeight: 40,
                ),
                alignment: Alignment.bottomLeft,
                width: 100,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 30,
                  onPressed: () {
                    ctrl.book(_adults, _expectedDate);
                    Get.to(() => HomePage(1));
                  },
                  color: Color.fromARGB(255, 15, 180, 209),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "BOOK NOW",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Smile Tour'),
        backgroundColor: Color.fromARGB(255, 25, 173, 199),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Tour Booking Form"),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(widget.pack.title),
                  SizedBox(height: 12),
                  Text("Duration: ${widget.pack.duration} days"),
                  SizedBox(height: 12),
                  Text("Price: ${widget.pack.price} days"),
                  SizedBox(height: 12),
                  _buildDateField(),
                  SizedBox(height: 16),
                  
                  SizedBox(height: 16),
                  _buildNumberField(
                    label: 'Number of Children (Age below 12)',
                    onChanged: (value) {
                      setState(() {
                        _children = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  _buildDropdownField(
                    label: 'Tour Type ',
                    items: ['Taunggyi', 'Inlay', 'Kalaw'],
                    onChanged: (value) {
                      setState(() {
                        _tourType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a tour type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Special Request (maximum 200 characters)',
                    maxLines: 3,
                    maxLength: 200,
                    onChanged: (value) {
                      setState(() {
                        _specialRequest = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Name ',
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'E-Mail ',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Phone Number ',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        _phone = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Booking Confirmation'),
                            content: Text('Your trip has been booked!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
    */
  }

  Widget _buildDateField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Expected Date of Arrival ',
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
            : '${_expectedDate!.toLocal()}'.split(' ')[0],
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
      ),
      keyboardType: TextInputType.number,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
      ),
      items: items
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    int maxLength = 100,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
