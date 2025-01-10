import 'package:doctor_appointment/data/network/network_api_services.dart';
import 'package:doctor_appointment/res/widgets/app_urls.dart';

import '../data/response/api_response.dart';

class UserRepository {
  final NetworkApiServices _network = NetworkApiServices();
  Future<ApiResponse> getProfile() async {
    try {
      final response = await _network.getGetApiResponse(AppUrls.getMe, true);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}