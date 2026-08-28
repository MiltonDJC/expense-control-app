import 'package:drift/drift.dart';
import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/expenses/data/models/expense_model.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';

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
    await appDatabase.managers.expense.filter((f) => f.id(id)).delete();
  }

  Future<void> updateExpense({
    required int id,
    String? name,
    PayMethod? payMethod,
    Bank? bank,
    bool? isFixed,
  }) async {
    await appDatabase.managers.expense
        .filter((f) => f.id(id))
        .update(
          (o) => o(
            name: Value.absentIfNull(name),
            payMethod: Value.absentIfNull(payMethod),
            bank: Value.absentIfNull(bank),
            isFixed: Value.absentIfNull(isFixed),
          ),
        );
  }

  Future<void> addExpense({
    required String name,
    required PayMethod payMethod,
    Bank? bank,
    required bool isFixed,
  }) async {
    await appDatabase.managers.expense.create(
      (o) => o(
        name: name,
        payMethod: payMethod,
        bank: Value.absentIfNull(bank),
        isFixed: isFixed,
      ),
    );
  }
}
