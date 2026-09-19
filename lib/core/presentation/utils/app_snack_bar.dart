import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(fontSize: 24)),
          showCloseIcon: true,
          duration: const Duration(seconds: 1),
        ),
      );
}
