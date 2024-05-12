import 'package:cashier_app/utils/config/config.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:cashier_app/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> scopes = <String>[
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ];

    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: AppConfig.clientId,
      scopes: scopes,
    );

    Future<void> _handleSignIn() async {
      try {
        QLoggerHelper.info('try signIn');
        await _googleSignIn.signIn().then((result) {
          QLoggerHelper.info("signIn: $result");
          result?.authentication.then((googleKey) {
            QLoggerHelper.info(googleKey.accessToken.toString());
            QLoggerHelper.info(googleKey.idToken.toString());
            QLoggerHelper.info(
                _googleSignIn.currentUser?.displayName.toString() ?? '');
          }).catchError((err) {
            QLoggerHelper.info('inner error');
          });
        }).catchError((err) {});
        QLoggerHelper.info('outer error');
      } catch (error) {
        QLoggerHelper.error(error.toString());
      }
    }

    final isDark = QHelperFunction.isDarkMode(context);
    return SizedBox(
      child: IconButton(
        onPressed: () => _handleSignIn(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(5),
          backgroundColor: const Color(0xffF7F7F9),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
        ),
        icon: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(QImages.logoGoogle),
              width: QSizes.iconXl,
            ),
            SizedBox(width: QSizes.defaultSpace),
            Text(
              "Sign In with Google Test",
              style: TextStyle(
                color: Color(0xff2B2B2B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
