import 'package:flutter/foundation.dart';

class AppUrls {
  static const host = kReleaseMode ? "api.toangtv.live" : "192.168.1.13:8080";
  static const socketUrl = "ws://$host";
  static const baseUrl = "http://$host/api";
  static const loginEndPoint = "$baseUrl/user/sign-in";
  static const registerEndPoint = "$baseUrl/user/sign-up";
  static const sendOTP = "$baseUrl/user/getOTP";
  static const sendForgotOTP = "$baseUrl/user/getForgotOTP";
  static const verifyOTP = "$baseUrl/user/verifyOTP";
  static const verifyForgotOTP = "$baseUrl/user/verifyForgotOTP";
  static const getMe = "$baseUrl/user/me";
  static const updateProfile = "$baseUrl/user/update-profile";
  static const changePassword = "$baseUrl/user/reset-password";
  static const resetPassword = "$baseUrl/user/change-password";

  static const getDoctors = "$baseUrl/user/doctorsInfo";

  static const getTopDoctors = "$baseUrl/user/getTopDoctors";
  static var getDoctorById =
      (String id) => "$baseUrl/user/doctor/$id/full-info";
  static const createAppointment = "$baseUrl/appointment";

  static var getMyAppointments =
      (String patientId) => "$baseUrl/appointment/patient/$patientId";

  static const createPayment = "$baseUrl/payment";

  static var getConversationsByUserId =
      (String userId) => "$baseUrl/conversation/$userId";
  static const uploadFileImage = "$baseUrl/conversation/image";
  static var getUpdateConversation = (String conversationId) =>
      "$baseUrl/conversation/update/$conversationId/update";
  static const createConversation = "$baseUrl/conversation";
  static const getNearestAppointment =
      "$baseUrl/appointment/appointment/nearest";
  static var getAppointmentDetails =
      (String id) => "$baseUrl/appointment/getAppointmentDetails/$id";

  static const addRatingReview = "$baseUrl/rating-review/";
  static var getRatingReviews = (String doctorId) => "$baseUrl/rating-review/doctor/$doctorId";
  static var getScheduleMedicines =
      (String patientId) => "$baseUrl/notification/user/$patientId";

  static var updateCompletedStatus =
      (String appointmentId) => "$baseUrl/appointment/$appointmentId/status";


  static var getAppointmentById =
      (String id) => "$baseUrl/appointment/$id";

}

//testerpayment@test.com
//Admin@123
