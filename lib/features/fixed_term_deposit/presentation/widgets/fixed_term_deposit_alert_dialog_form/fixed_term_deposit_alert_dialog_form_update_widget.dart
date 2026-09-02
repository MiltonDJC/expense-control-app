import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/fixed_term_deposit_alert_dialog_form_date_picker_section.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/fixed_term_deposit_alert_dialog_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixedTermDepositAlertDialogFormUpdateWidget
    extends ConsumerStatefulWidget {
  const new({
    super.key,
    required this.id,
    required this.depositAmount,
    required this.depositAmountReceived,
    required this.depositDate,
    required this.depositDueDate,
    required this.dolarPrice,
    required this.fixedTermDepositName,
  });

  final int id;
  final double depositAmount;
  final double depositAmountReceived;
  final DateTime depositDate;
  final DateTime depositDueDate;
  final double dolarPrice;
  final String fixedTermDepositName;

  @override
  ConsumerState<FixedTermDepositAlertDialogFormUpdateWidget> createState() =>
      _FixedTermDepositAlertDialogFormUpdateWidgetState();
}

class _FixedTermDepositAlertDialogFormUpdateWidgetState
    extends ConsumerState<FixedTermDepositAlertDialogFormUpdateWidget> {
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
                    if (widget.fixedTermDepositName.isNotEmpty) return null;
                    if (fixedTermDepositNameController.text.isEmpty) {
                      return 'El campo no puede estar vacío.';
                    }
                    return null;
                  },
                  controller: fixedTermDepositNameController,
                  title: 'Nombre del plazo fijo',
                  hintText:
                      'Nombre actual del plazo fijo: ${widget.fixedTermDepositName}',
                ),
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (widget.depositAmount.toString().isNotEmpty) return null;
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
                  hintText: 'Monto previo: \$${widget.depositAmount}',
                ),
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (widget.depositAmountReceived.toString().isNotEmpty) {
                      return null;
                    }
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
                  hintText: 'Monto previo: \$${widget.depositAmountReceived}',
                ),
                FixedTermDepositAlertDialogFormSection(
                  validator: (_) {
                    if (widget.dolarPrice.toString().isNotEmpty) return null;
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
                  hintText: 'Precio previo: \$${widget.dolarPrice}',
                ),
                FixedTermDepositAlertDialogFormDatePickerSection(
                  title: 'Fecha de depósito',
                  hintText:
                      'Fecha previa: ${widget.depositDate.day.toString().length > 1 ? '${widget.depositDate.day}' : '0${widget.depositDate.day}'}\\${widget.depositDate.month.toString().length > 1 ? '${widget.depositDate.month}' : '0${widget.depositDate.month}'}\\${widget.depositDate.year}',
                  datePicked: _getDepositDate,
                  validator: null,
                ),
                FixedTermDepositAlertDialogFormDatePickerSection(
                  title: 'Fecha de vencimiento',
                  hintText:
                      'Fecha previa: ${widget.depositDueDate.day.toString().length > 1 ? '${widget.depositDueDate.day}' : '0${widget.depositDueDate.day}'}\\${widget.depositDueDate.month.toString().length > 1 ? '${widget.depositDueDate.month}' : '0${widget.depositDueDate.month}'}\\${widget.depositDueDate.year}',
                  datePicked: _getDepositDueDate,
                  validator: (_) {
                    if (widget.depositDate.toString().isNotEmpty &&
                        widget.depositDate.toString().isNotEmpty) {
                      return null;
                    }
                    if (_depositDueDateSelected!.isBefore(widget.depositDate)) {
                      return 'La fecha no puede ser previa a la fecha de depósito';
                    } else if (_depositDueDateSelected!.isBefore(
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
                  .updateFixedTermDeposit(
                    id: widget.id,
                    depositAmount:
                        double.tryParse(depositAmountController.text) ??
                        widget.depositAmount,
                    depositAmountReceived:
                        double.tryParse(depositAmountReceivedController.text) ??
                        widget.depositAmountReceived,
                    depositDate: DateTime(
                      _depositDateSelected?.year ?? widget.depositDate.year,
                      _depositDateSelected?.month ?? widget.depositDate.month,
                      _depositDateSelected?.day ?? widget.depositDate.day,
                    ),
                    depositDueDate: DateTime(
                      _depositDueDateSelected?.year ??
                          widget.depositDueDate.year,
                      _depositDueDateSelected?.month ??
                          widget.depositDueDate.month,
                      _depositDueDateSelected?.day ?? widget.depositDueDate.day,
                    ),
                    dolarPrice:
                        double.tryParse(dolarPriceController.text) ??
                        widget.dolarPrice,
                    name: fixedTermDepositNameController.text.isNotEmpty
                        ? fixedTermDepositNameController.text
                        : widget.fixedTermDepositName,
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
