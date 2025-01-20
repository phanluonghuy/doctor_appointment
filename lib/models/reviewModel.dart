class Review {
  final String id;
  final String doctorId;
  final double averageRating;
  final List<Rating> ratings;
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

  // Factory method to parse JSON into Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      doctorId: json['doctorId'],
      averageRating: json['averageRating'].toDouble(),
      ratings: (json['ratings'] as List)
          .map((ratingJson) => Rating.fromJson(ratingJson))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert Review to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'averageRating': averageRating,
      'ratings': ratings.map((rating) => rating.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Rating {
  final String id;
  final String patientId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Rating({
    required this.id,
    required this.patientId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to parse JSON into Rating
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['_id'],
      patientId: json['patientId'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert Rating to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
