import 'package:expense_control_app/features/cards/domain/use_cases/add_credit_card_use_case.dart';
import 'package:expense_control_app/features/cards/domain/use_cases/delete_card_use_case.dart';
import 'package:expense_control_app/features/cards/domain/use_cases/get_all_cards_use_case.dart';
import 'package:expense_control_app/features/cards/domain/use_cases/update_card_use_case.dart';
import 'package:expense_control_app/features/cards/presentation/providers/cards_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cards_use_cases_provider.g.dart';

@riverpod
GetAllCardsUseCase getAllCardsUseCase(Ref ref) {
  final repository = ref.read(cardsRepositoryProvider);
  return GetAllCardsUseCase(cardsRepository: repository);
}

@riverpod
AddCreditCardUseCase addCreditCardUseCase(Ref ref) {
  final repository = ref.read(cardsRepositoryProvider);
  return AddCreditCardUseCase(cardsRepository: repository);
}

@riverpod
DeleteCardUseCase deleteCardUseCase(Ref ref) {
  final repository = ref.read(cardsRepositoryProvider);
  return DeleteCardUseCase(cardsRepository: repository);
}

@riverpod
UpdateCardUseCase updateCardUseCase(Ref ref) {
  final repository = ref.read(cardsRepositoryProvider);
  return UpdateCardUseCase(cardsRepository: repository);
}
