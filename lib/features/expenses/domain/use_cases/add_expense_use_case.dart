import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';

class AddExpenseUseCase {
  AddExpenseUseCase({required this.expensesRepository});

  final ExpensesRepository expensesRepository;

  Future<void> call({
    required String name,
    required double amount,
    required PayMethod payMethod,
    Bank? bank,
    required bool isFixed,
  }) => expensesRepository.addExpense(
    name: name,
    amount: amount,
    payMethod: payMethod,
    bank: bank,
    isFixed: isFixed,
  );
}
