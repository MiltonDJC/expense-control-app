import 'package:drift/drift.dart';

class FixedTermDeposit extends Table {
  late final id = integer().autoIncrement()();
  late final depositAmount = real()();
  late final depositDate = dateTime()();
  late final dueDepositDate = dateTime()();
  late final dolarPrice = real()();
  late final name = text()();
}
