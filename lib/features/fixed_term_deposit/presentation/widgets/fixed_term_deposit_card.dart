import 'package:flutter/material.dart';

class FixedTermDepositCard extends StatelessWidget {
  const new({
    super.key,
    required this.id,
    required this.fixedTermDepositName,
    required this.depositAmount,
    required this.depositDate,
    required this.depositDueDate,
    required this.dolarPrice,
    required this.onDeleted,
    required this.onEdited,
  });

  final int id;
  final String fixedTermDepositName;
  final double depositAmount;
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
                  style: const TextStyle(fontSize: 28, fontWeight: .w600),
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
                      label: const Text(
                        'Editar',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: onDeleted,
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFFFF0033),
                        size: 22,
                      ),
                      label: const Text(
                        'Eliminar',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha de depósito: ${depositDate.day.toString().length > 1 ? '${depositDate.day}' : '0${depositDate.day}'}\\${depositDate.month.toString().length > 1 ? '${depositDate.month}' : '0${depositDate.month}'}\\${depositDate.year}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Fecha de vencimiento: ${depositDueDate.day.toString().length > 1 ? '${depositDueDate.day}' : '0${depositDueDate.day}'}\\${depositDueDate.month.toString().length > 1 ? '${depositDueDate.month}' : '0${depositDueDate.month}'}\\${depositDueDate.year}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Monto depositado: \$$depositAmount',
                      style: const TextStyle(fontSize: 24),
                    ),
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
      ),
    );
  }
}
