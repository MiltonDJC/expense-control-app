import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseEntity>> getAllExpenses();
  Future<void> deleteExpense({required int id});
  Future<void> updateExpense({
    required int id,
    required ExpenseEntity newExpense,
  });
}
