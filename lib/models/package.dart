import 'dart:convert';

List<Package> PackageFromJson(String str) =>
    List<Package>.from(json.decode(str).map((x) => Package.fromJson(x)));

String PackageToJson(List<Package> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Region> RegionFromJson(String str) =>
    List<Region>.from(json.decode(str)["data"].map((x) => Region.fromJson(x)));

String RegionToJson(List<Region> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Package> allPackages(String str) {
  // param is full json
  List<Region> regions = List<Region>.from(
      json.decode(str)["data"].map((x) => Region.fromJson(x)));
  List<Package> packList = [];
  regions.forEach((element) {
    element.regionPackages.forEach((ele) {
      packList.add(ele);
    });
  });
  print("Length: ${packList.length}");
  return packList;
}

List<String> getRegions(String str) {
  // param is full json
  List<Region> regions = List<Region>.from(
      json.decode(str)["data"].map((x) => Region.fromJson(x)));
  List<String> regionsList = [];
  regions.forEach((element) {
    regionsList.add(element.region);
  });
  print(regionsList.toString());
  return regionsList;
}

class Region {
  final String region;
  final String img;
  final String label;
  final String description;
  final List<Package> regionPackages;

  Region({
    required this.region,
    required this.img,
    required this.label,
    required this.description,
    required this.regionPackages,
  });

  factory Region.fromJson(Map<String, dynamic> map) {
    return Region(
      region: map['region'],
      img: map['img'],
      label: map['label'],
      description: map['description'],
      //regionPackages: PackageFromJson(map['regionPackages']),
      regionPackages: List<Package>.from(
          map['regionPackages'].map((x) => Package.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'img': img,
      'label': label,
      'description': description,
      'regionPackages': PackageToJson(regionPackages),
    };
  }
}

class Package {
  int id = 0;
  String title = "";
  String destination = "";
  String duration = "";
  double price = 0;
  int rating = 0;
  String imgPath = "";
  String description = "";
  List<String>? images = [];
  List<String>? inclusions = [];
  List<String>? exclusions = [];

  static Package emptyPackge = Package(
      id: 0,
      title: "",
      destination: "",
      duration: "",
      price: 0,
      rating: 0,
      imgPath: "",
      description: "",
      images: [],
      inclusions: [],
      exclusions: []);

  Package(
      {required this.id,
      required this.title,
      required this.destination,
      required this.duration,
      required this.price,
      required this.rating,
      required this.imgPath,
      required this.description,
      this.images,
      this.inclusions,
      this.exclusions});

  factory Package.fromJson(Map<String, dynamic> map) {
    return Package(
      id: map['id'],
      title: map['title'],
      destination: map['destination'],
      duration: map['duration'],
      price: map['price'],
      rating: map['rating'],
      imgPath: map['imgPath'],
      description: map['description'],
      images: List<String>.from(map['images']),
      inclusions: List<String>.from(map['inclusions']),
      exclusions: List<String>.from(map['exclusions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'destination': destination,
      'duration': duration,
      'price': price,
      'rating': rating,
      'imgPath': imgPath,
      'description': description,
      'images': images,
      'inclusions': inclusions,
      'exclusions': exclusions,
    };
  }
}
