class Payment {
  final String id;
  final String patientId;
  final String appointmentId;
  final double amount;
  final double advanceAmount;
  final double finalAmount;
  final bool isInsuranceUsed;
  final double? insuranceCoverage;
  final double? refundAmount;
  final String paymentMethod; // "credit_card", "paypal", "bank_transfer", or "cash"
  final String paymentStatus; // "pending", "completed", or "failed"
  final String refundStatus; // "none", "pending", "completed", or "failed"
  final String transactionId;
  final DateTime? paymentDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.patientId,
    required this.appointmentId,
    required this.amount,
    required this.advanceAmount,
    required this.finalAmount,
    required this.isInsuranceUsed,
    this.insuranceCoverage,
    this.refundAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.refundStatus,
    required this.transactionId,
    this.paymentDate,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Payment` object from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'] as String,
      patientId: json['patientId'] as String,
      appointmentId: json['appointmentId'] as String,
      amount: json['amount'] as double,
      advanceAmount: json['advanceAmount'] as double,
      finalAmount: json['finalAmount'] as double,
      isInsuranceUsed: json['isInsuranceUsed'] as bool,
      insuranceCoverage: json['insuranceCoverage'] != null
          ? json['insuranceCoverage'] as double
          : null,
      refundAmount: json['refundAmount'] != null
          ? json['refundAmount'] as double
          : null,
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      refundStatus: json['refundStatus'] as String,
      transactionId: json['transactionId'] as String,
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Payment` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'appointmentId': appointmentId,
      'amount': amount,
      'advanceAmount': advanceAmount,
      'finalAmount': finalAmount,
      'isInsuranceUsed': isInsuranceUsed,
      'insuranceCoverage': insuranceCoverage,
      'refundAmount': refundAmount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'refundStatus': refundStatus,
      'transactionId': transactionId,
      'paymentDate': paymentDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
