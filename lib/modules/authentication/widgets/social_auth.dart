import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = QHelperFunction.isDarkMode(context);
    return Container(
      width: QSizes.iconXl,
      decoration: BoxDecoration(
          color: !isDark ? QColors.light : QColors.dark,
          borderRadius:
              const BorderRadius.all(Radius.circular(QSizes.borderRadiusLg))),
      child: const Image(image: AssetImage(QImages.logoGoogle)),
    );
  }
}
