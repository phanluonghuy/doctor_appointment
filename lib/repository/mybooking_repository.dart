import '../data/network/network_api_services.dart';
import '../data/response/api_response.dart';
import '../res/widgets/app_urls.dart';

class MyBookingRepository {
   final NetworkApiServices _network = NetworkApiServices();
   Future<ApiResponse> getAllBookingByPatientId(String patientId) async {
     try {
       final response =
       await _network.getGetApiResponse(AppUrls.getMyAppointments(patientId), false);
       return response;
     } catch (e) {
       rethrow; //Big Brain
     }
   }
}