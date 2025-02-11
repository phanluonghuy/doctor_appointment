import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  bool get initialized => _initialized;

  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

    // final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    // tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(currentTimeZone));

    final androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final iosSettings = DarwinInitializationSettings();

    final settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await notificationPlugin.initialize(settings);

    _initialized = true;
  }

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      final androidImplementation =
      notificationPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        await androidImplementation.requestExactAlarmsPermission();
      }
    }

    if (Platform.isIOS) {
      final iosImplementation =
      notificationPlugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      if (iosImplementation != null) {
        await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: true,
          provisional: true
        );
      }
    }
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_notification',
        'Daily Notification',
        channelDescription: 'Daily Reminder',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification(
      {int id = 0, required String title, required String body}) async {
    await notificationPlugin.show(id, title, body, notificationDetails());
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
  }) async {
    if (!_initialized) {
      await init(); // Ensure notifications are initialized
    }

    try {
      await notificationPlugin.zonedSchedule(
          id, title, body, scheduledTime, notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

      print('Notification scheduled successfully');
      print(scheduledTime.toIso8601String());
    } catch (e) {
      print('Error scheduling notification: $e');
    }
    // await notificationPlugin.zonedSchedule(
    //   id,
    //   title,
    //   body,
    //   scheduledDate,
    //   notificationDetails(),
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //   uiLocalNotificationDateInterpretation:
    //   UILocalNotificationDateInterpretation.wallClockTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    // );
  }

  Future<void> cancelAllNotification() async {
    await notificationPlugin.cancelAll();
  }

  Future<void> logAllScheduledNotifications() async {
    final List<PendingNotificationRequest> pendingNotifications =
        await notificationPlugin.pendingNotificationRequests();

    if (pendingNotifications.isEmpty) {
      print("🔴 No scheduled notifications.");
    } else {
      for (var notification in pendingNotifications) {
        print("✅ Scheduled Notification:");
        print("   ID: ${notification.id}");
        print("   Title: ${notification.title}");
        print("   Body: ${notification.body}");
        print("   Payload: ${notification.payload}");
      }
    }
  }
}
