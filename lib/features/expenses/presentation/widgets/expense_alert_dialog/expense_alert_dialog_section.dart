import 'package:expense_control_app/features/expenses/presentation/enums/expense_sections_type.dart';
import 'package:flutter/material.dart';

class ExpenseAlertDialogSection extends StatefulWidget {
  const new({
    super.key,
    required this.expenseSectionType,
    required this.controller,
    required this.title,
    required this.hintText,
  });

  final ExpenseSectionType expenseSectionType;
  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  State<ExpenseAlertDialogSection> createState() =>
      ExpenseAlertDialogSectionState();
}

class ExpenseAlertDialogSectionState extends State<ExpenseAlertDialogSection> {
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
          TextField(
            controller: widget.controller,
            keyboardType: ExpenseSectionType.amount.name == 'amount'
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
