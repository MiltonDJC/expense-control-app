import 'package:expense_control_app/features/expenses/presentation/providers/expenses_use_cases_provider.dart';
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
                  return Center(
                    child: ExpenseWidget(
                      expenseName: state.expenses[index].name,
                      bankName: state.expenses[index].bank?.name,
                      isFixed: state.expenses[index].isFixed,
                      payMethod: state.expenses[index].payMethod.name,
                      onPressed: () async {
                        await ref.read(deleteExpenseUseCaseProvider)(
                          id: state.expenses[index].id,
                        );
                        ref.invalidate(expensesProvider);
                      },
                    ),
                  );
                },
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Agregar nuevo gasto',
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
