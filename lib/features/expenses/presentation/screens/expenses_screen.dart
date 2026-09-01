import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_add_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_update_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpensesScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);

    return Scaffold(
      body: expenses.when(
        data: (state) => state.expenses.isEmpty
            ? const Center(
                child: Text(
                  'No hay gastos registrados por el momento...',
                  style: TextStyle(fontSize: 26),
                ),
              )
            : ListView.builder(
                itemCount: state.expenses.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: Key(state.expenses[index].id.toString()),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return ExpenseAlertDialogFormUpdateWidget(
                                  id: state.expenses[index].id,
                                  expenseName: state.expenses[index].name,
                                  amount: state.expenses[index].amount,
                                  bankName: state.expenses[index].bank,
                                  isFixed: state.expenses[index].isFixed,
                                  payMethod: state.expenses[index].payMethod,
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
                                            .read(expensesProvider.notifier)
                                            .deleteExpense(
                                              id: state.expenses[index].id,
                                            );
                                        ref.invalidate(expensesProvider);
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
                    child: ExpenseInformationWidget(
                      expenseName: state.expenses[index].name,
                      amount: state.expenses[index].amount,
                      bankName: state.expenses[index].bank,
                      isFixed: state.expenses[index].isFixed,
                      payMethod: state.expenses[index].payMethod,
                    ),
                  );
                },
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return const ExpenseAlertDialogFormAddWidget();
            },
          );
        },
        tooltip: 'Agregar nuevo gasto',
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
