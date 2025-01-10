import 'dart:convert';

class WorkSchedule {
  final String id;
  final String doctorId;
  final List<AvailableTime> availableTimes;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkSchedule({
    required this.id,
    required this.doctorId,
    required this.availableTimes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a `WorkSchedule` object from JSON
  factory WorkSchedule.fromJson(Map<String, dynamic> json) {
    var availableTimesFromJson = (json['availableTimes'] as List)
        .map((item) => AvailableTime.fromJson(item))
        .toList();

    return WorkSchedule(
      id: json['_id'] as String,
      doctorId: json['doctorId'] as String,
      availableTimes: availableTimesFromJson,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Converts the `WorkSchedule` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'availableTimes': availableTimes.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class AvailableTime {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  AvailableTime({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  // Factory constructor to create an `AvailableTime` object from JSON
  factory AvailableTime.fromJson(Map<String, dynamic> json) {
    return AvailableTime(
      dayOfWeek: json['dayOfWeek'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }

  // Converts the `AvailableTime` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  // Validates the time format to ensure it's in HH:mm format
  bool validateTime(String time) {
    final regex = RegExp(r'^([01]?\d|2[0-3]):[0-5]\d$');
    return regex.hasMatch(time);
  }
}
