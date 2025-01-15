import 'package:doctor_appointment/models/doctorBookingModel.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import '../repository/doctor_repository.dart';

class DoctorBookingViewModel with ChangeNotifier {
  final DoctorRepository _doctorRepository = DoctorRepository();

  DoctorBooking? doctorBooking;
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getDoctorById(String id, BuildContext context) async {
    setLoading(true);
    _doctorRepository.getDoctorById(id).then((value) {
      setLoading(false);
      if (value.acknowledgement == true) {
        doctorBooking = DoctorBooking.fromJson(value.data);
        return;
      }
      Utils.flushBarErrorMessage("Error", context);
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
      setLoading(false);
    });
  }
}
