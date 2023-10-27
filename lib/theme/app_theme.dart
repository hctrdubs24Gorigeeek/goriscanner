import 'package:flutter/material.dart';

class AppTheme {
  // Colores del tema ganeral de la aplicación
  static const Color primaryColor = Color(0xffc66722);
  static const Color successColor = Color(0xff6bd700);
  static const Color dangerColor = Color(0xffff0000);

  static final ThemeData theme = ThemeData(useMaterial3: true).copyWith(
    primaryColor: primaryColor,
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      bodyMedium: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      bodyLarge: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      headlineSmall:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      headlineMedium:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      headlineLarge:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      labelSmall: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      labelMedium:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      labelLarge: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      displaySmall:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      displayMedium:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      displayLarge:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      titleSmall: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      titleMedium:
          TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
      titleLarge: TextStyle(fontFamily: 'LouisGeorgeCafe', color: Colors.black),
    ),
    // Estilos generales para los AppBar
    appBarTheme: const AppBarTheme(
      toolbarHeight: 90,
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          fontFamily: 'LouisGeorgeCafe', color: Colors.white, fontSize: 28),
      centerTitle: true,
      color: AppTheme.primaryColor,
      elevation: 8,
      shadowColor: Colors.black,
      // foregroundColor: Colors.white,
    ),
    // Estilos generales para los inputs
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 18),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff646c74), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff646c74), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff646c74), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
    // Estilos generales para los elevated buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        textStyle: const TextStyle(fontSize: 22, fontFamily: 'LouisGeorgeCafe'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Colors.white,
      todayBackgroundColor: MaterialStatePropertyAll(primaryColor),
      todayForegroundColor: MaterialStatePropertyAll(Colors.white),
    ),
  );
}
