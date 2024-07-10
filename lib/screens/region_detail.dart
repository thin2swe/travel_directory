import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_directory/controller/Navbar.dart';
import 'package:travel_directory/models/regionmodel.dart';

class RegionDetailScreen extends StatefulWidget {
  String region = "";
  List<RegionDetail> regions = [];
  RegionDetail displayRegion = RegionDetail.empty;

  RegionDetailScreen(this.region, this.regions, {super.key}) {
    for (var regionDetail in regions) {
      if (regionDetail.region == region) {
        displayRegion = regionDetail;
        break;
      }
    }
  }

  @override
  State<RegionDetailScreen> createState() => _RegionDetailScreen();
}

class _RegionDetailScreen extends State<RegionDetailScreen> {
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
                widget.displayRegion.region,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                widget.displayRegion.img, // Replace with your image path
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              ReadMoreText(widget.displayRegion.summary),
              SizedBox(height: 20),
              _buildSectionTitle('Origin'),
              ReadMoreText(widget.displayRegion.origin),
              SizedBox(height: 20),
              _buildSectionTitle('Geography'),
              ReadMoreText(widget.displayRegion.geography),
              SizedBox(height: 20),
              _buildSectionTitle('Interesting Facts'),
              ReadMoreText(widget.displayRegion.interestingFacts),
              SizedBox(height: 20),
              _buildSectionWithRichText(
                  'Popular Places', widget.displayRegion.popularPlaces),
              _buildSectionWithRichText(
                  'Festivals', widget.displayRegion.festivals),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 25, 173, 199), // Change this color as needed
      ),
    );
  }

  Widget _buildSectionWithRichText(String title, List<Popularity> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 25, 173, 199), // Subtitle color
                  ),
                ),
                ReadMoreText(item.description),
                SizedBox(height: 20),
              ],
            ),
          ),
      ],
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;
  const ReadMoreText(this.text, {Key? key}) : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textToShow = _isExpanded
        ? widget.text
        : widget.text.length > 100
            ? widget.text.substring(0, 100) + '...'
            : widget.text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(text: textToShow),
            if (!_isExpanded && widget.text.length > 100)
              TextSpan(
                text: ' See more',
                style: TextStyle(color: Colors.blue),
              ),
            if (_isExpanded)
              TextSpan(
                text: ' See less',
                style: TextStyle(color: Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
