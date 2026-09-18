import 'package:expense_control_app/features/cards/domain/repository/cards_repository.dart';

class DeleteCardUseCase {
  DeleteCardUseCase({required this.cardsRepository});

  final CardsRepository cardsRepository;

  Future<void> call({required int id}) => cardsRepository.deleteCard(id: id);
}
