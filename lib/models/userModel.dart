import 'package:crypto/crypto.dart';
import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String role;
  final String name;
  final bool gender;
  final DateTime dateOfBirth;
  final String status;
  final String phone;
  final String? address;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.status,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a `User` object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      name: json['name'] as String,
      gender: json['gender'] as bool,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      status: json['status'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      avatar: json['avatar'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Converts the `User` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'role': role,
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'status': status,
      'phone': phone,
      'address': address,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Method to compare password (this is a simple comparison, in a real app, use hash comparison)
  bool comparePassword(String candidatePassword) {
    return candidatePassword == password;
  }

  // Method to hash the password (mimicking bcrypt's functionality)
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // Data to be hashed
    var digest = sha256.convert(bytes); // Creates SHA256 hash
    return digest.toString(); // Returns hashed password as a string
  }
}
