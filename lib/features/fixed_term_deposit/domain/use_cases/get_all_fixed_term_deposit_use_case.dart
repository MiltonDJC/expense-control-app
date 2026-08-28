import 'package:expense_control_app/features/fixed_term_deposit/domain/entities/fixed_term_deposit_entity.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';

class GetAllFixedTermDepositsUseCase {
  GetAllFixedTermDepositsUseCase({required this.fixedTermDepositRepository});

  final FixedTermDepositRepository fixedTermDepositRepository;

  Future<List<FixedTermDepositEntity>> call() =>
      fixedTermDepositRepository.getAllFixedTermDeposits();
}
