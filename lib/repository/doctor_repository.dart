import 'package:doctor_appointment/data/network/network_api_services.dart';

import '../data/response/api_response.dart';
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
}
