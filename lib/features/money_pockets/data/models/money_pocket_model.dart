import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/money_pockets/domain/entities/money_pocket_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'money_pocket_model.freezed.dart';

@freezed
abstract class MoneyPocketModel with _$MoneyPocketModel {
  const MoneyPocketModel._();

  const factory MoneyPocketModel({
    required int id,
    required String name,
    required double amount,
  }) = _MoneyPocketModel;

  factory MoneyPocketModel.fromDrift(MoneyPocketData moneyPocketRow) =>
      MoneyPocketModel(
        id: moneyPocketRow.id,
        name: moneyPocketRow.name,
        amount: moneyPocketRow.amount,
      );

  factory MoneyPocketModel.fromEntity(MoneyPocketEntity entity) =>
      MoneyPocketModel(id: entity.id, name: entity.name, amount: entity.amount);

  MoneyPocketEntity toEntity() =>
      MoneyPocketEntity(id: id, name: name, amount: amount);
}
