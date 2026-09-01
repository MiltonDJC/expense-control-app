import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog/expense_alert_dialog_widget.dart';
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
                                return AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async =>
                                          Navigator.pop(context),
                                      child: const Text('Volver'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await ref
                                            .read(expensesProvider.notifier)
                                            .updateExpense(
                                              id: state.expenses[index].id,
                                              amount: 6,
                                              bank: Bank.bancoComafi,
                                              isFixed: true,
                                              payMethod: PayMethod.creditCard,
                                              name: 'Depósito actualizado',
                                            );
                                        ref.invalidate(expensesProvider);
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Confirmar'),
                                    ),
                                  ],
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
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Volver'),
                                    ),
                                    ElevatedButton(
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
                                      child: const Text('Confirmar'),
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
              return const ExpenseAlertDialogWidget();
            },
          );
        },
        tooltip: 'Agregar nuevo gasto',
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
