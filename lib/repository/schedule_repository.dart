import 'package:doctor_appointment/data/network/network_api_services.dart';

import '../res/widgets/app_urls.dart';

class ScheduleRepository {
  final NetworkApiServices _network = NetworkApiServices();
  Future<dynamic> getScheduleMedicines(String id) async {
    try {
      final response = await _network.getGetApiResponse(
          AppUrls.getScheduleMedicines(id), false);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}
