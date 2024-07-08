import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_directory/controller/Navbar.dart';
import 'package:travel_directory/models/regionmodel.dart';

class RegionDetailScreen extends StatefulWidget {
  String region = "";
  List<RegionDetail> regions = [];
  RegionDetail displayRegion = RegionDetail.empty;

  RegionDetailScreen(_region, _regions, {super.key}) {
    region = _region;
    regions = _regions;
    for (var i = 0; i < regions.length; i++) {
      if (regions[i].region == region) {
        displayRegion = regions[i];
        print("displayRegion ==> " + displayRegion.toJson().toString());
        break;
      }
    }
  }

  @override
  State<RegionDetailScreen> createState() => _RegionDetailScreen();
}

class _RegionDetailScreen extends State<RegionDetailScreen> {
  @override
  void initState() {
    super.initState();
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
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30, top: 20),
                  child: Text(
                    widget.displayRegion.region,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Image.asset(
                  widget.displayRegion.img, // Replace with your image path
                  width: 400,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Text(
                  widget.displayRegion.summary,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Origin",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.displayRegion.origin,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Geography",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.displayRegion.geography,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Interesting Facts",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.displayRegion.origin,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "POPULAR PLACES",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    for (var popular in widget.displayRegion.popularPlaces) ...{
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: popular.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ': ${popular.description}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    }
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FESTIVALS",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    for (var festival in widget.displayRegion.festivals) ...{
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: festival.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ': ${festival.description}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayDetail extends StatelessWidget {
  final Popularity popularity;
  DisplayDetail({Key? key, required this.popularity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                popularity.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                popularity.description,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          Column(
            children: [SizedBox(width: 10)],
          ),
        ],
      ),
    );
  }
}
