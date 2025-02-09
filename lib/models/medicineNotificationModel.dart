class MedicineNotification {
  String medicineId;
  String medicineName;
  List<String> times;
  int amountPerDose;
  int duration;
  String status;
  DateTime startDate;

  MedicineNotification({
    required this.medicineId,
    required this.medicineName,
    required this.times,
    required this.amountPerDose,
    required this.duration,
    required this.status,
    required this.startDate,
  });

  // Factory method to create an instance from JSON
  factory MedicineNotification.fromJson(Map<String, dynamic> json) {
    return MedicineNotification(
      medicineId: json['medicineId'],
      medicineName: json['medicineName'],
      times: List<String>.from(json['times']),
      amountPerDose: json['amountPerDose'],
      duration: json['duration'],
      status: json['status'],
      startDate: DateTime.parse(json['startDate']),
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'medicineName': medicineName,
      'times': times,
      'amountPerDose': amountPerDose,
      'duration': duration,
      'status': status,
      'startDate': startDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'MedicineNotification{medicineId: $medicineId, medicineName: $medicineName, times: $times, amountPerDose: $amountPerDose, duration: $duration, status: $status, startDate: $startDate}';
  }
}