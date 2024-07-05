import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: ReviewPage()));
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

  // List to store submitted reviews
  List<Map<String, dynamic>> _reviews = [];

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _reviews.add({
          'name': _nameController.text,
          'review': _reviewController.text,
          'rating': _rating,
        });
      });

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
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // title: Text('Submit a Review'),
      //elevation: 0,
      // backgroundColor: Color.fromARGB(255, 25, 173, 199),
      //leading: IconButton(
      //onPressed: () {
      //Navigator.pop(context);
      // Get.to(HomePage());
      // },
      //icon: Icon(
      //Icons.arrow_back_ios,
      //size: 20,
      //color: Colors.black,
      // ),
      // ),
      // ),
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
                        labelText: 'Your Name',
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
                        labelText: 'Your Review',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 25, 173, 199)),
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
                      'Your Rating',
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
              'Total Submitted Reviews :  ${_reviews.length}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Expanded(
              child: _reviews.isEmpty
                  ? Center(
                      child: Text('No reviews submitted yet',
                          style: TextStyle(
                              color: Color.fromARGB(255, 25, 173, 199))))
                  : ListView.builder(
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        final review = _reviews[index];
                        return Card(
                          color: Colors.blue[50],
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Name:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 25, 173, 199)),
                                ),
                                Text(review['name']),
                                SizedBox(height: 8),
                                Text(
                                  'Your Review:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 25, 173, 199)),
                                ),
                                Text(review['review']),
                                SizedBox(height: 8),
                                Text(
                                  'Your Rating:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 25, 173, 199)),
                                ),
                                Row(
                                  children: List.generate(
                                    review['rating'].round(),
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
  }
}
