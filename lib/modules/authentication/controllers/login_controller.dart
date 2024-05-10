// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cashier_app/data/dto/auth/login_dto.dart';
import 'package:cashier_app/utils/config/config.dart';
import 'package:cashier_app/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final baseUrl = AppConfig.baseUrl;
  LoginDTO oas = LoginDTO();
  String username = "";

  Future<void> login(BuildContext context) async {
    http.Response response = await _loginApi();

    if (response.statusCode == 200) {
      var resData = json.decode(response.body);
      var token = resData['access_token'];

      http.Response userMe = await _userMe(token);
      if (userMe.statusCode == 200) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', token);
        });
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('username', username);
        });

        var resBody = json.decode(userMe.body);
        username = resBody['name'];
        context.pushReplacement("/home/$username");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(json.decode(userMe.body)["message"]),
            elevation: 10,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(json.decode(response.body)["message"]),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<http.Response> _loginApi() async {
    var prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.https(baseUrl, "/api/v1/auth/signin");
    Map<String, dynamic> body = oas.toJson();
    body["deviceId"] = prefs.getString("deviceId") ?? "";

    QLoggerHelper.info(body.toString());

    var response = await http.post(uri,
        body: json.encode(body), headers: AppConfig.headers);

    return response;
  }

  Future<http.Response> _userMe(String token) async {
    Uri uri = Uri.https(baseUrl, "/api/v1/user/me");

    Map<String, String> headers = Map.from(AppConfig.headers);
    headers['Authorization'] = 'Bearer $token';

    var response = await http.get(uri, headers: headers);
    return response;
  }
}
