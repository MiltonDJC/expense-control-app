import 'package:drift/drift.dart';

class MoneyPocket extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final amount = real()();
}
