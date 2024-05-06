import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await _checkLoginStatus();
      await _getId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.ac_unit,
          size: 100,
          color: Colors.blue,
        ),
      ),
    );
  }

  /// Methods
  Future<void> _checkLoginStatus() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    String? username = prefs.getString("username");
    if (token != null && token.isNotEmpty ||
        username != null && username.isNotEmpty) {
      context.pushReplacement('/home/${prefs.getString('username')}');
    } else {
      context.go('/login');
    }
  }

  Future<void> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      SharedPreferences.getInstance().then((value) {
        value.setString(
            "deviceId", iosDeviceInfo.identifierForVendor.toString());
      });
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      SharedPreferences.getInstance().then((value) {
        value.setString("deviceId", androidDeviceInfo.id);
      });
    }
  }
}
