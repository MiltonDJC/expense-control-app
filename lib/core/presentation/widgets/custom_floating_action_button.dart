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
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Row(
        children: [
          Icon(icon, size: 26, fontWeight: FontWeight.w600),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      tooltip: tooltip,
    );
  }
}
