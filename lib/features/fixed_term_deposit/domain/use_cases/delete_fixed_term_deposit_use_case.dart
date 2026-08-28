import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';

class DeleteFixedTermDepositUseCase {
  DeleteFixedTermDepositUseCase({required this.fixedTermDepositRepository});

  final FixedTermDepositRepository fixedTermDepositRepository;

  Future<void> call({required int id}) =>
      fixedTermDepositRepository.deleteFixedTermDeposit(id: id);
}
