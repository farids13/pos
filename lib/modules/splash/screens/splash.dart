import 'package:cashier_app/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:uuid/uuid.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () async {
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
    if (!mounted) return;

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    String? username = prefs.getString("username");
    if (token != null && token.isNotEmpty ||
        username != null && username.isNotEmpty) {
      // ignore: use_build_context_synchronously
      context.pushReplacement('/home/${prefs.getString('username')}');
    } else {
      // ignore: use_build_context_synchronously
      context.pushReplacement('/onboarding');
    }
  }

  Future<void> _getId() async {
    try {
      String deviceId = await FlutterUdid.udid;
      if (deviceId.isEmpty) deviceId = const Uuid().v4();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('deviceId', deviceId);
      QLoggerHelper.info(deviceId);
    } catch (e) {
      QLoggerHelper.error(e.toString());
    }
  }
}
