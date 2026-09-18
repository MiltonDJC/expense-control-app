import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'card_model.freezed.dart';

@freezed
abstract class CardModel with _$CardModel {
  const CardModel._();

  const factory CardModel({
    required int id,
    required CreditCardType creditCardType,
    required Bank bank,
    required DateTime dueDate,
    required DateTime closeDate,
  }) = _CardModel;

  factory CardModel.fromDrift(CardData cardRow) => CardModel(
    id: cardRow.id,
    creditCardType: cardRow.creditCardType,
    bank: cardRow.bank,
    dueDate: cardRow.dueDate,
    closeDate: cardRow.closeDate,
  );

  factory CardModel.fromEntity(CardEntity entity) => CardModel(
    id: entity.id,
    creditCardType: entity.creditCardType,
    bank: entity.bank,
    dueDate: entity.dueDate,
    closeDate: entity.closeDate,
  );

  CardEntity toEntity() => CardEntity(
    id: id,
    creditCardType: creditCardType,
    bank: bank,
    dueDate: dueDate,
    closeDate: closeDate,
  );
}
