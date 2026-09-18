import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/presentation/providers/cards_use_cases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cards_notifier.freezed.dart';
part 'cards_notifier.g.dart';

@freezed
abstract class CardsState with _$CardsState {
  const factory CardsState({@Default([]) List<CardEntity> cards}) =
      _ExpensesState;
}

@riverpod
class CardsNotifier extends _$CardsNotifier {
  @override
  Future<CardsState> build() async {
    final cards = await ref.read(getAllCardsUseCaseProvider)();
    return CardsState(cards: cards);
  }

  Future<void> addCreditCard({
    required CreditCardType creditCardType,
    required Bank bank,
    required DateTime dueDate,
    required DateTime closeDate,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(addCreditCardUseCaseProvider)(
        creditCardType: creditCardType,
        bank: bank,
        duedate: dueDate,
        closeDate: closeDate,
      );
      final cards = await ref.read(getAllCardsUseCaseProvider)();
      return CardsState(cards: cards);
    });
  }

  Future<void> deleteCard({required int id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(deleteCardUseCaseProvider)(id: id);
      final cards = await ref.read(getAllCardsUseCaseProvider)();
      return CardsState(cards: cards);
    });
  }
}
