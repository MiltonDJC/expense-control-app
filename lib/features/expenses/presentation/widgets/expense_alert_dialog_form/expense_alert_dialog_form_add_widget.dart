import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/enums/expense_sections_type.dart';
import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_dropdown_section.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseAlertDialogFormAddWidget extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ExpenseAlertDialogFormAddWidget> createState() =>
      _ExpenseAlertDialogFormAddWidgetState();
}

class _ExpenseAlertDialogFormAddWidgetState
    extends ConsumerState<ExpenseAlertDialogFormAddWidget> {
  late TextEditingController expenseNameController;
  late TextEditingController expenseAmountController;

  @override
  void initState() {
    super.initState();
    expenseNameController = TextEditingController();
    expenseAmountController = TextEditingController();
  }

  @override
  void dispose() {
    expenseNameController.dispose();
    expenseAmountController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool sectionAvailable = false;
  PayMethod? payMethodSelected;
  Bank? bankSelected;
  bool isFixed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Registrar Gasto',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpenseAlertDialogFormSection(
                  validator: (_) {
                    if (expenseNameController.text.isEmpty) {
                      return 'El campo no puede estar vacío.';
                    }
                    return null;
                  },
                  expenseSectionType: ExpenseSectionType.expenseName,
                  controller: expenseNameController,
                  title: 'Nombre del gasto',
                  hintText: 'Ej. Supermercado, Luz, etc.',
                ),
                ExpenseAlertDialogFormSection(
                  validator: (_) {
                    if (expenseAmountController.text.isEmpty) {
                      return 'El campo no puede estar vacío';
                    } else if (int.tryParse(expenseAmountController.text)
                            is! int ||
                        double.tryParse(expenseAmountController.text)
                            is! double) {
                      return 'El campo debe tener caracteres numéricos';
                    }
                    return null;
                  },
                  expenseSectionType: ExpenseSectionType.amount,
                  controller: expenseAmountController,
                  title: 'Monto',
                  hintText: '0.00',
                ),
                ExpenseAlertDialogFormDropdownSection(
                  sectionAvailable: true,
                  expenseDropdownSectionType:
                      ExpenseDropdownSectionType.payMethod,
                  payMethodValidator: (value) {
                    if (value == null) {
                      return 'Seleccione un método de pago';
                    }
                    return null;
                  },
                  title: 'Método de pago',
                  hint: 'Seleccione el método de pago',
                  onChangedPayMethodSelected: (value) {
                    setState(() {
                      payMethodSelected = value;
                      if (payMethodSelected!.index !=
                              PayMethod.mercadoPago.index &&
                          payMethodSelected!.index != PayMethod.cash.index) {
                        sectionAvailable = true;
                      } else {
                        sectionAvailable = false;
                      }
                    });
                  },
                ),
                ExpenseAlertDialogFormDropdownSection(
                  sectionAvailable: sectionAvailable,
                  expenseDropdownSectionType: ExpenseDropdownSectionType.bank,
                  bankValidator: (value) {
                    if (value == null) return 'Seleccione un banco';
                    return null;
                  },
                  title: 'Banco',
                  hint: 'Seleccione el banco utilizado',
                  onChangedBankSelected: (value) {
                    setState(() => bankSelected = value);
                  },
                ),
                Row(
                  children: [
                    const Text(
                      '¿Es un gasto fijo?:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Checkbox(
                      value: isFixed,
                      onChanged: (value) {
                        setState(() => isFixed = value!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ActionButtonWidget(
          onPressed: () => Navigator.pop(context),
          text: 'Cancelar',
        ),
        ActionButtonWidget(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await ref
                  .read(expensesProvider.notifier)
                  .addExpense(
                    name: expenseNameController.text,
                    amount: double.tryParse(expenseAmountController.text)!,
                    payMethod: payMethodSelected!,
                    bank:
                        payMethodSelected!.index !=
                                PayMethod.mercadoPago.index &&
                            payMethodSelected!.index != PayMethod.cash.index
                        ? bankSelected
                        : null,
                    isFixed: isFixed,
                  );
              ref.invalidate(expensesProvider);
              if (context.mounted) Navigator.pop(context);
            }
          },
          text: 'Confirmar',
        ),
      ],
    );
  }
}
