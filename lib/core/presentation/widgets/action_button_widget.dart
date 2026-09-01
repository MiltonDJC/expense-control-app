import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  const new({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    required this.text,
    required this.textColor,
  });

  final Color backgroundColor;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 18, color: textColor)),
    );
  }
}
