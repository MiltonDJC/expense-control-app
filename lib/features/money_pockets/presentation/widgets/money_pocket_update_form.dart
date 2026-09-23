import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/money_pockets/presentation/state/money_pockets_notifier.dart';
import 'package:expense_control_app/features/money_pockets/presentation/widgets/money_pocket_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoneyPocketUpdateForm extends ConsumerStatefulWidget {
  const new({
    super.key,
    required this.id,
    required this.name,
    required this.amount,
  });

  final int id;
  final String name;
  final double amount;

  @override
  ConsumerState<MoneyPocketUpdateForm> createState() =>
      _MoneyPocketUpdateFormState();
}

class _MoneyPocketUpdateFormState extends ConsumerState<MoneyPocketUpdateForm> {
  late TextEditingController _moneyPocketNameController;
  late TextEditingController _moneyPocketAmountController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _moneyPocketNameController = TextEditingController();
    _moneyPocketAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _moneyPocketNameController.dispose();
    _moneyPocketAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Actualizar Bolsillo'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoneyPocketFormSection(
                  title: 'Nombre',
                  hintText: 'Nombre previo: ${widget.name}',
                  controller: _moneyPocketNameController,
                  validator: (value) {
                    if (value!.isEmpty) return null;
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                MoneyPocketFormSection(
                  title: 'Monto',
                  hintText: 'Monto previo: \$ ${widget.amount}',
                  controller: _moneyPocketAmountController,
                  validator: (value) {
                    if (value!.isEmpty) return null;
                    if (int.tryParse(value) is! int ||
                        double.tryParse(value) is! double) {
                      return 'El campo debe tener caracteres numéricos';
                    }
                    return null;
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonWidget(
                      onPressed: () => Navigator.pop(context),
                      text: 'Cancelar',
                    ),
                    const SizedBox(width: 8),
                    ActionButtonWidget(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(moneyPocketsProvider.notifier)
                              .updateMoneyPocket(
                                id: widget.id,
                                name: _moneyPocketNameController.text.isNotEmpty
                                    ? _moneyPocketNameController.text
                                    : widget.name,
                                amount:
                                    _moneyPocketAmountController.text.isNotEmpty
                                    ? double.tryParse(
                                        _moneyPocketAmountController.text,
                                      )
                                    : widget.amount,
                              );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      text: 'Confirmar',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
