class Qualification {
  final String id;
  final String degree;
  final String institution;
  final int year;
  final String certificateNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  Qualification({
    required this.id,
    required this.degree,
    required this.institution,
    required this.year,
    required this.certificateNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Qualification` object from JSON
  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      id: json['_id'] as String,
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      year: json['year'] as int,
      certificateNumber: json['certificateNumber'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Qualification` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'degree': degree,
      'institution': institution,
      'year': year,
      'certificateNumber': certificateNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
