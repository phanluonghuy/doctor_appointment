import 'package:doctor_appointment/models/userModel.dart';

class Conversation {
  String? id;
  List<User>? participants;
  String? lastMessageContent;
  Map<String, int>? unreadCount;
  DateTime? lastMessageTimestamp;
  DateTime? createdAt;
  DateTime? updatedAt;

  Conversation({
    this.id,
    this.participants,
    this.lastMessageContent,
    this.unreadCount,
    this.lastMessageTimestamp,
    this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      participants: (json['participants'] as List<dynamic>?)
          ?.map((item) => User.fromJson(item))
          .toList(),
      lastMessageContent: json['lastMessageContent'],
      unreadCount: (json['unreadCount'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value as int),
      ),
      lastMessageTimestamp: DateTime.parse(json['lastMessageTimestamp']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'participants': participants?.map((p) => p.toJson()).toList(),
      'lastMessageContent': lastMessageContent,
      'unreadCount': unreadCount,
      'lastMessageTimestamp': lastMessageTimestamp?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
