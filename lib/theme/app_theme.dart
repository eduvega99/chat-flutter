import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryColor = Color(0xff2d665f);

  static const Color secondaryColor = Color(0xff61a485);

  // #bed4ce

  static ThemeData getTheme() {

    return ThemeData.light().copyWith(

      primaryColor: primaryColor,

      colorScheme: const ColorScheme.light().copyWith( primary: primaryColor, secondary: secondaryColor ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          primary: Colors.white,
          minimumSize: const Size(double.infinity, 50)
        )
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: _getInputBorder(),
        focusedBorder: _getInputBorder(),
        focusColor: AppTheme.primaryColor,
        fillColor: AppTheme.primaryColor,
        hoverColor: AppTheme.primaryColor,
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.white
        )
      )
    );
  }

  static OutlineInputBorder _getInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: AppTheme.primaryColor, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }

}

