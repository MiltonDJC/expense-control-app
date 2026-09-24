import 'package:expense_control_app/core/presentation/extensions/string_formatter.dart';
import 'package:expense_control_app/core/presentation/utils/format_date_utils.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/due_date_information_widget.dart';
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
  });

  final int id;
  final String fixedTermDepositName;
  final double depositAmount;
  final double depositAmountReceived;
  final DateTime depositDate;
  final DateTime depositDueDate;
  final double dolarPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 14,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fixedTermDepositName.capitalize,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Row(
                  children: [
                    DueDateInformationWidget(
                      depositDate: depositDate,
                      depositDueDate: depositDueDate,
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
                          'Fecha de depósito: ${formatDate(depositDate)}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.calendar_month),
                        Text(
                          'Fecha de vencimiento: ${formatDate(depositDueDate)}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.lock),
                        Text(
                          'Monto depositado: \$$depositAmount',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.savings),
                        Text(
                          'Monto a recibir: \$$depositAmountReceived',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.attach_money),
                        Text(
                          'Precio del dólar: \$$dolarPrice',
                          style: Theme.of(context).textTheme.bodyLarge,
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
