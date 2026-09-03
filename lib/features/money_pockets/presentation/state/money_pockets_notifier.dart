import 'package:expense_control_app/features/money_pockets/domain/entities/money_pocket_entity.dart';
import 'package:expense_control_app/features/money_pockets/presentation/providers/money_pockets_use_cases_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'money_pockets_notifier.freezed.dart';
part 'money_pockets_notifier.g.dart';

@freezed
abstract class MoneyPocketsState with _$MoneyPocketsState {
  const factory MoneyPocketsState({
    @Default([]) List<MoneyPocketEntity> moneyPockets,
  }) = _MoneyPocketsState;
}

@riverpod
class MoneyPocketsNotifier extends _$MoneyPocketsNotifier {
  @override
  Future<MoneyPocketsState> build() async {
    final moneyPockets = await ref.read(getAllMoneyPocketsUseCaseProvider)();
    return MoneyPocketsState(moneyPockets: moneyPockets);
  }

  Future<void> addMoneyPocket({
    required String name,
    required double amount,
  }) async {
    await ref.read(addMoneyPocketUseCaseProvider)(name: name, amount: amount);
  }

  Future<void> updateMoneyPocket({
    required int id,
    String? name,
    double? amount,
  }) async {
    await ref.read(updateMoneyPocketUseCaseProvider)(
      id: id,
      name: name,
      amount: amount,
    );
  }

  Future<void> deleteMoneyPocket({required int id}) async {
    await ref.read(deleteMoneyPocketUseCaseProvider)(id: id);
  }
}
