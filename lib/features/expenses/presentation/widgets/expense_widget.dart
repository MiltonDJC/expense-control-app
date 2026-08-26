import 'package:expense_control_app/features/expenses/presentation/utils/get_bank_name.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/get_pay_method_name.dart';
import 'package:flutter/material.dart';

class ExpenseWidget extends StatelessWidget {
  const new({
    super.key,
    required this.expenseName,
    this.bankName,
    required this.isFixed,
    required this.payMethod,
    required this.onPressed,
  });

  final String expenseName;
  final String? bankName;
  final bool isFixed;
  final String payMethod;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(expenseName),
          if (bankName != null) Text(getBankName(bankName!)),
          if (isFixed) const Text('Gasto Fijo'),
          Text(getPayMethodName(payMethod)),
          ElevatedButton.icon(
            onPressed: onPressed,
            label: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
