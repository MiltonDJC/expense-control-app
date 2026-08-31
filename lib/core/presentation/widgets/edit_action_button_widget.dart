import 'package:flutter/material.dart';

class EditActionButtonWidget extends StatelessWidget {
  const new({super.key, required this.onEdited});

  final VoidCallback onEdited;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onEdited,
      icon: const Icon(Icons.edit, color: Color(0xFF2F3776), size: 22),
      label: const Text('Editar', style: TextStyle(fontSize: 22)),
    );
  }
}
