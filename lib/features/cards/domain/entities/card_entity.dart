import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';

class CardEntity {
  const CardEntity({
    required this.creditCardType,
    required this.bank,
    required this.dueDate,
    required this.closeDate,
  });

  final CreditCardType creditCardType;
  final Bank bank;
  final DateTime dueDate;
  final DateTime closeDate;
}
