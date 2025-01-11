class Examination {
  final String id; // ID of the examination document
  final String medicalRecordId;
  final String? notes; // Optional
  final List<String> observations;
  final DateTime createdAt;
  final DateTime updatedAt;

  Examination({
    required this.id,
    required this.medicalRecordId,
    this.notes,
    required this.observations,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create an `Examination` object from JSON
  factory Examination.fromJson(Map<String, dynamic> json) {
    return Examination(
      id: json['_id'] as String,
      medicalRecordId: json['medicalRecordId'] as String,
      notes: json['notes'] as String?,
      observations: List<String>.from(json['observations'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Examination` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicalRecordId': medicalRecordId,
      'notes': notes,
      'observations': observations,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
