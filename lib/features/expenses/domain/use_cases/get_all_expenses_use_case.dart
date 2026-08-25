import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';

class GetAllExpensesUseCase {
  GetAllExpensesUseCase({required this.expensesRepository});

  final ExpensesRepository expensesRepository;

  Future<List<ExpenseEntity>> call() => expensesRepository.getAllExpenses();
}
