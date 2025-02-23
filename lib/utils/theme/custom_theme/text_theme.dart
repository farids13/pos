import 'package:flutter/material.dart';

class QTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      color: Colors.black,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      color: Colors.black,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12.0,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme().copyWith(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      color: Colors.white,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12.0,
      color: Colors.white
    ),
  );
}
