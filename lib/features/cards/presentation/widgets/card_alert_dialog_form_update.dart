import 'package:expense_control_app/core/presentation/extensions/string_formatter.dart';
import 'package:expense_control_app/core/presentation/utils/format_date_utils.dart';
import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/form_date_picker_section.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/presentation/state/cards_notifier.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardAlertDialogFormUpdate extends ConsumerStatefulWidget {
  const new({
    super.key,
    required this.id,
    required this.creditCardType,
    required this.bank,
    required this.dueDate,
    required this.closeDate,
  });

  final int id;
  final CreditCardType creditCardType;
  final Bank bank;
  final DateTime dueDate;
  final DateTime closeDate;

  @override
  ConsumerState<CardAlertDialogFormUpdate> createState() =>
      _CardAlertDialogFormUpdateState();
}

class _CardAlertDialogFormUpdateState
    extends ConsumerState<CardAlertDialogFormUpdate> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreditCardType? creditCardType;
  Bank? bank;
  DateTime? closeDate;
  DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(cardsProvider);

    return cards.when(
      data: (state) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Actualizar tarjeta',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 256,
                    width: 416,
                    child: CreditCardWidget(
                      creditCardType: creditCardType ?? widget.creditCardType,
                      bank: bank ?? widget.bank,
                      closeDate: closeDate ?? widget.closeDate,
                      dueDate: dueDate ?? widget.dueDate,
                      cardColor: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 480,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                            'Tarjeta seleccionada: ${widget.creditCardType.name.capitalize}',
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
                        FormDatePickerSection(
                          title: 'Fecha de cierre',
                          hintText:
                              'Fecha anterior: ${formatDate(widget.closeDate)}',
                          datePicked: (dateSelected) {
                            setState(() {
                              closeDate = dateSelected!;
                            });
                          },
                          validator: null,
                        ),
                        FormDatePickerSection(
                          title: 'Fecha de vencimiento',
                          hintText:
                              'Fecha anterior: ${formatDate(widget.dueDate)}',
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
              }
            },
            text: 'Confirmar',
          ),
        ],
      ),
      error: (error, stackTrace) =>
          Center(child: Text('Hubo un error: ${error.toString()}')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
