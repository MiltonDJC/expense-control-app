import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  const new({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: text == 'Confirmar'
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.errorContainer,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
