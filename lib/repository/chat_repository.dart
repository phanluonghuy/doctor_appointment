import '../data/network/network_api_services.dart';
import '../data/response/api_response.dart';
import '../res/widgets/app_urls.dart';

class ChatRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<ApiResponse> getConversationsByUserId(String userId) async {
    try {
      final response =
      await _network.getGetApiResponse(AppUrls.getConversationsByUserId(userId), false);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}