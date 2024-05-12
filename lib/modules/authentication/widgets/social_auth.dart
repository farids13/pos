import 'package:cashier_app/data/api/google/google_sign_in_api.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    QHelperFunction.isDarkMode(context);
    return SizedBox(
      child: ElevatedButton.icon(
        onPressed: () => GoogleSignInAPI().handleSignIn(context),
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
          ],
        ),
        label: const Text(
          "Sign In with Google Test",
          style: TextStyle(
            color: Color(0xff2B2B2B),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
