import 'package:drift/drift.dart';
import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/money_pockets/data/models/money_pocket_model.dart';

class MoneyPocketsLocalDataSource {
  MoneyPocketsLocalDataSource({required this.appDatabase});

  final AppDatabase appDatabase;

  Future<List<MoneyPocketModel>> getAllMoneyPockets() async {
    try {
      final moneyPocketRows = await appDatabase.managers.moneyPocket.get();
      final moneyPocketModels = moneyPocketRows
          .map(
            (moneyPocketRow) => MoneyPocketModel(
              id: moneyPocketRow.id,
              name: moneyPocketRow.name,
              amount: moneyPocketRow.amount,
            ),
          )
          .toList();
      return moneyPocketModels;
    } catch (e) {
      throw Exception(
        'No se pudo obtener los bolsillos registrados en la base de datos',
      );
    }
  }

  Future<void> updateMoneyPocket({
    required int id,
    String? name,
    double? amount,
  }) async {
    await appDatabase.managers.moneyPocket
        .filter((f) => f.id(id))
        .update(
          (o) => o(
            name: Value.absentIfNull(name),
            amount: Value.absentIfNull(amount),
          ),
        );
  }

  Future<void> deleteMoneyPocket({required int id}) async {
    await appDatabase.managers.moneyPocket.filter((f) => f.id(id)).delete();
  }
}
