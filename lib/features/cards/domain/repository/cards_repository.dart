import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';

abstract class CardsRepository {
  List<CardEntity> getAllCards();
  void addCreditCard(
    String cardName,
    CreditCardType creditCardType,
    Bank bank,
    DateTime dueDate,
    DateTime closeDate,
  );
  void updateCard({
    required int id,
    String? cardName,
    CreditCardType? creditCardType,
    Bank? bank,
    DateTime? dueDate,
    DateTime? closeDate,
  });
  void deleteCard({required int id});
}
