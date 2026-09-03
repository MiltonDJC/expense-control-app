import 'package:expense_control_app/features/money_pockets/data/datasources/money_pockets_local_data_source.dart';
import 'package:expense_control_app/features/money_pockets/domain/entities/money_pocket_entity.dart';
import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pockets_repository.dart';

class MoneyPocketsRepositoryImpl implements MoneyPocketsRepository {
  MoneyPocketsRepositoryImpl({required this.dataSource});

  final MoneyPocketsLocalDataSource dataSource;

  @override
  Future<List<MoneyPocketEntity>> getAllMoneyPockets() async {
    final moneyPocketModels = await dataSource.getAllMoneyPockets();
    return moneyPocketModels
        .map((moneyPocketModel) => moneyPocketModel.toEntity())
        .toList();
  }

  @override
  Future<void> updateMoneyPocket({
    required int id,
    String? name,
    double? amount,
  }) async {
    await dataSource.updateMoneyPocket(id: id, name: name, amount: amount);
  }

  @override
  Future<void> deleteMoneyPocket({required int id}) async {
    await dataSource.deleteMoneyPocket(id: id);
  }
}
