import 'dart:convert';

import 'package:cashier_app/data/dto/auth/login_dto.dart';
import 'package:cashier_app/utils/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PosServiceAPI {
  static const baseUrl = AppConfig.baseUrl;

  //login

  static Future<http.Response> loginApi(LoginDTO oas) async {
    var prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.https(baseUrl, "/api/v1/auth/signin");
    Map<String, dynamic> body = oas.toJson();
    body["deviceId"] = prefs.getString("deviceId") ?? "";

    // QLoggerHelper.info(body.toString());

    var response = await http.post(uri,
        body: json.encode(body), headers: AppConfig.headers);

    return response;
  }

  //user me
  static Future<http.Response> userMe(String token) async {
    Uri uri = Uri.https(baseUrl, "/api/v1/user/me");

    Map<String, String> headers = Map.from(AppConfig.headers);
    headers['Authorization'] = 'Bearer $token';

    var response = await http.get(uri, headers: headers);
    return response;
  }
}
