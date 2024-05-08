// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cashier_app/utils/config/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final baseUrl = AppConfig.baseUrl;

  Future<void> login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    http.Response response = await _loginApi();

    if (response.statusCode == 200) {
      context.pushReplacement("/home/farid");
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Email atau password salah"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<http.Response> _loginApi() async {
    // var prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.https(baseUrl, "/api/v1/auth/signin");
    var body = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "deviceId": "e0d1a340-4031-4b7f-8d72-cd0ce05a22ef",
    };

    var response = await http.post(uri,
        body: json.encode(body), headers: AppConfig.headers);

    return response;
  }
}
