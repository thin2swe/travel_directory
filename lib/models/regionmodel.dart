// region_model.dart
import 'dart:convert';

List<RegionDetail> RegionDetailFromJson(String str) => List<RegionDetail>.from(
    json.decode(str)["data"].map((x) => RegionDetail.fromJson(x)));

String RegionDetailToJson(List<RegionDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Popularity> PopularityPackageFromJson(String str) =>
    List<Popularity>.from(json.decode(str).map((x) => Popularity.fromJson(x)));

String PopularityToJson(List<Popularity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegionDetail {
  final String region;
  final String img;
  final String summary;
  final String origin;
  final String geography;
  final String interestingFacts;
  final List<Popularity> popularPlaces;
  final List<Popularity> festivals;

  RegionDetail({
    required this.region,
    required this.img,
    required this.summary,
    required this.origin,
    required this.geography,
    required this.interestingFacts,
    required this.popularPlaces,
    required this.festivals,
  });

  static RegionDetail empty = RegionDetail(
      region: "",
      img: "",
      summary: "",
      origin: "",
      geography: "",
      interestingFacts: "",
      popularPlaces: [],
      festivals: []);

  factory RegionDetail.fromJson(Map<String, dynamic> json) {
    return RegionDetail(
      region: json['region'],
      img: json['img'],
      summary: json['summary'],
      origin: json['origin'],
      geography: json['geography'],
      interestingFacts: json['interesting_facts'],
      popularPlaces: List<Popularity>.from(
          json['popular_places'].map((x) => Popularity.fromJson(x))),
      festivals: List<Popularity>.from(
          json['festivals'].map((x) => Popularity.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'img': img,
      'summary': summary,
      'origin': origin,
      'geography': geography,
      'interesting_facts': interestingFacts,
      'popularPlaces': PopularityToJson(popularPlaces),
      'festivals': PopularityToJson(festivals),
    };
  }

  // factory RegionDetail.fromJson(Map<String, dynamic> json) {
  //   var popularPlacesList = json['popular_places'] as List;
  //   List<Popularity> popularPlaces =
  //       popularPlacesList.map((place) => Popularity.fromJson(place)).toList();

  //   var festivalsList = json['festivals'] as List;
  //   List<Popularity> festivals =
  //       festivalsList.map((festival) => Popularity.fromJson(festival)).toList();

  //   return RegionDetail(
  //     region: json['region'],
  //     img: json['img'],
  //     summary: json['summary'],
  //     origin: json['origin'],
  //     geography: json['geography'],
  //     interestingFacts: json['interesting_facts'],
  //     popularPlaces: popularPlaces,
  //     festivals: festivals,
  //   );
  // }
}

class Popularity {
  final String img;
  final String name;
  final String description;

  Popularity({
    required this.img,
    required this.name,
    required this.description,
  });

  factory Popularity.fromJson(Map<String, dynamic> json) {
    return Popularity(
      img: json['img'] ?? '', // Handle null or empty values
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'lanamebel': name,
      'description': description,
    };
  }
}
