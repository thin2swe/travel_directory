class Review {
  int? id;
  String name = "";
  String review = "";
  double rating = 0.0;

  Review({
    this.id,
    required this.name,
    required this.review,
    required this.rating,
  });

  Review.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.review = obj['review'];
    this.rating = obj['rating'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['review'] = review;
    map['rating'] = rating;
    return map;
  }

  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      name: map['name'],
      review: map['review'],
      rating: map['rating'],
    );
  }
}
