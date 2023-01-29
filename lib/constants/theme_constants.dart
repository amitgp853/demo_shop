import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constants.dart';

ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  backgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      )),
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
);
