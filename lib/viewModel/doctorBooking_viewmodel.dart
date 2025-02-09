import 'dart:convert';

import 'package:doctor_appointment/models/doctorBookingModel.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/appointmentModel.dart';
import '../repository/doctor_repository.dart';
import 'doctor_viewmodel.dart';

class DoctorBookingViewModel with ChangeNotifier {
  final DoctorRepository _doctorRepository = DoctorRepository();

  DoctorBooking? doctorBooking;
  bool _loading = false;
  bool _isQueue = false;
  DateTime selectedDate = DateTime.now();
  String symptoms = "";
  int _selectedTimeIndex = -1;
  String? selectedMethod;
  int? _bookingNumber;
  String? _bookingId;

  bool get loading => _loading;
  DateTime get getSelectedDate => selectedDate;
  String? get getSymptoms => symptoms;
  int get getSelectedTimeIndex => _selectedTimeIndex;
  String? get getSelectedMethod => selectedMethod;
  int? get getBookingNumber => _bookingNumber;
  bool get isQueue => _isQueue;
  String? get getBookingId => _bookingId;

  void setSelectedMethod(String? method) {
    selectedMethod = method;
    notifyListeners();
  }

  void setSelectedTimeIndex(int index) {
    _selectedTimeIndex = index;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setQueue(bool value) {
    _isQueue = value;
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

  Future<void> createAppointment(dynamic data, BuildContext context) async {
    setQueue(true);
    _doctorRepository.createAppointment(data).then((value) {
      setQueue(false);
      if (value.acknowledgement == true) {
        Appointment appointment = Appointment.fromJson(value.data);
        _bookingNumber = appointment.queueNumber;
        _bookingId = appointment.id;
        Utils.flushBarSuccessMessage(value.message ?? "", context);
        context.push('/paymentBooking');
        return;
      }

      Utils.flushBarErrorMessage(value.message ?? "", context);
      setQueue(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
      setQueue(false);
    });
  }

  Future<void> getPayLater(String id, BuildContext context) async {
    setQueue(true);
    _doctorRepository.getAppointmentById(id).then((value) {
      setQueue(false);
      if (value.acknowledgement == true) {
        Appointment appointment = Appointment.fromJson(value.data);
        _bookingNumber = appointment.queueNumber;
        _bookingId = appointment.id;
        context.push('/paymentBooking');
        return;
      }

      setQueue(false);
    }).onError((error, stackTrace) {
      print(error);
      setQueue(false);
    });
  }

  Future<void> createPayment(BuildContext context) async {
    setQueue(true);
    Map<String,dynamic> data = {
      "appointmentId": _bookingId,
      "amount": 10,
      "isInsuranceUsed": false,
      "paymentMethod": selectedMethod?.toLowerCase(),
      "advanceAmount": 1,
      "transactionId": Uuid().v4(),
    };
    _doctorRepository.createPayment(data).then((value) {
      setQueue(true);
      print(value);
      if (value.acknowledgement == true) {
        // Utils.flushBarSuccessMessage(value.description ?? "", context);
        context.read<DoctorViewModel>().getAllDoctors(context);
        Future.delayed(Duration(seconds: 2), () {
          context.push('/successBooking');
        });
        setQueue(false);
        return;
      }
      Utils.flushBarErrorMessage(value.message ?? "", context);
      setQueue(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
      setQueue(false);
    });
  }
}
