import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/domain/repository/cards_repository.dart';

class UpdateCardUseCase {
  UpdateCardUseCase({required this.cardsRepository});

  final CardsRepository cardsRepository;

  Future<void> call({
    required int id,
    CreditCardType? creditCardType,
    Bank? bank,
    DateTime? dueDate,
    DateTime? closeDate,
  }) => cardsRepository.updateCard(
    id: id,
    creditCardType: creditCardType,
    bank: bank,
    dueDate: dueDate,
    closeDate: closeDate,
  );
}
