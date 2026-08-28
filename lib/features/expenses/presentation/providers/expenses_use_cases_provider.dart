import 'package:expense_control_app/features/expenses/domain/use_cases/add_expense_use_case.dart';
import 'package:expense_control_app/features/expenses/domain/use_cases/delete_expense_use_case.dart';
import 'package:expense_control_app/features/expenses/domain/use_cases/get_all_expenses_use_case.dart';
import 'package:expense_control_app/features/expenses/domain/use_cases/update_expense_use_case.dart';
import 'package:expense_control_app/features/expenses/presentation/providers/expenses_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'expenses_use_cases_provider.g.dart';

@riverpod
GetAllExpensesUseCase getAllExpensesUseCase(Ref ref) {
  final repository = ref.read(expensesRepositoryProvider);
  return GetAllExpensesUseCase(expensesRepository: repository);
}

@riverpod
DeleteExpenseUseCase deleteExpenseUseCase(Ref ref) {
  final repository = ref.read(expensesRepositoryProvider);
  return DeleteExpenseUseCase(expensesRepository: repository);
}

@riverpod
UpdateExpenseUseCase updateExpenseUseCase(Ref ref) {
  final repository = ref.read(expensesRepositoryProvider);
  return UpdateExpenseUseCase(expensesRepository: repository);
}

@riverpod
AddExpenseUseCase addExpenseUseCase(Ref ref) {
  final respository = ref.read(expensesRepositoryProvider);
  return AddExpenseUseCase(expensesRepository: respository);
}
