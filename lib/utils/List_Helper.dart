import 'package:intl/intl.dart';

Map<String, String> CategoryList = {
  "Dentist": "assets/categories/icons8-tooth.svg",
  "Cardiologist": "assets/categories/icons8-cardio.svg",
  "Orthopedic": "assets/categories/icons8-knee-joint.svg",
  "Neurologist": "assets/categories/icons8-brain.svg",
  "Urologist": "assets/categories/icons8-kidney.svg",
  "Pulmonologist": "assets/categories/icons8-lungs.svg",
  "Gynecologist": "assets/categories/icons8-gynecologist.svg",
  "General": "assets/categories/icons8-doctor.svg",
};

List<String> generateHourlyList(String start, String end) {
  final startHour = int.parse(start.split(":")[0]);
  final endHour = int.parse(end.split(":")[0]);

  return List.generate(
    endHour - startHour + 1,
        (index) => '${startHour + index}:00',
  );
}

Map<String, String> generateNextSevenDaysMap() {
  final Map<String, String> daysMap = {};
  final DateFormat dayFormatter = DateFormat('EEE'); // Day of the week
  final DateFormat dateFormatter = DateFormat('d MMM'); // Day and month

  for (int i = 0; i < 7; i++) {
    final date = DateTime.now().add(Duration(days: i));
    final dayOfWeek = dayFormatter.format(date); // e.g., "Wednesday"
    final dayAndMonth = dateFormatter.format(date); // e.g., "15 January"

    daysMap[dayOfWeek] = dayAndMonth;
  }

  return daysMap;
}
