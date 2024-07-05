import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_directory/database/database_helper.dart';

import 'controller/review_controller.dart';
import 'models/review.dart';

void main() {
  // Initialize the database factory for desktop
  if (isDesktop()) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(GetMaterialApp(home: ReviewPage()));
}

bool isDesktop() {
  return identical(0, 0.0);
}

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  double _rating = 0.0;

  final ReviewController controller = Get.put(ReviewController());
  //Review review = Review(name: '', review: '', rating: 0.0);

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Review mapToReview(
      TextEditingController name, TextEditingController review, double rating) {
    return Review(name: name.text, review: review.text, rating: rating);
  }

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    controller.getAllReviews();
  }

  void _submitReview() async {
    if (_formKey.currentState!.validate()) {
      controller
          .submit(mapToReview(_nameController, _reviewController, _rating));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Review submitted!')));
      _nameController.clear();
      _reviewController.clear();
      setState(() {
        _rating = 0.0;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: ' Name',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 25, 173, 199),
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 173, 199)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _reviewController,
                        decoration: InputDecoration(
                          labelText: ' Review',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 25, 173, 199)),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 173, 199)),
                          ),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your review';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        ' Rating',
                        style: TextStyle(
                            color: Color.fromARGB(255, 25, 173, 199),
                            fontSize: 16),
                      ),
                      Slider(
                        value: _rating,
                        onChanged: (newRating) {
                          setState(() {
                            _rating = newRating;
                          });
                        },
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: '$_rating',
                        activeColor: Color.fromARGB(255, 25, 173, 199),
                        inactiveColor: Colors.blue[100],
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitReview,
                          child: Text('Submit Review'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 25, 173, 199),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Divider(),
              Text(
                'Total Submitted Reviews :  ${controller.rewiews.length}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Expanded(
                child: controller.rewiews.value.length < 1
                    ? Center(
                        child: Text('No reviews submitted yet',
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 173, 199))))
                    : ListView.builder(
                        itemCount: controller.rewiews.length,
                        itemBuilder: (context, index) {
                          final review = controller.rewiews[index];
                          return Card(
                            child: ListTile(
                              title: Text(review.name,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 25, 173, 199))),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review.review,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 25, 173, 199))),
                                  Row(
                                    children: List.generate(
                                      review.rating.round(),
                                      (index) =>
                                          Icon(Icons.star, color: Colors.amber),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
