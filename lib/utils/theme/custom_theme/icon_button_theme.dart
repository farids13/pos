import 'package:cashier_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';

class QIconButtonTheme {
  QIconButtonTheme._();

  static IconButtonThemeData ligthIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: QColors.black,
    ),
  );

  static IconButtonThemeData darkIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: QColors.white,
    ),
  );
}
