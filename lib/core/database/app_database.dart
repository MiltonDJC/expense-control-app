import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:expense_control_app/features/cards/data/tables/card.dart';
import 'package:expense_control_app/features/expenses/data/tables/expense.dart';
import 'package:expense_control_app/features/fixed_term_deposit/data/table/fixed_term_deposit.dart';
import 'package:expense_control_app/features/money_pockets/data/table/money_pocket.dart';
import 'package:path_provider/path_provider.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Expense, FixedTermDeposit, MoneyPocket, Card])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
