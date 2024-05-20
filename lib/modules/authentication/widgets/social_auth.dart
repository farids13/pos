import 'package:cashier_app/data/api/google/google_sign_in_api.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class SocialAuthWidget extends StatelessWidget {
  final bool isLogin;
  final Function()? onButtonPressed;
  const SocialAuthWidget({super.key, required this.isLogin, this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    QHelperFunction.isDarkMode(context);
    return SizedBox(
      child: IconButton(
        onPressed: () => isLogin ? GoogleSignInAPI().handleSignIn(context) : {GoogleSignInAPI().handleSignUp(context, onButtonPressed!)},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(5),
          backgroundColor: const Color(0xffF7F7F9),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
        icon: const Image(
          image: AssetImage(QImages.logoGoogle),
          width: QSizes.iconXl,
        ),
      ),
    );
  }
}
