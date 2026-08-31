import 'package:expense_control_app/core/presentation/widgets/delete_action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/edit_action_button_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/bank_utils.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/pay_method_utils.dart';
import 'package:flutter/material.dart';

class ExpenseWidget extends StatelessWidget {
  const new({
    super.key,
    required this.expenseName,
    required this.amount,
    this.bankName,
    required this.isFixed,
    required this.payMethod,
    required this.onDeleted,
    required this.onEdited,
  });

  final String expenseName;
  final double amount;
  final String? bankName;
  final bool isFixed;
  final String payMethod;
  final VoidCallback onDeleted;
  final VoidCallback onEdited;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 28,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expenseName,
                  style: const TextStyle(fontSize: 28, fontWeight: .w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 12,
                  children: [
                    EditActionButtonWidget(onEdited: onEdited),
                    DeleteActionButtonWidget(onDeleted: onDeleted),
                  ],
                ),
              ],
            ),
            Column(
              spacing: 16,
              children: [
                Row(
                  children: [
                    Text(
                      'Monto pagado: \$$amount',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Pagado con: ', style: TextStyle(fontSize: 24)),
                    Text(
                      getPayMethodName(payMethod),
                      style: const TextStyle(fontSize: 24),
                    ),
                    if (bankName != null)
                      Text(
                        ' (${getBankName(bankName!)})',
                        style: const TextStyle(fontSize: 24),
                      ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                if (isFixed)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text(
                      'Gasto Fijo',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
