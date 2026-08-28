import 'package:flutter/material.dart';

class DeleteActionButtonWidget extends StatelessWidget {
  const new({super.key, required this.onDeleted});

  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onDeleted,
      icon: const Icon(Icons.delete, color: Color(0xFFFF0033), size: 22),
      label: const Text('Eliminar', style: TextStyle(fontSize: 22)),
    );
  }
}
