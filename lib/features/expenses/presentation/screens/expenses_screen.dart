import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
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
                    child: Card(
                      child: Column(
                        children: [
                          Text(state.expenses[index].id.toString()),
                          Text(state.expenses[index].name),
                          if (state.expenses[index].bank != null)
                            Text(state.expenses[index].bank!.name),
                          if (state.expenses[index].isFixed)
                            const Text('Gasto fijo'),
                          Text(state.expenses[index].payMethod.name),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await ref
                                  .read(expensesProvider.notifier)
                                  .deleteExpense(id: state.expenses[index].id);
                              ref.invalidate(expensesProvider);
                            },
                            label: const Icon(Icons.delete),
                          ),
                        ],
                      ),
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
