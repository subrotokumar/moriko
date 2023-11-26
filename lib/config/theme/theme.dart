import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moriko/config/theme/colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: lighBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff181818),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: grey.shade300,
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: grey.shade800,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: grey.shade800,
        ),
      );
}

const poppins = GoogleFonts.poppins;
