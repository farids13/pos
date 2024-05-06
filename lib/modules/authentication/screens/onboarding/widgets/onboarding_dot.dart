import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/device/device_utility.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingDot extends StatelessWidget {
  const OnBoardingDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = QHelperFunction.isDarkMode(context);

    return Positioned(
      bottom: QDeviceUtils.getBottomNavigationBarHeight() + 20,
      left: QSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: PageController(),
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? QColors.light : QColors.dark,
          dotHeight: 6,
        ),
        count: 3,
      ),
    );
  }
}