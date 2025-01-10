import 'dart:convert';

class DosageTime {
  final String time; // "morning", "afternoon", "evening", "night"

  DosageTime({required this.time});

  /// Factory constructor to create a `DosageTime` object from JSON
  factory DosageTime.fromJson(Map<String, dynamic> json) {
    return DosageTime(time: json['time'] as String);
  }

  /// Converts the `DosageTime` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'time': time,
    };
  }
}

class Dosage {
  final String id; // ID of the dosage document
  final String medicineId;
  final double amountPerDose;
  final int frequencyPerDay;
  final List<DosageTime> times; // List of DosageTime
  final String? description; // Optional
  final int duration; // Duration in days
  final String status; // "active", "completed", "expired"
  final DateTime createdAt;
  final DateTime updatedAt;

  Dosage({
    required this.id,
    required this.medicineId,
    required this.amountPerDose,
    required this.frequencyPerDay,
    required this.times,
    this.description,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Dosage` object from JSON
  factory Dosage.fromJson(Map<String, dynamic> json) {
    return Dosage(
      id: json['_id'] as String,
      medicineId: json['medicineId'] as String,
      amountPerDose: (json['amountPerDose'] as num).toDouble(),
      frequencyPerDay: json['frequencyPerDay'] as int,
      times: (json['times'] as List<dynamic>)
          .map((time) => DosageTime.fromJson(time as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      duration: json['duration'] as int,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Dosage` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicineId': medicineId,
      'amountPerDose': amountPerDose,
      'frequencyPerDay': frequencyPerDay,
      'times': times.map((time) => time.toJson()).toList(),
      'description': description,
      'duration': duration,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert a list of dosages from JSON
  static List<Dosage> listFromJson(String source) {
    final List<dynamic> data = json.decode(source) as List<dynamic>;
    return data.map((json) => Dosage.fromJson(json as Map<String, dynamic>)).toList();
  }

  /// Convert a list of dosages to JSON
  static String listToJson(List<Dosage> dosages) {
    final List<Map<String, dynamic>> data =
    dosages.map((dosage) => dosage.toJson()).toList();
    return json.encode(data);
  }
}
