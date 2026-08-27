import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseEntity>> getAllExpenses();
  Future<void> deleteExpense({required int id});
  Future<void> updateExpense({
    required int id,
    String? name,
    PayMethod? payMethod,
    Bank? bank,
    bool? isFixed,
  });
}
