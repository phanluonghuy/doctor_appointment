import 'dart:convert';

class Appointment {
  final String id; // ID of the appointment document
  final String patientId;
  final String doctorId;
  final DateTime appointmentDate;
  final String status; // "pending", "confirmed", "completed", "cancelled"
  final String symptoms;
  final String? notes; // Notes are optional
  final int queueNumber;
  final String priority; // "low", "medium", "high"
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
    required this.symptoms,
    this.notes,
    required this.queueNumber,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create an `Appointment` object from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      status: json['status'] as String,
      symptoms: json['symptoms'] as String,
      notes: json['notes'] as String?,
      queueNumber: json['queueNumber'] as int,
      priority: json['priority'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Appointment` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'status': status,
      'symptoms': symptoms,
      'notes': notes,
      'queueNumber': queueNumber,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert a list of appointments from JSON
  static List<Appointment> listFromJson(String source) {
    final List<dynamic> data = json.decode(source) as List<dynamic>;
    return data.map((json) => Appointment.fromJson(json as Map<String, dynamic>)).toList();
  }

  /// Convert a list of appointments to JSON
  static String listToJson(List<Appointment> appointments) {
    final List<Map<String, dynamic>> data =
    appointments.map((appointment) => appointment.toJson()).toList();
    return json.encode(data);
  }
}
