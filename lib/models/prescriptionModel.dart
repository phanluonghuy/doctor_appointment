class Prescription {
  final String id;
  final String medicalRecordId;
  final List<String> dosageDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

  Prescription({
    required this.id,
    required this.medicalRecordId,
    required this.dosageDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Prescription` object from JSON
  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['_id'] as String,
      medicalRecordId: json['medicalRecordId'] as String,
      dosageDetails: List<String>.from(json['dosageDetails']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Prescription` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicalRecordId': medicalRecordId,
      'dosageDetails': dosageDetails,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
