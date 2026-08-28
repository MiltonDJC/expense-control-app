import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';

class UpdateExpenseUseCase {
  UpdateExpenseUseCase({required this.expensesRepository});

  final ExpensesRepository expensesRepository;

  Future<void> call({
    required int id,
    String? name,
    double? amount,
    PayMethod? payMethod,
    Bank? bank,
    bool? isFixed,
  }) => expensesRepository.updateExpense(
    id: id,
    name: name,
    amount: amount,
    payMethod: payMethod,
    bank: bank,
    isFixed: isFixed,
  );
}
