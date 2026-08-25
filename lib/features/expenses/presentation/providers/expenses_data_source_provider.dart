import 'package:expense_control_app/core/providers/database_provider.dart';
import 'package:expense_control_app/features/expenses/data/datasources/expenses_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'expenses_data_source_provider.g.dart';

@riverpod
ExpensesLocalDataSource expensesLocalDataSource(Ref ref) {
  return ExpensesLocalDataSource(appDatabase: ref.read(appDatabaseProvider));
}
