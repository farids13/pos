class QValidator {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  static bool isValidPassword(String password) {
    if (password.isEmpty) false;
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }

  static bool isValidInput(String input) {
    if (input.isEmpty) false;
    String regex = "[a-zA-Z\\d\\s,./\\-+_]+";
    return RegExp(regex).hasMatch(input);
  }
}
