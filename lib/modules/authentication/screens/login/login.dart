import 'package:cashier_app/modules/authentication/screens/onboarding/widgets/onboarding_dot.dart';
import 'package:cashier_app/modules/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:cashier_app/modules/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/constants/text_strings.dart';
import 'package:cashier_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            children: const [
              OnBoardingPage(
                image: QImages.onboardingImages1,
                title: QTexts.onboardingTitle1,
                subTitle: QTexts.onboardingSubTitle1,
              ),
              OnBoardingPage(
                image: QImages.onboardingImages2,
                title: QTexts.onboardingTitle2,
                subTitle: QTexts.onboardingSubTitle2,
              ),
              OnBoardingPage(
                image: QImages.onboardingImages3,
                title: QTexts.onboardingTitle3,
                subTitle: QTexts.onboardingSubTitle3,
              ),
            ],
          ),
          // Skip Button
          const OnBoardingSkipButton(),

          // Dot Navigation
          const OnBoardingDot(),

          //Circular Button
          Positioned(
            right: QSizes.defaultSpace,
            bottom : QDeviceUtils.getBottomNavigationBarHeight(),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(QSizes.defaultSpace,),
                backgroundColor: Colors.blue,
              ),
              child: const Icon(Iconsax.arrow_right_3),
            ),
          ),
        ],
      ),
    );
  }
}
