import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'OpenSans',
      textTheme: textTheme());
}

TextTheme textTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
      fontSize: 35,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
      fontSize: 25,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
      fontSize: 20,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 12,
    ),
  );
}