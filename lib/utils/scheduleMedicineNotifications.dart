import 'package:doctor_appointment/models/medicineNotificationModel.dart';
import 'package:timezone/timezone.dart' as tz;
import 'noti_service.dart';

void scheduleMedicineNotifications(List<MedicineNotification> data) async {
  final notificationService = NotificationService();

  // for (var medicine in data) {
  //   String medicineName = medicine["medicineName"];
  //   List<String> times = medicine["times"];
  //   int amountPerDose = medicine["amountPerDose"];
  //   int duration = medicine["duration"];
  //   DateTime startDate = DateTime.parse(medicine["startDate"]);
  //
  //   for (int day = 0; day < duration; day++) {
  //     DateTime doseDate = startDate.add(Duration(days: day));
  //
  //     for (String time in times) {
  //       DateTime notificationTime = getTimeForDose(doseDate, time);
  //       tz.TZDateTime scheduledTime =
  //           tz.TZDateTime.from(notificationTime, tz.local);
  //
  //       notificationService.scheduleNotification(
  //           id: medicineName.hashCode + notificationTime.hashCode,
  //           title: "Time to take your medicine",
  //           body: "Take $amountPerDose pills of $medicineName",
  //           scheduledTime: scheduledTime);
  //     }
  //   }
  // }
  data.forEach((e) {
    for (int day = 0; day < e.duration; day++) {
      DateTime doseDate = e.startDate.add(Duration(days: day));
      e.times.forEach((time) {
        DateTime notificationTime = getTimeForDose(doseDate, time);
        tz.TZDateTime scheduledTime =
            tz.TZDateTime.from(notificationTime, tz.local);

        notificationService.scheduleNotification(
            id: e.medicineName.hashCode + notificationTime.hashCode,
            title: "Time to take your medicine",
            body: "Take ${e.amountPerDose} pills of ${e.medicineName}",
            scheduledTime: scheduledTime);
      });
    }
  });
}

DateTime getTimeForDose(DateTime date, String time) {
  switch (time) {
    case "morning":
      return DateTime(date.year, date.month, date.day, 8, 0);
    case "afternoon":
      return DateTime(date.year, date.month, date.day, 13, 0);
    case "evening":
      return DateTime(date.year, date.month, date.day, 19, 0);
    default:
      return date;
  }
}
