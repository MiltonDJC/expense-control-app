import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/entities/fixed_term_deposit_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'fixed_term_deposit_model.freezed.dart';

@freezed
abstract class FixedTermDepositModel with _$FixedTermDepositModel {
  const FixedTermDepositModel._();

  const factory FixedTermDepositModel({
    required int id,
    required double depositAmount,
    required double depositAmountReceived,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  }) = _FixedTermDepositModel;

  factory FixedTermDepositModel.fromDrift(
    FixedTermDepositData fixedTermDepositRow,
  ) => FixedTermDepositModel(
    id: fixedTermDepositRow.id,
    depositAmount: fixedTermDepositRow.depositAmount,
    depositAmountReceived: fixedTermDepositRow.depositAmountReceived,
    depositDate: fixedTermDepositRow.depositDate,
    depositDueDate: fixedTermDepositRow.depositDueDate,
    dolarPrice: fixedTermDepositRow.dolarPrice,
    name: fixedTermDepositRow.name,
  );

  factory FixedTermDepositModel.fromEntity(FixedTermDepositEntity entity) =>
      FixedTermDepositModel(
        id: entity.id,
        depositAmount: entity.depositAmount,
        depositAmountReceived: entity.depositAmountReceived,
        depositDate: entity.depositDate,
        depositDueDate: entity.depositDueDate,
        dolarPrice: entity.dolarPrice,
        name: entity.name,
      );

  FixedTermDepositEntity toEntity() => FixedTermDepositEntity(
    id: id,
    depositAmount: depositAmount,
    depositAmountReceived: depositAmountReceived,
    depositDate: depositDate,
    depositDueDate: depositDueDate,
    dolarPrice: dolarPrice,
    name: name,
  );
}
