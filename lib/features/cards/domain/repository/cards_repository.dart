import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';

abstract class CardsRepository {
  Future<List<CardEntity>> getAllCards();
  Future<void> addCreditCard(
    CreditCardType creditCardType,
    Bank bank,
    DateTime dueDate,
    DateTime closeDate,
  );
  Future<void> updateCard({
    required int id,
    CreditCardType? creditCardType,
    Bank? bank,
    DateTime? dueDate,
    DateTime? closeDate,
  });
  Future<void> deleteCard({required int id});
}
