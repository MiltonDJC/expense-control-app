import 'package:expense_control_app/features/fixed_term_deposit/data/datasources/fixed_term_deposit_local_data_source.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/entities/fixed_term_deposit_entity.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';

class FixedTermDepositRepositoryImpl implements FixedTermDepositRepository {
  const FixedTermDepositRepositoryImpl({required this.dataSource});

  final FixedTermDepositLocalDataSource dataSource;

  @override
  Future<void> addFixedTermDeposit({
    required double depositAmount,
    required double depositAmountReceived,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  }) async {
    await dataSource.addFixedTermDeposit(
      depositAmount: depositAmount,
      depositAmountReceived: depositAmountReceived,
      depositDate: depositDate,
      depositDueDate: depositDueDate,
      dolarPrice: dolarPrice,
      name: name,
    );
  }

  @override
  Future<void> deleteFixedTermDeposit({required int id}) async {
    await dataSource.deleteFixedTermDeposit(id: id);
  }

  @override
  Future<void> updateFixedTermDeposit({
    required int id,
    double? depositAmount,
    double? depositAmountReceived,
    DateTime? depositDate,
    DateTime? depositDueDate,
    double? dolarPrice,
    String? name,
  }) async {
    await dataSource.updateFixedTermDeposit(
      id: id,
      depositAmount: depositAmount,
      depositAmountReceived: depositAmountReceived,
      depositDate: depositDate,
      depositDueDate: depositDueDate,
      dolarPrice: dolarPrice,
      name: name,
    );
  }

  @override
  Future<List<FixedTermDepositEntity>> getAllFixedTermDeposits() async {
    final fixedTermDepositsModels = await dataSource.getAllFixedTermDeposits();
    return fixedTermDepositsModels
        .map((fixedTermDepositsModel) => fixedTermDepositsModel.toEntity())
        .toList();
  }
}
