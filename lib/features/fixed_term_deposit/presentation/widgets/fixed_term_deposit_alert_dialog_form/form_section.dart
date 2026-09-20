import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.textInputAction,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            textInputAction: textInputAction,
            autofocus: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
