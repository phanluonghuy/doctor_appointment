import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:doctor_appointment/data/app_exceptions.dart';
import 'package:doctor_appointment/data/network/base_api_services.dart';

import '../response/api_response.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responsejson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responsejson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data),
              headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 10));
      // print(jsonEncode(data));
      responsejson = responseJson(response);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // Building ApiResponse based on the parsed JSON
        if (jsonResponse['acknowledgement'] == true) {
          return ApiResponse.completed(
            acknowledgement: jsonResponse['acknowledgement'],
            message: jsonResponse['message'],
            description: jsonResponse['description'],
            data: jsonResponse['data'],
          );
        } else {
          return ApiResponse.error(
            message: jsonResponse['message'],
            description: jsonResponse['description'],
          );
        }
      } else {
        // Handling HTTP errors
        return ApiResponse.error(
          message: "HTTP Error: ${response.statusCode}",
          description: response.reasonPhrase,
        );
      }
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

  }

  dynamic responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("Bad request");
      default:
        throw InternetException("${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}
