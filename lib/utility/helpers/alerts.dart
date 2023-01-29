import 'package:flutter/material.dart';

showSnackBar(BuildContext context,
    {required String message, bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor:
        error ? Colors.red.withOpacity(0.9) : Colors.green.withOpacity(0.9),
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    behavior: SnackBarBehavior.floating,
  ));
}
