import 'package:cashier_app/utils/constants/text_strings.dart';
import 'package:cashier_app/utils/validators/validation.dart';

class AuthValidator {
  static String? validateEmail(String? value) {
    if ((value == null || value.isEmpty) || !QValidator.isValidEmail(value)) {
      return QTexts.validationEmail;
    }
    return null;
  }

  static String? validateStandartInput(String? value) {
    if ((value == null || value.isEmpty) || !QValidator.isValidInput(value)) {
      return QTexts.validationStandartInput;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'Nomor telepon hanya boleh berisi angka';
    }

    // Periksa apakah nomor telepon memiliki panjang yang valid
    if (value.length < 6 || value.length > 15) {
      return 'Nomor telepon harus terdiri dari 6 hingga 15 karakter';
    }

    return null; // Return null jika valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password harus memiliki panjang minimal 8 karakter';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password harus memiliki setidaknya satu huruf besar (A-Z)';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password harus memiliki setidaknya satu huruf kecil (a-z)';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus memiliki setidaknya satu digit (0-9)';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password harus memiliki setidaknya satu karakter khusus dari !@#\$&*~';
    }
    return null;
  }
}
