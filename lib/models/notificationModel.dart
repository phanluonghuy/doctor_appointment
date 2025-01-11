class Notification {
  final String id;
  final String userId;
  final String? prescriptionId;
  final String? paymentId;
  final String? appointmentId;
  final String notificationType; // "appointment", "payment", "reminder", or "system"
  final String message;
  final String status; // "unread" or "read"
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.id,
    required this.userId,
    this.prescriptionId,
    this.paymentId,
    this.appointmentId,
    required this.notificationType,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Notification` object from JSON
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      prescriptionId: json['prescriptionId'] as String?,
      paymentId: json['paymentId'] as String?,
      appointmentId: json['appointmentId'] as String?,
      notificationType: json['notificationType'] as String,
      message: json['message'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Notification` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'prescriptionId': prescriptionId,
      'paymentId': paymentId,
      'appointmentId': appointmentId,
      'notificationType': notificationType,
      'message': message,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
