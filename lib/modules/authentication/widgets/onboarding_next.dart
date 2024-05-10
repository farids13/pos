import 'package:cashier_app/modules/authentication/controllers/onboarding_controller.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextButton extends StatelessWidget {
  final OnboardingController ctrl;

  const OnboardingNextButton({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: QSizes.defaultSpace,
      bottom: QDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => ctrl.nextPage(context),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(
            QSizes.defaultSpace,
          ),
          backgroundColor: Colors.blue,
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
