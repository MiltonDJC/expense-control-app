import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';

class DeleteExpenseUseCase {
  DeleteExpenseUseCase({required this.expensesRepository});

  final ExpensesRepository expensesRepository;

  Future<void> call({required int id}) =>
      expensesRepository.deleteExpense(id: id);
}
