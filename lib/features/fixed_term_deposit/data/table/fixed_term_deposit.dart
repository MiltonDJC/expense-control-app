import 'package:drift/drift.dart';

class FixedTermDeposit extends Table {
  late final id = integer().autoIncrement()();
  late final depositAmount = real()();
  late final depositAmountReceived = real()();
  late final depositDate = dateTime()();
  late final depositDueDate = dateTime()();
  late final dolarPrice = real()();
  late final name = text()();
}
