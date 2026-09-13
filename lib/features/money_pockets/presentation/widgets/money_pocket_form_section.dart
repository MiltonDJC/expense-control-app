import 'package:flutter/material.dart';

class MoneyPocketFormSection extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TextFormField(
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(hintText: hintText),
          ),
        ],
      ),
    );
  }
}
