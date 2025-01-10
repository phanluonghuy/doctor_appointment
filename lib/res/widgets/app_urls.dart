class AppUrls {
  static const baseUrl = "http://192.168.10.254:8080/api";
  static const loginEndPoint = "$baseUrl/user/sign-in";
  static const registerEndPoint = "$baseUrl/user/sign-up";
  static const sendOTP = "$baseUrl/user/getOTP";
  static const verifyOTP = "$baseUrl/user/verifyOTP";

  static var moviesBaseUrl =
      'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';
  static var moviesListEndPoint = '${moviesBaseUrl}movies_list';
}
