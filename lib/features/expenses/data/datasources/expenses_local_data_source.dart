import 'package:drift/drift.dart';
import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/expenses/data/models/expense_model.dart';

class ExpensesLocalDataSource {
  ExpensesLocalDataSource({required this.appDatabase});

  final AppDatabase appDatabase;

  Future<List<ExpenseModel>> getAllExpenses() async {
    final expensesRows = await appDatabase.managers.expense.get();
    final expensesModels = expensesRows
        .map((expenseRow) => ExpenseModel.fromDrift(expenseRow))
        .toList();
    return expensesModels;
  }

  Future<void> deleteExpense({required int id}) async {
    await appDatabase.expense.deleteWhere(
      (expenseTable) => expenseTable.id.equals(id),
    );
  }
}
