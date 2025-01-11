class Specialization {
  final String id;
  final String doctorId;
  final List<String> specializations;
  final List<Qualification> qualifications;
  final int experienceYears;
  final DateTime createdAt;
  final DateTime updatedAt;

  Specialization({
    required this.id,
    required this.doctorId,
    required this.specializations,
    required this.qualifications,
    required this.experienceYears,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Specialization` object from JSON
  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['_id'] as String,
      doctorId: json['doctorId'] as String,
      specializations: List<String>.from(json['specializations'] as List),
      qualifications: (json['qualifications'] as List)
          .map((qual) => Qualification.fromJson(qual as Map<String, dynamic>))
          .toList(),
      experienceYears: json['experienceYears'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Specialization` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'specializations': specializations,
      'qualifications': qualifications.map((qual) => qual.toJson()).toList(),
      'experienceYears': experienceYears,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Qualification {
  final String degree;
  final String institution;
  final int year;
  final String certificateNumber;

  Qualification({
    required this.degree,
    required this.institution,
    required this.year,
    required this.certificateNumber,
  });

  /// Factory constructor to create a `Qualification` object from JSON
  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      year: json['year'] as int,
      certificateNumber: json['certificateNumber'] as String,
    );
  }

  /// Converts the `Qualification` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'year': year,
      'certificateNumber': certificateNumber,
    };
  }
}
