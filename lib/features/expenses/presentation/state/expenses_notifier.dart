import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_control_app/features/expenses/presentation/providers/expenses_use_cases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expenses_notifier.freezed.dart';
part 'expenses_notifier.g.dart';

@freezed
abstract class ExpensesState with _$ExpensesState {
  const factory ExpensesState({
    required List<ExpenseEntity> expenses,
    required bool isLoading,
    String? errorMessage,
  }) = _ExpensesState;
}

@riverpod
class ExpensesNotifier extends _$ExpensesNotifier {
  @override
  Future<ExpensesState> build() async {
    final expenses = await ref.read(getAllExpensesUseCaseProvider)();
    return ExpensesState(
      expenses: expenses,
      isLoading: false,
      errorMessage: null,
    );
  }
}
