import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pockets_repository.dart';

class AddExpenseUseCase {
  AddExpenseUseCase({
    required this.expensesRepository,
    required this.moneyPocketsRepository,
  });

  final ExpensesRepository expensesRepository;
  final MoneyPocketsRepository moneyPocketsRepository;

  Future<void> call({
    required String name,
    required double amount,
    required PayMethod payMethod,
    Bank? bank,
    required bool isFixed,
    int? moneyPocketId,
    required DateTime createdDate,
  }) async {
    if (moneyPocketId == null) {
      await expensesRepository.addExpense(
        name: name,
        amount: amount,
        payMethod: payMethod,
        bank: bank,
        isFixed: isFixed,
        moneyPocketId: null,
        createdDate: createdDate,
      );
    } else {
      final moneyPockets = await moneyPocketsRepository.getAllMoneyPockets();

      final moneyPocket = moneyPockets.firstWhere(
        (moneyPocket) => moneyPocket.id == moneyPocketId,
      );

      await expensesRepository.addExpense(
        name: name,
        amount: amount,
        payMethod: payMethod,
        bank: bank,
        isFixed: isFixed,
        moneyPocketId: moneyPocketId,
        createdDate: createdDate,
      );
      await moneyPocketsRepository.updateMoneyPocket(
        id: moneyPocketId,
        amount: moneyPocket.amount - amount,
      );
    }
  }
}
