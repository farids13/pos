import 'package:cashier_app/modules/authentication/controllers/onboarding_controller.dart';
import 'package:cashier_app/modules/authentication/widgets/onboarding_dot.dart';
import 'package:cashier_app/modules/authentication/widgets/onboarding_next.dart';
import 'package:cashier_app/modules/authentication/widgets/onboarding_page.dart';
import 'package:cashier_app/modules/authentication/widgets/onboarding_skip.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = OnboardingController();

    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            controller: ctrl.pageController,
            onPageChanged: ctrl.updatePageIndicator,
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
          OnBoardingDot(
            controller: ctrl,
          ),
          //Circular Button
          OnboardingNextButton(
            ctrl: ctrl,
          ),
        ],
      ),
    );
  }
}
