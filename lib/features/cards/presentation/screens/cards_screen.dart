import 'package:expense_control_app/core/presentation/widgets/custom_floating_action_button.dart';
import 'package:expense_control_app/features/cards/presentation/state/cards_notifier.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/card_alert_dialog_form_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardsScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsProvider);

    return Scaffold(
      body: cards.when(
        data: (state) => state.cards.isEmpty
            ? const Center(
                child: Text(
                  'No hay tarjetas registradas por el momento...',
                  style: TextStyle(fontSize: 26),
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(bottom: 72),
                child: Center(child: Text('Tarjetas listadas')),
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: CustomFloatingActionButton(
        title: 'Agregar tarjeta',
        tooltip: 'Agregar nueva tarjeta',
        icon: Icons.add,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return const CardAlertDialogFormAdd();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
