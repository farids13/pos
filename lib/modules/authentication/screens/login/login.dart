import 'dart:ffi';

import 'package:cashier_app/commons/styles/spacing_styles.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/constants/text_strings.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = QHelperFunction.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: QSpacingStyle.paddingWithAppHeightBar,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(QImages.logoLoginImages),
                    height: QSizes.iconXl * 5,
                  ),
                  Text(QTexts.homeAppBarTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: QSizes.sm),
                  Text(QTexts.homeAppBarSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: QTexts.emailHint),
                    ),
                    const SizedBox(height: QSizes.defaultSpace),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: QTexts.passwordHint,
                        suffixIcon: Icon(Iconsax.eye),
                      ),
                    ),
                    const SizedBox(
                      height: QSizes.spaceBetweenInputFields,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                              ),
                              const Text(QTexts.rememberMe),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(QTexts.forgotPassword)),
                        ]),
                    const SizedBox(height: QSizes.spaceBetweenSections),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () =>
                                context.pushReplacement("/home/123"),
                            child: const Text(QTexts.login))),
                    const SizedBox(height: QSizes.defaultSpace),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text(QTexts.register)),
                    ),
                    const SizedBox(height: QSizes.defaultSpace),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Divider(
                          color: isDark ? QColors.light : QColors.dark,
                          thickness: 1,
                          indent: 60,
                          endIndent: 5,
                        )),
                        Text(QTexts.or,
                            style: Theme.of(context).textTheme.labelMedium),
                        Flexible(
                            child: Divider(
                          color: isDark ? QColors.light : QColors.dark,
                          thickness: 1,
                          indent: 5,
                          endIndent: 60,
                        )),
                      ],
                    ),
                    const SizedBox(height: QSizes.defaultSpace),
                    Container(
                      width: QSizes.iconXl,
                      decoration: BoxDecoration(
                          color: !isDark ? QColors.light : QColors.dark,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(QSizes.borderRadiusLg))),
                      child: const Image(image: AssetImage(QImages.logoGoogle)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
