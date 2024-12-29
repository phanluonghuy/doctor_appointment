class AppRegex {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^84\d{9,10}$');
    return phoneRegex.hasMatch(phone);
  }
  static bool isValidPassword(String password) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,20}$',
    );
    return passwordRegExp.hasMatch(password);
  }
}
