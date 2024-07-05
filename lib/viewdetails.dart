import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_directory/DATA/package.dart';
import 'package:travel_directory/Navbar.dart';

class TourDetailsScreen extends StatelessWidget {
  List<Package> regionPackages = [];
  Package pack = Package.emptyPackge;

  TourDetailsScreen(package, {super.key}) {
    pack = package;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
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
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(pack.imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      //color: Color.fromARGB(137, 43, 38, 38),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pack.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pack.duration,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      pack.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    CarouselSlider.builder(
                      itemCount: pack.images!.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return Image.asset(
                          pack.images![itemIndex],
                          height: 110,
                          width: 200,
                          fit: BoxFit.cover,
                        );
                      },
                      options: CarouselOptions(
                        height: 110,
                        autoPlay: true,
                        viewportFraction: 0.5,
                        enlargeCenterPage: true,
                        // Other options you might need
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Inclusions:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    for (var item in pack.inclusions!) ...{
                      ListTile(
                        leading:
                            Icon(Icons.check_circle, color: Colors.teal[700]),
                        title: Text(item,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87)),
                      ),
                    },
                    SizedBox(height: 20),
                    Text(
                      'Exclusions:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 16),
                    for (var item in pack.exclusions!) ...{
                      ListTile(
                        leading: Icon(Icons.remove_circle,
                            color: Color.fromARGB(255, 189, 11, 11)),
                        title: Text(item,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87)),
                      ),
                    },
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 25, 173, 199),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
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
                },
                child: Text(
                  'Book This Trip',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
