import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/money_pockets/presentation/state/money_pockets_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoneyPocketAddForm extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<MoneyPocketAddForm> createState() => _MoneyPocketAddFormState();
}

class _MoneyPocketAddFormState extends ConsumerState<MoneyPocketAddForm> {
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
      actionsOverflowButtonSpacing: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Registrar Bolsillo',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Nombre', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacío.';
                  }
                  return null;
                },
                controller: _moneyPocketNameController,
                decoration: const InputDecoration(
                  hintText: 'Nombre del bolsillo',
                ),
              ),
              const SizedBox(height: 16),
              Text('Monto', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacío.';
                  }
                  if (value.contains(',')) {
                    return 'Utilice el punto en vez de la coma';
                  }
                  if (int.tryParse(value) is int ||
                      double.tryParse(value) is double) {
                    return null;
                  } else {
                    return 'El campo debe tener caracteres numéricos';
                  }
                },
                controller: _moneyPocketAmountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(hintText: '\$ 0.00'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      actions: [
        ActionButtonWidget(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ref
                  .read(moneyPocketsProvider.notifier)
                  .addMoneyPocket(
                    name: _moneyPocketNameController.text,
                    amount: double.tryParse(_moneyPocketAmountController.text)!,
                  );
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          text: 'Confirmar',
        ),
        ActionButtonWidget(
          onPressed: () => Navigator.pop(context),
          text: 'Cancelar',
        ),
      ],
    );
  }
}
