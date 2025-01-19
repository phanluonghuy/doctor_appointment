import 'package:doctor_appointment/models/reviewModel.dart';
import 'package:doctor_appointment/models/specializationModel.dart';
import 'package:doctor_appointment/models/userModel.dart';
import 'package:doctor_appointment/models/workScheduleModel.dart';

class DoctorBooking {
  final User doctor;
  final Specialization specialization;
  final WorkSchedule workSchedule;
  final Review review;

  DoctorBooking({
    required this.doctor,
    required this.specialization,
    required this.workSchedule,
    required this.review,
  });

  factory DoctorBooking.fromJson(Map<String, dynamic> json) {
    return DoctorBooking(
      doctor: User.fromJson(json['doctor']),
      specialization: Specialization.fromJson(json['specializations']),
      workSchedule: WorkSchedule.fromJson(json['workSchedule']),
      review: Review.fromJson(json['review']),
    );
  }
}
