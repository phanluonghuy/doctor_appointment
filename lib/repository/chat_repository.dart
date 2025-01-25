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

  Future<ApiResponse> updateConversationById(String conversationId) async {
    try {
      final response =
      await _network.getGetApiResponse(AppUrls.getUpdateConversation(conversationId), false);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<ApiResponse> createConversation(dynamic data) async {
    try {
      final response =
      await _network.getPostApiResponse(AppUrls.createConversation, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}