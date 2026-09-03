import 'package:drift/drift.dart';
import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/fixed_term_deposit/data/models/fixed_term_deposit_model.dart';

class FixedTermDepositLocalDataSource {
  FixedTermDepositLocalDataSource({required this.appDatabase});

  final AppDatabase appDatabase;

  Future<void> addFixedTermDeposit({
    required double depositAmount,
    required double depositAmountReceived,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  }) async {
    await appDatabase.managers.fixedTermDeposit.create(
      (o) => o(
        depositAmount: depositAmount,
        depositAmountReceived: depositAmountReceived,
        depositDate: depositDate,
        depositDueDate: depositDueDate,
        dolarPrice: dolarPrice,
        name: name,
      ),
    );
  }

  Future<void> updateFixedTermDeposit({
    required int id,
    double? depositAmount,
    double? depositAmountReceived,
    DateTime? depositDate,
    DateTime? depositDueDate,
    double? dolarPrice,
    String? name,
  }) async {
    await appDatabase.managers.fixedTermDeposit
        .filter((f) => f.id(id))
        .update(
          (o) => o(
            depositAmount: Value.absentIfNull(depositAmount),
            depositAmountReceived: Value.absentIfNull(depositAmountReceived),
            depositDate: Value.absentIfNull(depositDate),
            depositDueDate: Value.absentIfNull(depositDueDate),
            dolarPrice: Value.absentIfNull(dolarPrice),
            name: Value.absentIfNull(name),
          ),
        );
  }

  Future<void> deleteFixedTermDeposit({required int id}) async {
    await appDatabase.managers.fixedTermDeposit
        .filter((f) => f.id(id))
        .delete();
  }

  Future<List<FixedTermDepositModel>> getAllFixedTermDeposits() async {
    try {
      final fixedTermDepositRows = await appDatabase.managers.fixedTermDeposit
          .get();
      final fixedTermDepositModels = fixedTermDepositRows
          .map(
            (fixedTermDepositRow) =>
                FixedTermDepositModel.fromDrift(fixedTermDepositRow),
          )
          .toList();
      return fixedTermDepositModels;
    } catch (e) {
      throw Exception(
        'No se pudo obtener los plazos fijos registrados en la base de datos',
      );
    }
  }
}
