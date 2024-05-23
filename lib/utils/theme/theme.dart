import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:cashier_app/utils/theme/custom_theme/appbar_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/chip_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/icon_button_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/text_field_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class QAppTheme {
  QAppTheme._();

  final Color errorColor = AppColors.red;
  static const Color scaffoldColor = AppColors.white;
  final Color textSolidColor = AppColors.black;
  final Color textDisabledColor = AppColors.black[400]!;
  static final Color borderColor = AppColors.white[500]!;
  final Color disabledColor = AppColors.black[200]!;
  final Color inputColor = AppColors.white;
  static final Color dividerColor = AppColors.white[400]!;

  static DividerThemeData dividerTheme =
      DividerThemeData(color: dividerColor, space: Dimens.dp24);

  static CardTheme get cardTheme {
    return CardTheme(
      elevation: 0,
      color: scaffoldColor,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        side: BorderSide(color: borderColor),
      ),
    );
  }

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      iconButtonTheme: QIconButtonTheme.ligthIconButtonTheme,
      primaryColor: Colors.blue,
      textTheme: QTextTheme.lightTextTheme,
      chipTheme: QChipTheme.lightChipTheme,
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: QAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: QElevatedButtonTheme.lightElevatedButtonTheme,
      checkboxTheme: QCheckBoxTheme.lightCheckboxTheme,
      bottomSheetTheme: QBottomSheetTheme.lightBottomSheetTheme,
      outlinedButtonTheme: QOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: QTextFieldTheme.lightInputDecorationTheme,
      dividerTheme: dividerTheme,
      cardTheme: cardTheme);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    iconButtonTheme: QIconButtonTheme.darkIconButtonTheme,
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
