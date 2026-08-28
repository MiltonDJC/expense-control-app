import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';

class UpdateFixedTermDepositUseCase {
  UpdateFixedTermDepositUseCase({required this.fixedTermDepositRepository});

  final FixedTermDepositRepository fixedTermDepositRepository;

  Future<void> call({
    required int id,
    double? depositAmount,
    double? depositAmountReceived,
    DateTime? depositDate,
    DateTime? depositDueDate,
    double? dolarPrice,
    String? name,
  }) => fixedTermDepositRepository.updateFixedTermDeposit(
    id: id,
    depositAmount: depositAmount,
    depositAmountReceived: depositAmountReceived,
    depositDate: depositDate,
    depositDueDate: depositDueDate,
    dolarPrice: dolarPrice,
    name: name,
  );
}
