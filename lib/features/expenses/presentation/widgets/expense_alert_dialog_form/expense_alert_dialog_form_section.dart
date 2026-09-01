import 'package:expense_control_app/features/expenses/presentation/enums/expense_sections_type.dart';
import 'package:flutter/material.dart';

class ExpenseAlertDialogFormSection extends StatefulWidget {
  const new({
    super.key,
    required this.expenseSectionType,
    required this.validator,
    required this.controller,
    required this.title,
    required this.hintText,
  });

  final ExpenseSectionType expenseSectionType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String title;
  final String hintText;

  @override
  State<ExpenseAlertDialogFormSection> createState() =>
      ExpenseAlertDialogFormSectionState();
}

class ExpenseAlertDialogFormSectionState
    extends State<ExpenseAlertDialogFormSection> {
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
            keyboardType: widget.expenseSectionType.name == 'amount'
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
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
