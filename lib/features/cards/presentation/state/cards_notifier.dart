import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
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
  // Others methods
}
