import 'package:cashier_app/modules/authentication/controllers/onboarding_controller.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/device/device_utility.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDot extends StatelessWidget {
  final OnboardingController controller;

  const OnBoardingDot({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dark = QHelperFunction.isDarkMode(context);

    return Positioned(
      bottom: QDeviceUtils.getBottomNavigationBarHeight() + 20,
      left: QSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller
            .pageController, // Gunakan controller yang diteruskan dari atas
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? QColors.light : QColors.dark,
          dotHeight: 6,
        ),
        count: 3,
      ),
    );
  }
}
