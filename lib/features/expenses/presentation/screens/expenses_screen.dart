import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  return ExpenseWidget(
                    expenseName: state.expenses[index].name,
                    amount: state.expenses[index].amount,
                    bankName: state.expenses[index].bank?.name,
                    isFixed: state.expenses[index].isFixed,
                    payMethod: state.expenses[index].payMethod.name,
                    onEdited: () async {
                      await ref
                          .read(expensesProvider.notifier)
                          .updateExpense(
                            id: state.expenses[index].id,
                            name: 'Gasto actualizado',
                            bank: Bank.bancoProvincia,
                            isFixed: true,
                            payMethod: PayMethod.mercadoPago,
                          );
                      ref.invalidate(expensesProvider);
                    },
                    onDeleted: () async {
                      await ref
                          .read(expensesProvider.notifier)
                          .deleteExpense(id: state.expenses[index].id);
                      ref.invalidate(expensesProvider);
                    },
                  );
                },
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref
              .read(expensesProvider.notifier)
              .addExpense(
                name: 'Gasto agregado',
                amount: 100.0,
                payMethod: PayMethod.debitCard,
                bank: Bank.bancoComafi,
                isFixed: false,
              );
          ref.invalidate(expensesProvider);
        },
        tooltip: 'Agregar nuevo gasto',
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
