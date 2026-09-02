import 'package:flutter/material.dart';

class FixedTermDepositAlertDialogFormSection extends StatefulWidget {
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
  State<FixedTermDepositAlertDialogFormSection> createState() =>
      FixedTermDepositAlertDialogFormSectionState();
}

class FixedTermDepositAlertDialogFormSectionState
    extends State<FixedTermDepositAlertDialogFormSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
            controller: widget.controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
