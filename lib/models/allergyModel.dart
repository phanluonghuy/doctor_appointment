import 'dart:convert';

class Allergy {
  final String id; // ID of the allergy document
  final String patientId;
  final String allergen;
  final String reaction;
  final String severity;
  final String? notes; // Notes are optional
  final DateTime createdAt;
  final DateTime updatedAt;

  Allergy({
    required this.id,
    required this.patientId,
    required this.allergen,
    required this.reaction,
    required this.severity,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create an `Allergy` object from JSON
  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      id: json['_id'] as String,
      patientId: json['patientId'] as String,
      allergen: json['allergen'] as String,
      reaction: json['reaction'] as String,
      severity: json['severity'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Allergy` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'allergen': allergen,
      'reaction': reaction,
      'severity': severity,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert a list of allergies from JSON
  static List<Allergy> listFromJson(String source) {
    final List<dynamic> data = json.decode(source) as List<dynamic>;
    return data.map((json) => Allergy.fromJson(json as Map<String, dynamic>)).toList();
  }

  /// Convert a list of allergies to JSON
  static String listToJson(List<Allergy> allergies) {
    final List<Map<String, dynamic>> data =
    allergies.map((allergy) => allergy.toJson()).toList();
    return json.encode(data);
  }
}
