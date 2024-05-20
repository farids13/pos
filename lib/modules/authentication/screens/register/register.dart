import 'package:cashier_app/commons/styles/spacing_styles.dart';
import 'package:cashier_app/modules/authentication/controllers/register_controller.dart';
import 'package:cashier_app/modules/authentication/validator/auth_validator.dart';
import 'package:cashier_app/modules/authentication/widgets/divider.dart';
import 'package:cashier_app/modules/authentication/widgets/social_auth.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/constants/text_strings.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:cashier_app/utils/logging/logger.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ctrl = RegisterController();

  Future<void> _handleSignUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ctrl.firstNameController.text = prefs.getString("firstName") ?? "";
    ctrl.lastNameController.text = prefs.getString("lastName") ?? "";
    ctrl.emailController.text = prefs.getString("email") ?? "";
    ctrl.fullNameController.text = prefs.getString("fullName") ?? "";
    ctrl.phoneNumberController.text = prefs.getString("phoneNumber") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = QHelperFunction.isDarkMode(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: isDark ? Colors.white : Colors.black,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: QSpacingStyle.paddingWithAppHeightBar,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(QTexts.createAccountTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: QSizes.defaultSpace),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ctrl.firstNameController,
                            onSaved: (newValue) =>
                                ctrl.dto.firstName = newValue,
                            validator: (value) =>
                                AuthValidator.validateStandartInput(value),
                            expands: false,
                            decoration: const InputDecoration(
                                labelText: QTexts.firstName,
                                prefixIcon: Icon(Iconsax.user)),
                          ),
                        ),
                        const SizedBox(width: QSizes.spaceBetweenInputFields),
                        Expanded(
                            child: TextFormField(
                          controller: ctrl.lastNameController,
                          onSaved: (newValue) => ctrl.dto.lastName = newValue,
                          validator: (value) =>
                              AuthValidator.validateStandartInput(value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: QTexts.lastName,
                              prefixIcon: Icon(Iconsax.user4)),
                        )),
                      ],
                    ),
                    const SizedBox(height: QSizes.spaceBetweenInputFields),
                    TextFormField(
                      controller: ctrl.fullNameController,
                      onSaved: (newValue) => ctrl.dto.userName = newValue,
                      validator: (value) =>
                          AuthValidator.validateStandartInput(value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: QTexts.fullName,
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(height: QSizes.spaceBetweenInputFields),
                    TextFormField(
                      controller: ctrl.emailController,
                      onSaved: (newValue) => ctrl.dto.email = newValue,
                      validator: (value) => AuthValidator.validateEmail(value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: QTexts.emailHint,
                          prefixIcon: Icon(Iconsax.direct)),
                    ),
                    const SizedBox(height: QSizes.spaceBetweenInputFields),
                    TextFormField(
                      controller: ctrl.phoneNumberController,
                      onSaved: (newValue) => ctrl.dto.phoneNumber = newValue,
                      validator: (value) => AuthValidator.validatePhone(value),
                      expands: false,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: QTexts.phoneNumber,
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(height: QSizes.spaceBetweenInputFields),
                    TextFormField(
                      onSaved: (newValue) => ctrl.dto.password = newValue,
                      validator: (value) =>
                          AuthValidator.validatePassword(value),
                      expands: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: QTexts.passwordHint,
                          prefixIcon: Icon(Iconsax.key),
                          suffixIcon: Icon(Iconsax.eye_slash)),
                    ),
                    const SizedBox(height: QSizes.defaultSpace),

                    // Aggree and Privacy Policy
                    Row(
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                Checkbox(value: true, onChanged: (value) {})),
                        const SizedBox(width: QSizes.spaceBetweenInputFields),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: '${QTexts.iAgree} ',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                  text: QTexts.privacyPolicy,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: isDark
                                            ? QColors.white
                                            : QColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: isDark
                                            ? QColors.white
                                            : QColors.primary,
                                      )), // TextSpan
                              TextSpan(
                                  text: " ${QTexts.and} ",
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                text: QTexts.termsOfService,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: isDark
                                          ? QColors.white
                                          : QColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: isDark
                                          ? QColors.white
                                          : QColors.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //Button Submit

                    const SizedBox(
                      height: QSizes.defaultSpace,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: QSizes.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            ctrl.register(context);
                          }
                        },
                        child: const Text(QTexts.createAccount),
                      ),
                    ),

                    const SizedBox(
                      height: QSizes.spaceBetweenInputFields,
                    ),

                    const DividerWidget(
                      text: QTexts.orSignUp,
                    ),
                    const SizedBox(
                      height: QSizes.spaceBetweenInputFields,
                    ),
                    SocialAuthWidget(
                      isLogin: false,
                      onButtonPressed: _handleSignUp,
                    ),
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
