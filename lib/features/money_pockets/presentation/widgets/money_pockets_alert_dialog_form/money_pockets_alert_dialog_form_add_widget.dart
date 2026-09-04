import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/money_pockets/presentation/state/money_pockets_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoneyPocketsAlertDialogFormAddWidget extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<MoneyPocketsAlertDialogFormAddWidget> createState() =>
      _MoneyPocketsAlertDialogFormAddWidgetState();
}

class _MoneyPocketsAlertDialogFormAddWidgetState
    extends ConsumerState<MoneyPocketsAlertDialogFormAddWidget> {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Registrar Bolsillo',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nombre',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El campo no puede estar vacío.';
                    }
                    return null;
                  },
                  controller: _moneyPocketNameController,
                  decoration: InputDecoration(
                    hintText: 'Nombre del bolsillo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Monto',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El campo no puede estar vacío.';
                    } else if (int.tryParse(value) is! int ||
                        double.tryParse(value) is! double) {
                      return 'El campo debe tener caracteres numéricos';
                    }
                    return null;
                  },
                  controller: _moneyPocketAmountController,
                  decoration: InputDecoration(
                    hintText: '\$ 0.00',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
            if (_formKey.currentState!.validate()) {
              await ref
                  .read(moneyPocketsProvider.notifier)
                  .addMoneyPocket(
                    name: _moneyPocketNameController.text,
                    amount: double.tryParse(_moneyPocketAmountController.text)!,
                  );
              ref.invalidate(moneyPocketsProvider);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          text: 'Confirmar',
        ),
      ],
    );
  }
}
