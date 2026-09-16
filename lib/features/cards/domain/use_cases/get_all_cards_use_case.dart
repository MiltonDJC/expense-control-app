import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
import 'package:expense_control_app/features/cards/domain/repository/cards_repository.dart';

class GetAllCardsUseCase {
  GetAllCardsUseCase({required this.cardsRepository});

  final CardsRepository cardsRepository;

  Future<List<CardEntity>> call() => cardsRepository.getAllCards();
}
