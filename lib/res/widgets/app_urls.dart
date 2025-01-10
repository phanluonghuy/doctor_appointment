import 'dart:io' show Platform;

class AppUrls {
  static final baseUrl = "http://${Platform.isAndroid ? "10.0.2.2" : "localhost"}:8080/api";
  static final loginEndPoint = "$baseUrl/user/sign-in";
  static final registerEndPoint = "$baseUrl/user/sign-up";
  static final sendOTP = "$baseUrl/user/getOTP";
  static final verifyOTP = "$baseUrl/user/verifyOTP";

  static var moviesBaseUrl =
      'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';
  static var moviesListEndPoint = '${moviesBaseUrl}movies_list';
}
