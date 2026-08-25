import 'package:expense_control_app/features/expenses/data/repositories/expenses_repository_impl.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:expense_control_app/features/expenses/presentation/providers/expenses_data_source_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'expenses_repository_provider.g.dart';

@riverpod
ExpensesRepository expensesRepository(Ref ref) {
  final dataSource = ref.read(expensesLocalDataSourceProvider);
  return ExpensesRepositoryImpl(dataSource: dataSource);
}
