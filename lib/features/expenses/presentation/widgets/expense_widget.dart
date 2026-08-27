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
    required this.onDeleted,
    required this.onEdited,
  });

  final String expenseName;
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
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expenseName,
                  style: const TextStyle(fontSize: 26, fontWeight: .w600),
                ),
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
            Row(
              children: [
                const Text('Pagado con: ', style: TextStyle(fontSize: 20)),
                Text(
                  getPayMethodName(payMethod),
                  style: const TextStyle(fontSize: 20),
                ),
                if (bankName != null)
                  Text(
                    ' (${getBankName(bankName!)})',
                    style: const TextStyle(fontSize: 20),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: onEdited,
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xFF2F3776),
                    size: 22,
                  ),
                  label: const Text('Editar', style: TextStyle(fontSize: 22)),
                ),
                OutlinedButton.icon(
                  onPressed: onDeleted,
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFFFF0033),
                    size: 22,
                  ),
                  label: const Text('Eliminar', style: TextStyle(fontSize: 22)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
