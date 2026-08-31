import 'package:expense_control_app/features/fixed_term_deposit/presentation/utils/date_utils.dart';
import 'package:flutter/material.dart';

class FixedTermDepositCard extends StatelessWidget {
  const new({
    super.key,
    required this.id,
    required this.fixedTermDepositName,
    required this.depositAmount,
    required this.depositAmountReceived,
    required this.depositDate,
    required this.depositDueDate,
    required this.dolarPrice,
    required this.onDeleted,
    required this.onEdited,
  });

  final int id;
  final String fixedTermDepositName;
  final double depositAmount;
  final double depositAmountReceived;
  final DateTime depositDate;
  final DateTime depositDueDate;
  final double dolarPrice;
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
                  fixedTermDepositName,
                  style: const TextStyle(fontSize: 30, fontWeight: .w600),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: getDueDateColor(
                          depositDueDate.difference(depositDate).inDays,
                        ),
                      ),
                      child: Text(
                        'Vence en: ${depositDueDate.difference(depositDate).inDays} días',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.calendar_month),
                        Text(
                          'Fecha de depósito: ${depositDate.day.toString().length > 1 ? '${depositDate.day}' : '0${depositDate.day}'}\\${depositDate.month.toString().length > 1 ? '${depositDate.month}' : '0${depositDate.month}'}\\${depositDate.year}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.calendar_month),
                        Text(
                          'Fecha de vencimiento: ${depositDueDate.day.toString().length > 1 ? '${depositDueDate.day}' : '0${depositDueDate.day}'}\\${depositDueDate.month.toString().length > 1 ? '${depositDueDate.month}' : '0${depositDueDate.month}'}\\${depositDueDate.year}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.lock_outline),
                        Text(
                          'Monto depositado: \$$depositAmount',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.savings_outlined),
                        Text(
                          'Monto a recibir: \$$depositAmountReceived',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.attach_money),
                        Text(
                          'Precio del dólar: \$$dolarPrice',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
