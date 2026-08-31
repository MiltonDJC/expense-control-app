import 'package:flutter/material.dart';

class DeleteActionButtonWidget extends StatelessWidget {
  const new({super.key, required this.onDeleted});

  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xFFFF0033)),
      ),
      onPressed: onDeleted,
      icon: const Icon(Icons.delete, color: Colors.white, size: 22),
      label: const Text(
        'Eliminar',
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }
}
