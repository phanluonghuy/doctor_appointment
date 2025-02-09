import 'package:doctor_appointment/models/appointmentModel.dart';
import 'package:doctor_appointment/repository/mybooking_repository.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class MyBookingViewModel with ChangeNotifier {
  final MyBookingRepository _myBookingRepository = MyBookingRepository();
  final List<Appointment> _appointments = [];
  bool _loading = false;
  Map<String, dynamic> _filters = {};

  bool get loading => _loading;
  List<Appointment> get appointments => _appointments;

  List<Appointment> get filteredAppointments {
    List<Appointment> filteredList = _appointments;

    if (_filters['sortOldest'] == true) {
      filteredList.sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));
    } else if (_filters['sortLatest'] == true) {
      filteredList.sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));
    }

    if (_filters['dateRange'] != null) {
      DateTimeRange dateRange = _filters['dateRange'];
      filteredList = filteredList.where((appointment) {
        return appointment.appointmentDate.isAfter(dateRange.start) &&
            appointment.appointmentDate.isBefore(dateRange.end);
      }).toList();
    }

    return filteredList;
  }

  List<Appointment> get confirmedAppointments =>
      filteredAppointments.where((element) => element.status == "confirmed").toList().reversed.toList();
  List<Appointment> get pendingAppointments =>
      filteredAppointments.where((element) => element.status == "pending").toList().reversed.toList();
  List<Appointment> get completedAppointments =>
      filteredAppointments.where((element) => element.status == "completed").toList().reversed.toList();
  List<Appointment> get cancelledAppointments =>
      filteredAppointments.where((element) => element.status == "cancelled").toList().reversed.toList();

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setFilters(Map<String, dynamic> filters) {
    _filters = filters;
    notifyListeners();
  }

  Future<void> getAllBooking(BuildContext context) async {
    setLoading(true);
    _myBookingRepository
        .getAllBookingByPatientId(context.read<UserViewModel>().user!.id)
        .then((value) {
      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(value.description ?? "", context);
        setLoading(false);
        return;
      }
      value.data.forEach((appointment) {
        _appointments.add(Appointment.fromJson(appointment));
      });
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context, isBottom: false);
      setLoading(false);
    });
  }
}

