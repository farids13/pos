// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cashier_app/data/api/pos_service_api.dart';
import 'package:cashier_app/data/dto/auth/login_dto.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginDTO oas = LoginDTO();
  String username = "";

  Future<void> login(BuildContext context) async {
    http.Response response = await PosServiceAPI.loginApi(oas);

    if (response.statusCode == 200) {
      var resData = json.decode(response.body);
      var token = resData['access_token'];

      http.Response userMe = await PosServiceAPI.userMe(token);
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
}
