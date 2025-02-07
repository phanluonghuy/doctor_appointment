import 'package:doctor_appointment/models/appointmentModel.dart';
import 'package:doctor_appointment/models/dosageModel.dart';
import 'package:doctor_appointment/models/medicalRecordModel.dart';
import 'package:doctor_appointment/models/prescriptionModel.dart';
import 'package:doctor_appointment/models/testResultModel.dart';
import 'package:doctor_appointment/repository/appointment_repository.dart';
import 'package:flutter/cupertino.dart';

import '../utils/utils.dart';

class BookingViewDetailsViewModel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  Appointment? _appointment;
  MedicalRecord? _medicalRecord;
  TestResult? _testResult;
  Prescription? _prescription;
  Dosage? _dosage;
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Appointment? get appointment => _appointment;

  set appointment(Appointment? value) {
    _appointment = value;
  }

  MedicalRecord? get medicalRecord => _medicalRecord;

  set medicalRecord(MedicalRecord? value) {
    _medicalRecord = value;
  }

  TestResult? get testResult => _testResult;

  set testResult(TestResult? value) {
    _testResult = value;
  }

  Dosage? get dosage => _dosage;

  set dosage(Dosage? value) {
    _dosage = value;
  }

  Prescription? get prescription => _prescription;

  set prescription(Prescription? value) {
    _prescription = value;
  }

  Future<void> getAppointmentDetails(BuildContext context) async {
    setLoading(true);
    _repository.getAppointmentDetails(_appointment?.id ?? "").then((value) {
      setLoading(false);
      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(value.description ?? "", context);
        return;
      }
      _medicalRecord = MedicalRecord.fromJson(value.data["medicalRecord"]);
      _testResult = TestResult.fromJson(value.data["testResult"]);
      _prescription = Prescription.fromJson(value.data["prescription"]);
      _dosage = Dosage.fromJson(value.data["dosage"]);
      // print(_dosage?.toJson());
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context, isBottom: false);
      print(error);
      setLoading(false);
    });
  }
}
