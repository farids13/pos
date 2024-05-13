// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cashier_app/commons/styles/spacing_styles.dart';
import 'package:cashier_app/modules/authentication/controllers/login_controller.dart';
import 'package:cashier_app/modules/authentication/validator/auth_validator.dart';
import 'package:cashier_app/modules/authentication/widgets/divider.dart';
import 'package:cashier_app/modules/authentication/widgets/social_auth.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/constants/text_strings.dart';
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
    final LoginController loginCtrl = LoginController();
    final formKey = GlobalKey<FormState>();

    Future<void> _submitForm() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await loginCtrl.login(context);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: QSpacingStyle.paddingWithAppHeightBar,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(QImages.logoLoginImages),
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
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: QSizes.spaceBetweenSections),
                    //email
                    TextFormField(
                      onSaved: (newValue) => loginCtrl.oas.email = newValue,
                      validator: (value) => AuthValidator.validateEmail(value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: QTexts.emailHint),
                    ),
                    const SizedBox(height: QSizes.defaultSpace),

                    //password
                    TextFormField(
                      onFieldSubmitted: (value) => _submitForm(),
                      onSaved: (newValue) => loginCtrl.oas.password = newValue,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: QTexts.passwordHint,
                        suffixIcon: Icon(Iconsax.eye),
                      ),
                      // validator: (value) => AuthValidator.validatePassword(value)
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

                    // button Login
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => _submitForm(),
                            child: const Text(QTexts.login))),
                    const SizedBox(height: QSizes.defaultSpace),

                    //button register
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () => context.push("/register"),
                          child: const Text(QTexts.register)),
                    ),

                    // social sign in
                    const SizedBox(height: QSizes.defaultSpace),
                    const DividerWidget(
                      text: QTexts.orSignIn,
                    ),
                    const SizedBox(height: QSizes.defaultSpace),
                    const SocialAuthWidget(),
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
