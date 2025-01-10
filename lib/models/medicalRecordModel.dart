class MedicalRecord {
  final String id;
  final String appointmentId;
  final String diagnosis;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  MedicalRecord({
    required this.id,
    required this.appointmentId,
    required this.diagnosis,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `MedicalRecord` object from JSON
  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['_id'] as String,
      appointmentId: json['appointmentId'] as String,
      diagnosis: json['diagnosis'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `MedicalRecord` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'appointmentId': appointmentId,
      'diagnosis': diagnosis,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
