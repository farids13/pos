import 'package:flutter/material.dart';

class QIconButtonTheme {
  QIconButtonTheme._();

  static IconButtonThemeData ligthIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: Colors.black,
    ),
  );

  static IconButtonThemeData darkIconButtonTheme = const IconButtonThemeData();
}
