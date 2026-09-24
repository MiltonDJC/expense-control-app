import 'package:expense_control_app/features/fixed_term_deposit/presentation/utils/due_date_utils.dart';
import 'package:flutter/material.dart';

class DueDateInformationWidget extends StatelessWidget {
  const new({
    super.key,
    required this.depositDate,
    required this.depositDueDate,
  });

  final DateTime depositDate;
  final DateTime depositDueDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: getDueDateColor(depositDueDate.difference(depositDate).inDays),
      ),
      child: Text(
        depositDueDate.difference(depositDate).inDays > 0
            ? 'Vence en: ${getDueDateMessage(depositDueDate.difference(depositDate).inDays)}'
            : 'Venció',
        style: Theme.of(context).primaryTextTheme.titleLarge,
      ),
    );
  }
}
