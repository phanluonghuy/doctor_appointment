import 'package:doctor_appointment/models/doctorModel.dart';
import 'package:doctor_appointment/models/userModel.dart';
import 'package:doctor_appointment/repository/doctor_repository.dart';
import 'package:flutter/cupertino.dart';

import '../utils/List_Helper.dart';
import '../utils/utils.dart';

class DoctorViewModel extends ChangeNotifier {
  final DoctorRepository _doctorRepository = DoctorRepository();

  DoctorViewModel() {
    categories.insert(0, "All");
  }

  List<Doctor> doctors = [];

  List<String> categories = CategoryList.keys.toList();
  List<String> selectedCategories = ["All"];
  bool _loading = false;

  List<Doctor> get getDoctors => doctors;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }

    // Maintain rules for "All"
    if (selectedCategories.contains("All") && selectedCategories.length > 1) {
      selectedCategories.remove("All");
    } else if (selectedCategories.isEmpty) {
      selectedCategories.add("All");
    }

    if (category == "All") {
      selectedCategories.clear();
      selectedCategories.add("All");
    }

    notifyListeners();
  }

  Future<void> getAllDoctors(BuildContext context) async {
    setLoading(true);
    _doctorRepository.getAllDoctors().then((value) {
      setLoading(false);
      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(value.description ?? "", context);
        return;
      }
      value.data.forEach((doctor) {
        doctors.add(Doctor.fromJson(doctor));
      });
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context, isBottom: false);
      print(error);
      setLoading(false);
    });
  }
}
