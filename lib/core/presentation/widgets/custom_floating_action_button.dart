import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: FloatingActionButton.extended(
        icon: Icon(icon),
        onPressed: onPressed,
        label: Text(title),
        tooltip: tooltip,
      ),
    );
  }
}
