abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url,bool isTokenRequired);
  Future<dynamic> getPostApiResponse(String url, dynamic data);


}
