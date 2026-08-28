import 'package:drift/drift.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';

class Expense extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final amount = real()();
  late final payMethod = intEnum<PayMethod>()();
  late final bank = intEnum<Bank>().nullable()();
  late final isFixed = boolean()();
}
