import 'package:cashier_app/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:cashier_app/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class QAppTheme {
  QAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    textTheme: QTextTheme.lightTextTheme,
    elevatedButtonTheme: QElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    textTheme: QTextTheme.darkTextTheme,
    elevatedButtonTheme: QElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
