import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';

class AddFixedTermDepositUseCase {
  AddFixedTermDepositUseCase({required this.fixedTermDepositRepository});

  final FixedTermDepositRepository fixedTermDepositRepository;

  Future<void> call({
    required double depositAmount,
    required double depositAmountReceived,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  }) => fixedTermDepositRepository.addFixedTermDeposit(
    depositAmount: depositAmount,
    depositAmountReceived: depositAmountReceived,
    depositDate: depositDate,
    depositDueDate: depositDueDate,
    dolarPrice: dolarPrice,
    name: name,
  );
}
