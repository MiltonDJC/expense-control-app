import 'package:expense_control_app/features/money_pockets/domain/entities/money_pocket_entity.dart';

abstract class MoneyPocketRepository {
  Future<List<MoneyPocketEntity>> getAllMoneyPockets();

  Future<void> updateMoneyPocket({required int id});

  Future<void> deleteMoneyPocket({required int id});
}
