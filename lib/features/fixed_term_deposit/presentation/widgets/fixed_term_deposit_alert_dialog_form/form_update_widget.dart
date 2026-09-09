import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/utils/format_date_utils.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/form_date_picker_section.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormUpdateWidget extends ConsumerStatefulWidget {
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
  ConsumerState<FormUpdateWidget> createState() => _FormUpdateWidgetState();
}

class _FormUpdateWidgetState extends ConsumerState<FormUpdateWidget> {
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
                FormSection(
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
                FormSection(
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
                FormSection(
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
                FormSection(
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
                FormDatePickerSection(
                  title: 'Fecha de depósito',
                  hintText: 'Fecha previa: ${formatDate(widget.depositDate)}',
                  datePicked: _getDepositDate,
                  validator: null,
                ),
                FormDatePickerSection(
                  title: 'Fecha de vencimiento',
                  hintText:
                      'Fecha previa: ${formatDate(widget.depositDueDate)}',
                  datePicked: _getDepositDueDate,
                  validator: (_) {
                    // TODO: Corregir lógica de validacion para la selección de fechas.
                    // TODO: Revisar si es posible utilizar el value '(_)' del parámetro.
                    if (_depositDueDateSelected != null &&
                        _depositDueDateSelected!.isBefore(widget.depositDate)) {
                      return 'La fecha no puede ser previa a la fecha de depósito';
                    }
                    if (_depositDateSelected != null &&
                        _depositDueDateSelected!.isBefore(
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
              if (context.mounted) Navigator.pop(context);
            }
          },
          text: 'Confirmar',
        ),
      ],
    );
  }
}
