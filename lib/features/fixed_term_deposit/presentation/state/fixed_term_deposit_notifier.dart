import 'package:expense_control_app/features/fixed_term_deposit/domain/entities/fixed_term_deposit_entity.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/providers/fixed_term_deposit_use_cases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'fixed_term_deposit_notifier.freezed.dart';
part 'fixed_term_deposit_notifier.g.dart';

@freezed
abstract class FixedTermDepositState with _$FixedTermDepositState {
  const factory FixedTermDepositState({
    @Default([]) List<FixedTermDepositEntity> fixedTermDeposits,
  }) = _FixedTermDepositState;
}

@riverpod
class FixedTermDepositNotifier extends _$FixedTermDepositNotifier {
  @override
  Future<FixedTermDepositState> build() async {
    final fixedTermDeposits = await ref.read(
      getAllFixedTermDepositsUseCaseProvider,
    )();
    return FixedTermDepositState(fixedTermDeposits: fixedTermDeposits);
  }

  Future<void> addFixedTermDeposit({
    required double depositAmount,
    required double depositAmountReceived,
    required DateTime depositDate,
    required DateTime depositDueDate,
    required double dolarPrice,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(addFixedTermDepositUseCaseProvider)(
        depositAmount: depositAmount,
        depositAmountReceived: depositAmountReceived,
        depositDate: depositDate,
        depositDueDate: depositDueDate,
        dolarPrice: dolarPrice,
        name: name,
      );
      final fixedTermDeposits = await ref.read(
        getAllFixedTermDepositsUseCaseProvider,
      )();
      return FixedTermDepositState(fixedTermDeposits: fixedTermDeposits);
    });
  }

  Future<void> updateFixedTermDeposit({
    required int id,
    double? depositAmount,
    double? depositAmountReceived,
    DateTime? depositDate,
    DateTime? depositDueDate,
    double? dolarPrice,
    String? name,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(updateFixedTermDepositUseCaseProvider)(
        id: id,
        depositAmount: depositAmount,
        depositAmountReceived: depositAmountReceived,
        depositDate: depositDate,
        depositDueDate: depositDueDate,
        dolarPrice: dolarPrice,
        name: name,
      );
      final fixedTermDeposits = await ref.read(
        getAllFixedTermDepositsUseCaseProvider,
      )();
      return FixedTermDepositState(fixedTermDeposits: fixedTermDeposits);
    });
  }

  Future<void> deleteFixedTermDeposit({required int id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(deleteFixedTermDepositUseCaseProvider)(id: id);
      final fixedTermDeposits = await ref.read(
        getAllFixedTermDepositsUseCaseProvider,
      )();
      return FixedTermDepositState(fixedTermDeposits: fixedTermDeposits);
    });
  }
}
