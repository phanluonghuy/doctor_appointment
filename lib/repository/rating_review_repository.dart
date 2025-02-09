import '../data/network/network_api_services.dart';
import '../data/response/api_response.dart';
import '../res/widgets/app_urls.dart';

class RatingReviewRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<ApiResponse> addRatingReview(dynamic data) async {
    try {
      final response =
      await _network.getPostApiResponse(AppUrls.addRatingReview, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<ApiResponse> getRatingReviews(String doctorId) async {
    try {
      final response =
      await _network.getGetApiResponse(AppUrls.getRatingReviews(doctorId), false);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}