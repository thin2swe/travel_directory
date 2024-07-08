import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_directory/models/package.dart';
import 'package:travel_directory/home.dart';
import 'package:travel_directory/models/user.dart';
import 'package:travel_directory/viewdetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TourPackages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TourPackages(),
    );
  }
}

class TourPackages extends StatefulWidget {
  const TourPackages({Key? key}) : super(key: key);

  @override
  State<TourPackages> createState() => _TourPackages();
}

class _TourPackages extends State<TourPackages> {
  List<Package> packages = [];
  List<Region> regions = [];
  List<Package> displayedItems = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/packages.json');
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          packages = allPackages(response);
          regions.add(Region(
              region: "All",
              regionPackages: List.from(packages),
              img: '',
              label: '',
              description: ''));
          regions.addAll(RegionFromJson(response));

          displayedItems = List.from(packages);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            children: List.generate(
                regions.length,
                (idx) =>
                    CategoryButton(regions[idx].region, filterItemsByCategory)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedItems.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return TourPackageCard(package: displayedItems[index]);
              },
            ),
          ),
        ],
      ),

      /*Wrap(
      spacing: 8.0, // Adjust the spacing between buttons
      children: List.generate(
        regions.length, // Replace 'yourList' with your actual list
        (index) {
          return ElevatedButton(
            onPressed: () {
              _showItems(context, regions[index].regionPackages);
            },
            child: Text(regions[index].region), // Replace with your button text
          );
        },
      ),
    ) */
    );
  }

  void _showItems(BuildContext context, List<Package> items) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ItemListScreen(items: items),
    ));
  }

  void filterItemsByCategory(String category) {
    setState(() {
      if (category == 'All') {
        displayedItems = List.from(packages);
      } else {
        displayedItems =
            regions.where((rgn) => rgn.region == category).first.regionPackages;
      }
    });
  }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final Function(String) onTap;

  CategoryButton(this.category, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(category),
      child: Text(category),
    );
  }
}

class ItemListScreen extends StatelessWidget {
  final List<Package> items;
  ItemListScreen({required this.items});
  User user = User(userName: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package List'),
        backgroundColor: Color.fromARGB(255, 25, 173, 199),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.of(context).pop();
            Get.to(HomePage());
          },
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return TourPackageCard(package: items[index]);
        },
      ),
    );
  }
}

class TourPackageCard extends StatelessWidget {
  final Package package;
  TourPackageCard({Key? key, required this.package}) : super(key: key);

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.title,
                    softWrap: true,
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
                      (idx) => Icon(
                        Icons.star,
                        size: 20,
                        color:
                            idx < package.rating ? Colors.yellow : Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(TourDetailsScreen(package));
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
                      onPressed: () => {},
                      color: Color.fromARGB(255, 15, 180, 209),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "BOOK NOW",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
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
