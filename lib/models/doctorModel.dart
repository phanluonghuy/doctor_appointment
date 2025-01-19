import 'package:doctor_appointment/models/specializationModel.dart';
import 'package:doctor_appointment/models/userModel.dart';

class Doctor {
  String id;
  String email;
  String name;
  String phone;
  Avatar avatar;
  int totalReviews;
  double averageRating;
  List<Specialization> specializations = [];

  Doctor({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.totalReviews,
    required this.averageRating,
    required this.specializations,
  });
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      avatar: Avatar.fromJson(json['avatar']),
      totalReviews: json['totalReviews'],
      averageRating: json['averageRating']?.toDouble() ?? 0.0,
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => Specialization.fromJson(e))
          .toList() ??
          [], // Assign an empty list if null
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'totalReviews': totalReviews,
      'averageRating': averageRating,
      'specializations': specializations.map((e) => e.toJson()).toList(),
    };
  }
}