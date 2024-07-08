import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_directory/models/booking.dart';
import 'package:travel_directory/models/package.dart';
import 'package:travel_directory/Navbar.dart';
import 'package:travel_directory/booking.dart';
import 'package:travel_directory/viewdetails.dart';

class TourPackagesByRegion extends StatelessWidget {
  List<Package> packages = [];

  TourPackagesByRegion(List<Package> pg) {
    packages = pg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Smile Tour'),
        backgroundColor: Color.fromARGB(255, 25, 173, 199),
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return TourPackageRegionCard(package: packages[index]);
        },
      ),
    );
  }
}

class TourPackageRegionCard extends StatelessWidget {
  final Package package;
  TourPackageRegionCard({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  package.imgPath,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Column(
              children: [SizedBox(width: 10)],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(package.duration),
                Text(
                  "\$" + package.price.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 20,
                      color:
                          index < package.rating ? Colors.yellow : Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => TourDetailsScreen(package));
                  },
                  child: Text(
                    "VIEW DETAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 40,
                  ),
                  alignment: Alignment.bottomLeft,
                  width: 100,
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 30,
                    onPressed: () => () {},
                    color: Color.fromARGB(255, 25, 173, 199),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "BOOK NOW",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [SizedBox(width: 10)],
            ),
          ],
        ),
      ),
    );
  }
}
