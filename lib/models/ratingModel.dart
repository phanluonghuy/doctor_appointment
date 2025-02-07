import 'package:doctor_appointment/models/userModel.dart';

class Rating {
  final String id;
  final User patientId;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Rating({
    required this.id,
    required this.patientId,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Rating` object from JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['_id'] as String,
      patientId: User.fromJson(json['patientId']),
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Rating` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId.toJson(),
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
