import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/fixed_term_deposit_alert_dialog_form_add_widget.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_alert_dialog_form/fixed_term_deposit_alert_dialog_form_update_widget.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FixedTermDepositScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixedTermDeposits = ref.watch(fixedTermDepositProvider);

    return Scaffold(
      body: fixedTermDeposits.when(
        data: (state) => state.fixedTermDeposits.isEmpty
            ? const Center(
                child: Text(
                  'No hay plazos fijos registrados por el momento...',
                  style: TextStyle(fontSize: 26),
                ),
              )
            : ListView.builder(
                itemCount: state.fixedTermDeposits.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: Key(state.fixedTermDeposits[index].id.toString()),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return FixedTermDepositAlertDialogFormUpdateWidget(
                                  id: state.fixedTermDeposits[index].id,
                                  depositAmount: state
                                      .fixedTermDeposits[index]
                                      .depositAmount,
                                  depositAmountReceived: state
                                      .fixedTermDeposits[index]
                                      .depositAmountReceived,
                                  depositDate: state
                                      .fixedTermDeposits[index]
                                      .depositDate,
                                  depositDueDate: state
                                      .fixedTermDeposits[index]
                                      .depositDueDate,
                                  dolarPrice:
                                      state.fixedTermDeposits[index].dolarPrice,
                                  fixedTermDepositName:
                                      state.fixedTermDeposits[index].name,
                                );
                              },
                            );
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Editar',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text(
                                      '¿Segura que quiere eliminar este gasto?',
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
                                              fixedTermDepositProvider.notifier,
                                            )
                                            .deleteFixedTermDeposit(
                                              id: state
                                                  .fixedTermDeposits[index]
                                                  .id,
                                            );
                                        ref.invalidate(
                                          fixedTermDepositProvider,
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
                          icon: Icons.delete,
                          label: 'Eliminar',
                        ),
                      ],
                    ),
                    child: FixedTermDepositCard(
                      id: state.fixedTermDeposits[index].id,
                      fixedTermDepositName: state.fixedTermDeposits[index].name,
                      depositAmount:
                          state.fixedTermDeposits[index].depositAmount,
                      depositAmountReceived:
                          state.fixedTermDeposits[index].depositAmountReceived,
                      depositDate: state.fixedTermDeposits[index].depositDate,
                      depositDueDate:
                          state.fixedTermDeposits[index].depositDueDate,
                      dolarPrice: state.fixedTermDeposits[index].dolarPrice,
                    ),
                  );
                },
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return const FixedTermDepositAlertDialogFormAddWidget();
            },
          );
        },
        label: const Row(
          children: [
            Icon(Icons.add, size: 26, fontWeight: FontWeight.w600),
            SizedBox(width: 6),
            Text(
              'Agregar plazo fijo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
