import 'package:expense_control_app/core/presentation/extensions/string_formatter.dart';
import 'package:expense_control_app/core/presentation/utils/app_snack_bar.dart';
import 'package:expense_control_app/core/presentation/utils/format_date_utils.dart';
import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/form_date_picker_section.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/presentation/state/cards_notifier.dart';
import 'package:expense_control_app/features/cards/presentation/utils/get_card_color.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/credit_card_alert_dialog_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/bank_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardAlertDialogFormUpdate extends ConsumerStatefulWidget {
  const new({
    super.key,
    required this.id,
    required this.creditCardType,
    required this.bank,
    required this.closeDate,
    required this.dueDate,
  });

  final int id;
  final CreditCardType creditCardType;
  final Bank bank;
  final DateTime closeDate;
  final DateTime dueDate;

  @override
  ConsumerState<CardAlertDialogFormUpdate> createState() =>
      _CardAlertDialogFormUpdateState();
}

class _CardAlertDialogFormUpdateState
    extends ConsumerState<CardAlertDialogFormUpdate> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreditCardType? creditCardType;
  Bank? bank;
  DateTime? dueDate;
  DateTime? closeDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Actualizar tarjeta'),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 360,
                  child: CreditCardAlertDialogWidget(
                    creditCardType: creditCardType ?? widget.creditCardType,
                    bank: bank ?? widget.bank,
                    dueDate: dueDate ?? widget.dueDate,
                    closeDate: closeDate ?? widget.closeDate,
                    cardColor: getCardColor(bank ?? widget.bank),
                  ),
                ),
                SizedBox(
                  width: 340,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tipo de tarjeta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CreditCardType>(
                        hint: Text(
                          'Tipo previo: ${widget.creditCardType.name.capitalize}',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: CreditCardType.mastercard,
                            child: Text('Mastercard'),
                          ),
                          DropdownMenuItem(
                            value: CreditCardType.visa,
                            child: Text('Visa'),
                          ),
                        ],
                        onChanged: (value) =>
                            setState(() => creditCardType = value!),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Banco',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Bank>(
                        hint: Text(
                          'Banco previo: ${getBankName(widget.bank.name)}',
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
                          DropdownMenuItem(
                            value: Bank.bancoNacion,
                            child: Text('Banco Nación'),
                          ),
                        ],
                        onChanged: (value) => setState(() => bank = value!),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FormDatePickerSection(
                        title: 'Fecha de cierre',
                        hintText:
                            'Fecha previa: ${formatDate(widget.closeDate)}',
                        datePicked: (dateSelected) {
                          setState(() {
                            closeDate = dateSelected!;
                          });
                        },
                        validator: null,
                      ),
                      FormDatePickerSection(
                        title: 'Fecha de vencimiento',
                        hintText: 'Fecha previa: ${formatDate(widget.dueDate)}',
                        datePicked: (dateSelected) {
                          setState(() {
                            dueDate = dateSelected!;
                          });
                        },
                        validator: null,
                      ),
                    ],
                  ),
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
                  .read(cardsProvider.notifier)
                  .updateCard(
                    id: widget.id,
                    creditCardType: creditCardType ?? widget.creditCardType,
                    bank: bank ?? widget.bank,
                    dueDate: dueDate ?? widget.dueDate,
                    closeDate: closeDate ?? widget.closeDate,
                  );

              if (context.mounted) Navigator.pop(context);
              if (context.mounted) {
                AppSnackBar.show(context, 'Tarjeta actualizada con éxito.');
              }
            }
          },
          text: 'Confirmar',
        ),
      ],
    );
  }
}
