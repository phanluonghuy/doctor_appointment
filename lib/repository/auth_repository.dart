import 'package:doctor_appointment/data/network/network_api_services.dart';
import 'package:doctor_appointment/res/widgets/app_urls.dart';

class AuthRepository {
  final NetworkApiServices _network = NetworkApiServices();
  Future<dynamic> apiLogin(dynamic data) async {
    try {
      final response = await _network.getPostApiResponse(AppUrls.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }


  Future<dynamic> signUp(dynamic data) async {
    try {
      final response =
          await _network.getPostApiResponse(AppUrls.registerEndPoint, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<dynamic> sendOTP(dynamic data) async {
    try {
      final response =
          await _network.getPostApiResponse(AppUrls.sendOTP, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }


  Future<dynamic> verifyOTP(dynamic data) async {
    try {
      final response =
      await _network.getPostApiResponse(AppUrls.verifyOTP, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

}



// ! Testing Purposes

// void main(List<String> args) async {
//   AuthRepository auth = AuthRepository();
//   final data = await auth.apiLogin(); 
//   print(data["data"][1]["year"]);
// }
