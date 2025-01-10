class HealthStatus {
  final String id; // ID of the health status document
  final String patient; // Patient ID
  final String? bloodPressure; // Optional
  final int? heartRate; // Optional
  final double? temperature; // Optional
  final double? weight; // Optional
  final String? notes; // Optional
  final DateTime createdAt;
  final DateTime updatedAt;

  HealthStatus({
    required this.id,
    required this.patient,
    this.bloodPressure,
    this.heartRate,
    this.temperature,
    this.weight,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `HealthStatus` object from JSON
  factory HealthStatus.fromJson(Map<String, dynamic> json) {
    return HealthStatus(
      id: json['_id'] as String,
      patient: json['patient'] as String,
      bloodPressure: json['bloodPressure'] as String?,
      heartRate: json['heartRate'] as int?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `HealthStatus` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient': patient,
      'bloodPressure': bloodPressure,
      'heartRate': heartRate,
      'temperature': temperature,
      'weight': weight,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
