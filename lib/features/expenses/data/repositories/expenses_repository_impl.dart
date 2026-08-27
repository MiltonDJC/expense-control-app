import 'package:expense_control_app/features/expenses/data/datasources/expenses_local_data_source.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  ExpensesRepositoryImpl({required this.dataSource});

  final ExpensesLocalDataSource dataSource;

  @override
  Future<List<ExpenseEntity>> getAllExpenses() async {
    final expensesModels = await dataSource.getAllExpenses();
    return expensesModels
        .map((expenseModel) => expenseModel.toEntity())
        .toList();
  }

  @override
  Future<void> deleteExpense({required int id}) async {
    await dataSource.deleteExpense(id: id);
  }

  @override
  Future<void> updateExpense({
    required int id,
    String? name,
    PayMethod? payMethod,
    Bank? bank,
    bool? isFixed,
  }) async {
    await dataSource.updateExpense(
      id: id,
      name: name,
      payMethod: payMethod,
      bank: bank,
      isFixed: isFixed,
    );
  }
}
