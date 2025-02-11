abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url,bool isTokenRequired);
  Future<dynamic> getPostApiResponse(String url, dynamic data,{bool isTokenRequired = false});
  Future<dynamic> getPostApiResponseWithFile(String url, dynamic data, dynamic imageFile,{bool isTokenRequired = false});
  Future<dynamic> getPatchApiResponse(String url, dynamic data,
      {bool isTokenRequired = false});
}
