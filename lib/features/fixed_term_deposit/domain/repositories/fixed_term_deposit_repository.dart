import 'package:expense_control_app/features/fixed_term_deposit/domain/entities/fixed_term_deposit_entity.dart';

abstract class FixedTermDepositRepository {
  Future<void> addFixedTermDeposit({
    required double depositAmount,
    required double depositAmountReceived,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  });
  Future<void> updateFixedTermDeposit({
    required int id,
    double? depositAmount,
    double? depositAmountReceived,
    DateTime? depositDate,
    DateTime? depositDueDate,
    double? dolarPrice,
    String? name,
  });
  Future<void> deleteFixedTermDeposit({required int id});
  Future<List<FixedTermDepositEntity>> getAllFixedTermDeposits();
}
