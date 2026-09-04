import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/custom_floating_action_button.dart';
import 'package:expense_control_app/features/money_pockets/presentation/state/money_pockets_notifier.dart';
import 'package:expense_control_app/features/money_pockets/presentation/widgets/money_pockets_alert_dialog_form/money_pockets_alert_dialog_form_add_widget.dart';
import 'package:expense_control_app/features/money_pockets/presentation/widgets/money_pockets_alert_dialog_form/money_pockets_alert_dialog_form_update_widget.dart';
import 'package:expense_control_app/features/money_pockets/presentation/widgets/money_pockets_alert_dialog_form/money_pocktes_list_element_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MoneyPocketsScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<MoneyPocketsScreen> createState() => _MoneyPocketsScreenState();
}

class _MoneyPocketsScreenState extends ConsumerState<MoneyPocketsScreen> {
  @override
  Widget build(BuildContext context) {
    final moneyPockets = ref.watch(moneyPocketsProvider);

    return Scaffold(
      body: moneyPockets.when(
        data: (state) => state.moneyPockets.isEmpty
            ? const Center(
                child: Text(
                  'No hay bolsillos registrados por el momento...',
                  style: TextStyle(fontSize: 26),
                ),
              )
            : ListView.builder(
                itemCount: state.moneyPockets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.2,
                        children: [
                          CustomSlidableAction(
                            onPressed: (context) async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return MoneyPocketsAlertDialogFormUpdateWidget(
                                    id: state.moneyPockets[index].id,
                                    name: state.moneyPockets[index].name,
                                    amount: state.moneyPockets[index].amount,
                                  );
                                },
                              );
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, color: Colors.white, size: 28),
                                SizedBox(height: 4),
                                Text(
                                  'Editar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.2,
                        children: [
                          CustomSlidableAction(
                            onPressed: (context) async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Center(
                                      child: Text(
                                        '¿Segura que quiere eliminar este bolsillo?',
                                      ),
                                    ),
                                    actions: [
                                      ActionButtonWidget(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        text: 'Cancelar',
                                      ),
                                      ActionButtonWidget(
                                        onPressed: () async {
                                          await ref
                                              .read(
                                                moneyPocketsProvider.notifier,
                                              )
                                              .deleteMoneyPocket(
                                                id: state
                                                    .moneyPockets[index]
                                                    .id,
                                              );
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        text: 'Confirmar',
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Eliminar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      child: MoneyPocketsListElementWidget(
                        name: state.moneyPockets[index].name,
                        amount: state.moneyPockets[index].amount,
                      ),
                    ),
                  );
                },
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Hubo un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return const MoneyPocketsAlertDialogFormAddWidget();
            },
          );
        },
        title: 'Agregar bolsillo',
        icon: Icons.add,
        tooltip: 'Agregar nuevo bolsillo',
      ),
    );
  }
}
