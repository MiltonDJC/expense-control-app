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
        data: (state) => ListView.builder(
          itemCount: state.expenses.length,
          itemBuilder: (context, index) {
            return Center(child: Card(child: Text(state.expenses[index].name)));
          },
        ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
