import 'package:doctor_appointment/data/network/network_api_services.dart';
import 'package:doctor_appointment/models/doctorModel.dart';

import '../data/response/api_response.dart';
import '../models/appointmentModel.dart';
import '../res/widgets/app_urls.dart';

class DoctorRepository {
  final NetworkApiServices _network = NetworkApiServices();
  Future<ApiResponse> getAllDoctors() async {
    try {
      final response =
          await _network.getGetApiResponse(AppUrls.getDoctors, false);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<ApiResponse> getDoctorById(String id) async {
    try {
      final response =
          await _network.getGetApiResponse(AppUrls.getDoctorById(id), false);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> createAppointment(dynamic data) async {
    try {
      final response = await _network.getPostApiResponse(
          AppUrls.createAppointment, data,
          isTokenRequired: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> getAppointmentById(String id) async {
    try {
      final response = await _network.getGetApiResponse(AppUrls.getAppointmentById(id), false);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> createPayment(dynamic data) async {
    try {
      final response = await _network.getPostApiResponse(
          AppUrls.createPayment, data,
          isTokenRequired: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Doctor>> getTopDoctor() async {
    try {
      final response =
          await _network.getGetApiResponse(AppUrls.getTopDoctors, false);
      if (response.acknowledgement == false) {
        return [];
      }
      final List<Doctor> doctors = [];
      response.data.forEach((element) {
        doctors.add(Doctor.fromJson(element));
      });
      return doctors;
    } catch (e) {
      rethrow;
    }
  }

  Future<Appointment> getNearestAppointment() async {
    try {
      final response = await _network.getGetApiResponse(
          AppUrls.getNearestAppointment, true);
      if (response.acknowledgement == false) {
        throw Exception(response.description);
      }
      return Appointment.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
