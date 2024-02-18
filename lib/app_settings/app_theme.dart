import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color upColor = const Color(0xff58A225);
  static Color darkGreen = const Color(0xff3b9000);
  static Color lightGreen = const Color(0xff75E58B);
  static Color errorColor = Colors.redAccent;
  static Color primaryColorDark = const Color(0xff0074B4);
  static Color primaryColorLight = const Color(0xff0074B4);
  static Color disabledColorDark = const Color(0x60909097);
  static Color disabledColorLight = const Color(0x60909097);
  static Color dividerColorDark = const Color(0xff00A4FF);
  static Color dividerColorLight = const Color(0xff71717D);
  static Color hintColorDark = const Color.fromARGB(255, 0, 122, 188);
  static Color hintColorLight = const Color(0xff717D7D);
  static Color scaffoldBackgroundColorDark = const Color(0xff000D29);
  static Color scaffoldBackgroundColorLight = Colors.white;
  static Color cardColorDark = const Color(0xff000D29);
  static Color cardColorLight = const Color.fromARGB(255, 239, 239, 239);
  static Color createColor = const Color(0xff847BDB);
  static Color shareColor = const Color(0xff3BD1B8);
  static Color controlColor = const Color(0xffACEB63);
  static Color monitorColor = const Color(0xffFFF85E);
  static Color charcoalColor = const Color.fromARGB(255, 28, 28, 28);
  static double smallFontSize = 13;
  static double mediumFontSize = 15;
  static double largeFontSize = 17;

  static ColorScheme darkColorTheme = const ColorScheme.dark().copyWith(
    background: const Color(0xff001940),
  );

  static ColorScheme lightColorTheme = const ColorScheme.dark().copyWith(
    background: const Color.fromARGB(255, 234, 231, 231),
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => primaryColorDark),
          foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white)));

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => primaryColorLight),
          foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white)));

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      colorScheme: darkColorTheme,
      scaffoldBackgroundColor: scaffoldBackgroundColorDark,
      elevatedButtonTheme: darkElevatedButtonTheme,
      primaryColor: primaryColorDark,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      cardColor: cardColorDark,
      hintColor: hintColorDark,
      disabledColor: disabledColorDark,
      dividerColor: dividerColorDark,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorTheme.background,
        foregroundColor: primaryColorDark,
        iconTheme: IconThemeData(
          color: primaryColorDark,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: primaryColorDark),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color: primaryColorDark))),
      textTheme: GoogleFonts.robotoTextTheme(
        TextTheme(
          displayLarge: TextStyle(fontSize: largeFontSize + 1),
          displayMedium: TextStyle(fontSize: mediumFontSize),
          displaySmall: TextStyle(fontSize: smallFontSize),
          titleLarge: TextStyle(fontSize: largeFontSize, color: Colors.white),
          titleMedium: TextStyle(fontSize: mediumFontSize, color: Colors.white),
          titleSmall: TextStyle(fontSize: smallFontSize, color: Colors.white),
          labelLarge: TextStyle(fontSize: largeFontSize, color: Colors.white),
          labelMedium: TextStyle(fontSize: mediumFontSize, color: Colors.white),
          labelSmall: TextStyle(fontSize: smallFontSize, color: Colors.white),
          bodyLarge: TextStyle(fontSize: largeFontSize),
          bodyMedium: TextStyle(fontSize: mediumFontSize),
          bodySmall: TextStyle(fontSize: smallFontSize),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white));

  static ThemeData lightTheme = ThemeData(
      colorScheme: lightColorTheme,
      scaffoldBackgroundColor: scaffoldBackgroundColorLight,
      elevatedButtonTheme: lightElevatedButtonTheme,
      primaryColor: primaryColorLight,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      cardColor: cardColorLight,
      hintColor: hintColorLight,
      disabledColor: disabledColorLight,
      dividerColor: dividerColorLight,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorTheme.background,
        foregroundColor: primaryColorLight,
        iconTheme: IconThemeData(
          color: primaryColorLight,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: primaryColorLight),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color: primaryColorLight))),
      textTheme: GoogleFonts.robotoTextTheme(
        TextTheme(
            displayLarge: TextStyle(fontSize: largeFontSize + 1, color: Colors.black),
            displayMedium: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            displaySmall: TextStyle(fontSize: smallFontSize, color: Colors.black),
            titleLarge: TextStyle(fontSize: largeFontSize, color: Colors.black),
            titleMedium: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            titleSmall: TextStyle(fontSize: smallFontSize, color: Colors.black),
            labelLarge: TextStyle(fontSize: largeFontSize, color: Colors.black),
            labelMedium: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            labelSmall: TextStyle(fontSize: smallFontSize, color: Colors.black),
            bodyLarge: TextStyle(fontSize: largeFontSize, color: Colors.black),
            bodyMedium: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            bodySmall: TextStyle(fontSize: smallFontSize, color: Colors.black)),
      ),
      iconTheme: const IconThemeData(color: Colors.black));
}
