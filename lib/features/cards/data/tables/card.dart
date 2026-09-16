import 'package:drift/drift.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';

class Card extends Table {
  late final id = integer().autoIncrement()();
  late final cardName = text()();
  late final creditCardType = intEnum<CreditCardType>()();
  late final bank = intEnum<Bank>()();
  late final dueDate = dateTime()();
  late final closeDate = dateTime()();
}
