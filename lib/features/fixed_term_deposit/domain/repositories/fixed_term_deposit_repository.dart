import 'package:expense_control_app/features/fixed_term_deposit/domain/entities/fixed_term_deposit_entity.dart';

abstract class FixedTermDepositRepository {
  Future<void> addFixedTermDeposit();
  Future<void> updateFixedTermDeposit();
  Future<void> deleteFixedTermDeposit();
  Future<List<FixedTermDepositEntity>> getAllFixedTermDeposits();
}
