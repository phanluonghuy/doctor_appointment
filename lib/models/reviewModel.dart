class Review {
  final String id;
  final String doctorId;
  final double averageRating;
  final List<String> ratings;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.doctorId,
    required this.averageRating,
    required this.ratings,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Review` object from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] as String,
      doctorId: json['doctorId'] as String,
      averageRating: json['averageRating'] as double,
      ratings: List<String>.from(json['ratings'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Review` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'averageRating': averageRating,
      'ratings': ratings,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
