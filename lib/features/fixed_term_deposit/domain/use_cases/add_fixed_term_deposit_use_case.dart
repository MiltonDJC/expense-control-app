import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';

class AddFixedTermDepositUseCase {
  AddFixedTermDepositUseCase({required this.fixedTermDepositRepository});

  final FixedTermDepositRepository fixedTermDepositRepository;

  Future<void> call({
    required double depositAmount,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  }) => fixedTermDepositRepository.addFixedTermDeposit(
    depositAmount: depositAmount,
    depositDate: depositDate,
    depositDueDate: depositDueDate,
    dolarPrice: dolarPrice,
    name: name,
  );
}
