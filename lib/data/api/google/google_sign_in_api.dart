import 'dart:convert';
import 'dart:ffi';

import 'package:cashier_app/data/api/pos_service_api.dart';
import 'package:cashier_app/data/dto/auth/login_dto.dart';
import 'package:cashier_app/data/dto/auth/login_google_dto.dart';
import 'package:cashier_app/utils/config/config.dart';
import 'package:cashier_app/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInAPI {
  static const List<String> scopes = <String>[
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: AppConfig.clientId,
    scopes: scopes,
  );

  static Future<void> handleSignOut() async {
    await _googleSignIn.signOut();
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }

  Future<void> handleSignIn(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deviceId = prefs.getString("deviceId") ?? "";

      await _googleSignIn.signIn().then((result) {
        result?.authentication.then((googleKey) async {
          LoginGoogleDto oas = LoginGoogleDto();
          oas.accessToken = googleKey.accessToken.toString();
          oas.deviceId = deviceId;

          http.Response res = await socialSingInGoogleAPI(oas);
          if (res.statusCode == 200) {
            Map<String, dynamic> resData = json.decode(res.body);
            String token = resData['access_token'];

            http.Response userMeRes = await PosServiceAPI.userMe(token);
            if (userMeRes.statusCode == 200) {
              Map<String, dynamic> userMeData = json.decode(userMeRes.body);
              String username = userMeData['name'];

              SharedPreferences.getInstance().then((prefs) {
                prefs.setString('token', token);
                prefs.setString('username', username);
              });

              // ignore: use_build_context_synchronously
              context.pushReplacement("/home/$username");
            } else {
              QLoggerHelper.error(userMeRes.body);
            }
          } else {
            QLoggerHelper.error(res.body);
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Google Sing In Failed'),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }).catchError((err) {});
      }).catchError((err) {
        QLoggerHelper.error(err);
      });
    } catch (error) {
      QLoggerHelper.error(error.toString());
    }
  }

  Future<http.Response> socialSingInGoogleAPI(LoginGoogleDto oas) async {
    Uri uri = Uri.https(AppConfig.baseUrl, "/api/v1/auth/signInGoogle");
    Map<String, dynamic> body = oas.toJson();
    QLoggerHelper.info(body.toString());

    http.Response response = await http.post(uri,
        body: json.encode(body), headers: AppConfig.headers);
    QLoggerHelper.info(response.statusCode.toString());
    QLoggerHelper.info(response.body);

    return response;
  }
}
