import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: QDeviceUtils.getAppBarHeight(),
      right: QSizes.defaultSpace,
      child: TextButton(
          onPressed: () => context.pushReplacement('/login'),
          child: const Text('Skip')),
    );
  }
}
