class AppUrls {
  static const baseUrl = "http://10.0.2.2:8080/api";
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
  static const getNearestAppointment = "$baseUrl/appointment/appointment/nearest";
}

//testerpayment@test.com
//Admin@123