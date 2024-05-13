// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cashier_app/data/dto/auth/register_dto.dart';
import 'package:cashier_app/utils/config/config.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class RegisterController {
  RegisterDTO dto = RegisterDTO();

  final baseUrl = AppConfig.baseUrl;

  Future<void> register(BuildContext context) async {
    http.Response response = await _registerApi();

    if (response.statusCode == 200) {
      context.pushReplacement("/login");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: QColors.success,
          content: Text("Success Register"),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: QColors.error,
          content: Text(json.decode(response.body)["message"]),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<http.Response> _registerApi() async {
    // var prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.https(baseUrl, "/api/v1/auth/signup");
    Map<String, dynamic> body = dto.toJson();
    var response = await http.post(uri,
        body: json.encode(body), headers: AppConfig.headers);

    return response;
  }
}
