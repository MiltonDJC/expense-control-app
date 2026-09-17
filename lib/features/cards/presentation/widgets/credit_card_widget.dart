import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/presentation/utils/credit_card_date_formatter.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/bank_utils.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.creditCardType,
    required this.bank,
    required this.dueDate,
    required this.closeDate,
    required this.cardColor,
  });

  final CreditCardType creditCardType;
  final Bank bank;
  final DateTime dueDate;
  final DateTime closeDate;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final String formattedDueDate = formatCreditCardDate(dueDate);
    final String formattedCloseDate = formatCreditCardDate(closeDate);

    return Container(
      width: 480,
      height: 234,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Fila superior: Banco y Tipo de Tarjeta
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getBankName(bank.name).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                creditCardType.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Chip simulado
          Row(
            children: [
              Container(
                width: 45,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.amber[700]!, width: 1),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  '**** **** **** 3892',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 3.0,
                  ),
                ),
              ),
            ],
          ),

          // Fila inferior: Nombre, Vencimiento y Cierre
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cierre: $formattedCloseDate',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Vencimiento: $formattedDueDate',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
