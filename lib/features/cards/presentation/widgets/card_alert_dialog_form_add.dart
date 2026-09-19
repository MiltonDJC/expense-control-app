import 'package:expense_control_app/core/presentation/utils/app_snack_bar.dart';
import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/form_date_picker_section.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/presentation/state/cards_notifier.dart';
import 'package:expense_control_app/features/cards/presentation/utils/get_card_color.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardAlertDialogFormAdd extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<CardAlertDialogFormAdd> createState() =>
      _CardAlertDialogFormAddState();
}

class _CardAlertDialogFormAddState
    extends ConsumerState<CardAlertDialogFormAdd> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreditCardType creditCardType = CreditCardType.visa;
  Bank bank = Bank.bancoComafi;
  DateTime closeDate = DateTime.now();
  DateTime dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Registrar tarjeta',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 256,
                  width: 416,
                  child: CreditCardWidget(
                    creditCardType: creditCardType,
                    bank: bank,
                    closeDate: closeDate,
                    dueDate: dueDate,
                    cardColor: getCardColor(bank),
                  ),
                ),
                SizedBox(
                  width: 480,
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
                        initialValue: creditCardType,
                        hint: const Text('Seleccione el tipo de tarjeta'),
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
                        initialValue: bank,
                        hint: const Text('Seleccione el banco emisor'),
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
                        hintText: 'Seleccione una fecha',
                        datePicked: (dateSelected) {
                          setState(() {
                            closeDate = dateSelected!;
                          });
                        },
                        validator: null,
                      ),
                      FormDatePickerSection(
                        title: 'Fecha de vencimiento',
                        hintText: 'Seleccione una fecha',
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
                  .addCreditCard(
                    creditCardType: creditCardType,
                    bank: bank,
                    dueDate: dueDate,
                    closeDate: closeDate,
                  );
              if (context.mounted) Navigator.pop(context);
              if (context.mounted) {
                AppSnackBar.show(context, 'Tarjeta añadida con éxito.');
              }
            }
          },
          text: 'Confirmar',
        ),
      ],
    );
  }
}
