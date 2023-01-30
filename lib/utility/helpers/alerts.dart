import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackBar(BuildContext context,
    {required String message, bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor:
        error ? Colors.red.withOpacity(0.9) : Colors.green.withOpacity(0.9),
    content: Text(
      message,
      style: GoogleFonts.poppins().copyWith(color: Colors.white),
    ),
    behavior: SnackBarBehavior.floating,
  ));
}
