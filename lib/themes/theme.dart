import 'package:flutter/material.dart';

const primaryColor = Color(0xFF26D5FB);

ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
    foregroundColor: Color.fromARGB(255, 7, 255, 23),
  ),
);
