import 'package:cashier_app/utils/theme/custom_theme/appbar_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/chip_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/text_field_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class QAppTheme {
  QAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: QTextTheme.lightTextTheme,
    chipTheme: QChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: QAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: QElevatedButtonTheme.lightElevatedButtonTheme,
    checkboxTheme: QCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: QBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: QOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: QTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: QTextTheme.darkTextTheme,
    chipTheme: QChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: QAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: QElevatedButtonTheme.darkElevatedButtonTheme,
    checkboxTheme: QCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: QBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: QOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: QTextFieldTheme.darkInputDecorationTheme,
  );
}
