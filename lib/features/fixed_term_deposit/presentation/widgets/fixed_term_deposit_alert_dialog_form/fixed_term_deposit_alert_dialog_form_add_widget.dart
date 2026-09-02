import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/fixed_term_deposit_alert_dialog_form_date_picker_section.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/fixed_term_deposit_alert_dialog_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixedTermDepositAlertDialogFormAddWidget extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<FixedTermDepositAlertDialogFormAddWidget> createState() =>
      _FixedTermDepositAlertDialogFormAddWidgetState();
}

class _FixedTermDepositAlertDialogFormAddWidgetState
    extends ConsumerState<FixedTermDepositAlertDialogFormAddWidget> {
  late TextEditingController depositAmountController;
  late TextEditingController depositAmountReceivedController;
  late TextEditingController dolarPriceController;
  late TextEditingController fixedTermDepositNameController;

  @override
  void initState() {
    super.initState();
    depositAmountController = TextEditingController();
    depositAmountReceivedController = TextEditingController();
    dolarPriceController = TextEditingController();
    fixedTermDepositNameController = TextEditingController();
  }

  @override
  void dispose() {
    depositAmountController.dispose();
    depositAmountReceivedController.dispose();
    dolarPriceController.dispose();
    fixedTermDepositNameController.dispose();
    super.dispose();
  }

  void _getDepositDate(DateTime? dateSelected) {
    setState(() {
      _depositDateSelected = dateSelected;
    });
  }

  void _getDepositDueDate(DateTime? dateSelected) {
    setState(() {
      _depositDueDateSelected = dateSelected;
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? _depositDateSelected;
  DateTime? _depositDueDateSelected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Registrar Plazo Fijo',
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
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (fixedTermDepositNameController.text.isEmpty) {
                      return 'El campo no puede estar vacío.';
                    }
                    return null;
                  },
                  controller: fixedTermDepositNameController,
                  title: 'Nombre del plazo fijo',
                  hintText: 'Ej. Vacaciones, Ahorros etc.',
                ),
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (depositAmountController.text.isEmpty) {
                      return 'El campo no puede estar vacío';
                    } else if (int.tryParse(depositAmountController.text)
                            is! int ||
                        double.tryParse(depositAmountController.text)
                            is! double) {
                      return 'El campo debe tener caracteres numéricos';
                    }
                    return null;
                  },
                  controller: depositAmountController,
                  title: 'Monto a depositar',
                  hintText: '0.00',
                ),
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (depositAmountReceivedController.text.isEmpty) {
                      return 'El campo no puede estar vacío';
                    } else if (int.tryParse(
                          depositAmountReceivedController.text,
                        ) is! int ||
                        double.tryParse(depositAmountReceivedController.text)
                            is! double) {
                      return 'El campo debe tener caracteres numéricos';
                    }
                    return null;
                  },
                  controller: depositAmountReceivedController,
                  title: 'Monto a recibir',
                  hintText: '0.00',
                ),
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (dolarPriceController.text.isEmpty) {
                      return 'El campo no puede estar vacío';
                    } else if (int.tryParse(dolarPriceController.text)
                            is! int ||
                        double.tryParse(dolarPriceController.text) is! double) {
                      return 'El campo debe tener caracteres numéricos';
                    }
                    return null;
                  },
                  controller: dolarPriceController,
                  title: 'Precio del dólar',
                  hintText: '0.00',
                ),
                FixedTermDepositAlertDialogFormDatePickerSection(
                  title: 'Fecha de depósito',
                  datePicked: _getDepositDate,
                  validator: null,
                ),
                FixedTermDepositAlertDialogFormDatePickerSection(
                  title: 'Fecha de vencimiento',
                  datePicked: _getDepositDueDate,
                  validator: (_) {
                    if (_depositDueDateSelected!.isBefore(
                      _depositDateSelected!,
                    )) {
                      return 'La fecha no puede ser previa a la fecha de depósito';
                    }
                    return null;
                  },
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
                  .read(fixedTermDepositProvider.notifier)
                  .addFixedTermDeposit(
                    depositAmount: double.tryParse(
                      depositAmountController.text,
                    )!,
                    depositAmountReceived: double.tryParse(
                      depositAmountReceivedController.text,
                    )!,
                    depositDate: DateTime(
                      _depositDateSelected!.year,
                      _depositDateSelected!.month,
                      _depositDateSelected!.day,
                    ),
                    depositDueDate: DateTime(
                      _depositDueDateSelected!.year,
                      _depositDueDateSelected!.month,
                      _depositDueDateSelected!.day,
                    ),
                    dolarPrice: double.tryParse(dolarPriceController.text)!,
                    name: fixedTermDepositNameController.text,
                  );
              ref.invalidate(fixedTermDepositProvider);
              if (context.mounted) Navigator.pop(context);
            }
          },
          text: 'Confirmar',
        ),
      ],
    );
  }
}
