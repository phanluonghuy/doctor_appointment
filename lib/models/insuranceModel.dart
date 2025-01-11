class Insurance {
  final String id;
  final String patientId;
  final String insuranceProvider;
  final String insuranceCardNumber;
  final String benefitLevel;
  final String? livingAreaCode;
  final String initialHealthcareFacility;
  final String insuranceCardIssuingPlace;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Insurance({
    required this.id,
    required this.patientId,
    required this.insuranceProvider,
    required this.insuranceCardNumber,
    required this.benefitLevel,
    this.livingAreaCode,
    required this.initialHealthcareFacility,
    required this.insuranceCardIssuingPlace,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create an `Insurance` object from JSON
  factory Insurance.fromJson(Map<String, dynamic> json) {
    return Insurance(
      id: json['_id'] as String,
      patientId: json['patientId'] as String,
      insuranceProvider: json['insuranceProvider'] as String,
      insuranceCardNumber: json['insuranceCardNumber'] as String,
      benefitLevel: json['benefitLevel'] as String,
      livingAreaCode: json['livingAreaCode'] as String?,
      initialHealthcareFacility: json['initialHealthcareFacility'] as String,
      insuranceCardIssuingPlace: json['insuranceCardIssuingPlace'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Insurance` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'insuranceProvider': insuranceProvider,
      'insuranceCardNumber': insuranceCardNumber,
      'benefitLevel': benefitLevel,
      'livingAreaCode': livingAreaCode,
      'initialHealthcareFacility': initialHealthcareFacility,
      'insuranceCardIssuingPlace': insuranceCardIssuingPlace,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Get the description of the benefit level
  String getBenefitLevelDescription() {
    const descriptions = {
      "1": "100% chi phí KCB thuộc phạm vi BHYT",
      "2": "100% chi phí KCB có giới hạn tỷ lệ thanh toán một số thuốc, hóa chất, VTYT và DVKT",
      "3": "95% chi phí KCB, 100% tại tuyến xã",
      "4": "80% chi phí KCB, 100% tại tuyến xã",
      "5": "100% chi phí KCB ngoài phạm vi BHYT, chi phí vận chuyển",
    };
    return descriptions[benefitLevel] ?? "Unknown benefit level";
  }

  /// Get the description of the living area code
  String getLivingAreaCodeDescription() {
    const descriptions = {
      "K1": "Dân tộc thiểu số và hộ gia đình nghèo ở vùng khó khăn",
      "K2": "Dân tộc thiểu số và hộ gia đình nghèo ở vùng đặc biệt khó khăn",
      "K3": "Sinh sống tại xã đảo, huyện đảo",
    };
    return livingAreaCode != null ? (descriptions[livingAreaCode] ?? "Unknown area code") : "";
  }
}
