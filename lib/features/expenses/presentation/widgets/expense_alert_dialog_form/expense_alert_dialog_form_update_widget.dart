import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/enums/expense_sections_type.dart';
import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/bank_utils.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/pay_method_utils.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_dropdown_section.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseAlertDialogFormUpdateWidget extends ConsumerStatefulWidget {
  const new({
    super.key,
    required this.id,
    required this.expenseName,
    required this.amount,
    required this.bankName,
    required this.isFixed,
    required this.payMethod,
  });

  final int id;
  final String expenseName;
  final double amount;
  final Bank? bankName;
  final bool isFixed;
  final PayMethod payMethod;

  @override
  ConsumerState<ExpenseAlertDialogFormUpdateWidget> createState() =>
      _ExpenseAlertDialogFormUpdateWidgetState();
}

class _ExpenseAlertDialogFormUpdateWidgetState
    extends ConsumerState<ExpenseAlertDialogFormUpdateWidget> {
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
  bool? isFixed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Actualizar Gasto',
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
                    if (expenseNameController.text.isEmpty &&
                        widget.expenseName.isNotEmpty) {
                      return null;
                    }
                    if (expenseNameController.text.isEmpty) {
                      return 'El campo no puede estar vacío.';
                    }
                    return null;
                  },
                  expenseSectionType: ExpenseSectionType.expenseName,
                  controller: expenseNameController,
                  title: 'Nombre del gasto',
                  hintText: 'Nombre actual: ${widget.expenseName}',
                ),
                ExpenseAlertDialogFormSection(
                  validator: (_) {
                    if (expenseAmountController.text.isEmpty &&
                        widget.amount.toString().isNotEmpty) {
                      return null;
                    }
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
                  hintText: 'Monto actual: \$${widget.amount.toString()}',
                ),
                ExpenseAlertDialogFormDropdownSection(
                  sectionAvailable: true,
                  expenseDropdownSectionType:
                      ExpenseDropdownSectionType.payMethod,
                  payMethodValidator: (value) {
                    if (widget.payMethod.toString().isNotEmpty) return null;
                    if (value == null) return 'Seleccione un método de pago';
                    return null;
                  },
                  title: 'Método de pago',
                  hint:
                      'Método de pago actual seleccionado: ${getPayMethodName(widget.payMethod.name)}',
                  onChangedPayMethodSelected: (value) {
                    setState(() {
                      payMethodSelected = value;
                      if (payMethodSelected!.index !=
                              PayMethod.mercadoPago.index &&
                          payMethodSelected!.index != PayMethod.cash.index) {
                        sectionAvailable = true;
                      } else {
                        bankSelected = null;
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
                  hint:
                      'Banco actual seleccionado: ${getBankName(widget.bankName?.name ?? '')}',
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
                      value: isFixed ?? widget.isFixed,
                      onChanged: (value) {
                        setState(() => isFixed = value);
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
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Cancelar',
        ),
        ActionButtonWidget(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await ref
                  .read(expensesProvider.notifier)
                  .updateExpense(
                    id: widget.id,
                    name: expenseNameController.text.isEmpty
                        ? widget.expenseName
                        : expenseNameController.text,
                    amount: expenseAmountController.text.isEmpty
                        ? widget.amount
                        : double.tryParse(expenseAmountController.text),
                    payMethod: payMethodSelected ?? widget.payMethod,
                    bank:
                        ((payMethodSelected?.index ==
                                    PayMethod.mercadoPago.index ||
                                payMethodSelected?.index ==
                                    PayMethod.cash.index) &&
                            bankSelected == null)
                        ? bankSelected
                        : bankSelected ?? widget.bankName,
                    isFixed: isFixed ?? widget.isFixed,
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
