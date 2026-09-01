import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/enums/expense_sections_type.dart';
import 'package:flutter/material.dart';

class ExpenseAlertDialogDropdownSection extends StatelessWidget {
  const new({
    super.key,
    required this.sectionAvailable,
    required this.expenseDropdownSectionType,
    required this.title,
    required this.hint,
    this.onChangedPayMethodSelected,
    this.onChangedBankSelected,
  });

  final bool sectionAvailable;
  final ExpenseDropdownSectionType expenseDropdownSectionType;
  final String title;
  final String hint;
  final ValueChanged<PayMethod?>? onChangedPayMethodSelected;
  final ValueChanged<Bank?>? onChangedBankSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: sectionAvailable
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                expenseDropdownSectionType ==
                        ExpenseDropdownSectionType.payMethod
                    ? DropdownButtonFormField<PayMethod>(
                        hint: Text(hint, style: const TextStyle(fontSize: 16)),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: PayMethod.creditCard,
                            child: Text('Tarjeta de Crédito'),
                          ),
                          DropdownMenuItem(
                            value: PayMethod.debitCard,
                            child: Text('Tarjeta de Débito'),
                          ),
                          DropdownMenuItem(
                            value: PayMethod.mercadoPago,
                            child: Text('Mercado Pago'),
                          ),
                          DropdownMenuItem(
                            value: PayMethod.cash,
                            child: Text('Efectivo'),
                          ),
                        ],
                        onChanged: onChangedPayMethodSelected,
                      )
                    : DropdownButtonFormField<Bank>(
                        hint: Text(hint, style: const TextStyle(fontSize: 16)),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: Bank.bancoMacro,
                            child: Text('Banco Macro'),
                          ),
                          DropdownMenuItem(
                            value: Bank.bancoProvincia,
                            child: Text('Banco Provincia'),
                          ),
                          DropdownMenuItem(
                            value: Bank.bancoComafi,
                            child: Text('Banco Comafi'),
                          ),
                        ],
                        onChanged: onChangedBankSelected,
                      ),
                const SizedBox(height: 16),
              ],
            )
          : null,
    );
  }
}
