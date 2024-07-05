// region_model.dart

class Region {
  final String region;
  final String img;
  final String summary;
  final String origin;
  final String geography;
  final String interestingFacts;
  final List<PopularPlace> popularPlaces;
  final List<Festival> festivals;

  Region({
    required this.region,
    required this.img,
    required this.summary,
    required this.origin,
    required this.geography,
    required this.interestingFacts,
    required this.popularPlaces,
    required this.festivals,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    var popularPlacesList = json['popular_places'] as List;
    List<PopularPlace> popularPlaces =
        popularPlacesList.map((place) => PopularPlace.fromJson(place)).toList();

    var festivalsList = json['festivals'] as List;
    List<Festival> festivals =
        festivalsList.map((festival) => Festival.fromJson(festival)).toList();

    return Region(
      region: json['region'],
      img: json['img'],
      summary: json['summary'],
      origin: json['origin'],
      geography: json['geography'],
      interestingFacts: json['interesting_facts'],
      popularPlaces: popularPlaces,
      festivals: festivals,
    );
  }
}

class PopularPlace {
  final String img;
  final String name;
  final String description;

  PopularPlace({
    required this.img,
    required this.name,
    required this.description,
  });

  factory PopularPlace.fromJson(Map<String, dynamic> json) {
    return PopularPlace(
      img: json['img'] ?? '', // Handle null or empty values
      name: json['name'],
      description: json['description'],
    );
  }
}

class Festival {
  final String img;
  final String name;
  final String description;

  Festival({
    required this.img,
    required this.name,
    required this.description,
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      img: json['img'] ?? '', // Handle null or empty values
      name: json['name'],
      description: json['description'],
    );
  }
}
