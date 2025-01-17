import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:doctor_appointment/data/app_exceptions.dart';
import 'package:doctor_appointment/data/network/base_api_services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../response/api_response.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, bool isTokenRequired) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json', // Optional: Define content type
    };
    if (isTokenRequired) {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? token = sp.getString("token");
      if (token == "null" || token == "") {
        throw Exception("Token is not available");
      } else {
        headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Optional: Define content type
        };
      }
    }
    dynamic responsejson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
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

    return responsejson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data,
      {bool isTokenRequired = false}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json', // Optional: Define content type
    };
    if (isTokenRequired) {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? token = sp.getString("token");
      if (token == "null" || token == "") {
        throw Exception("Token is not available");
      } else {
        headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Optional: Define content type
        };
      }
    }
    dynamic responsejson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
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
        throw InternetException(
            "${response.statusCode} : ${response.reasonPhrase}");
    }
  }

  @override
  Future getPostApiResponseWithFile(String url, dynamic data, dynamic imageFile,
      {bool isTokenRequired = false}) async {
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);
    if (isTokenRequired) {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? token = sp.getString("token");
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
    }
    request.headers['Content-Type'] = 'multipart/form-data';

    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });
    if (imageFile != null) {
      // print(imageFile.path);
      final file = await http.MultipartFile.fromPath(
        'avatar', // Field name for the file
        imageFile.path,
        // filename: imageFile.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(file);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    dynamic responsejson;
    try {
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
}
