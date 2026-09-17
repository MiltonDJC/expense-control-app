import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/domain/repository/cards_repository.dart';

class AddCreditCardUseCase {
  AddCreditCardUseCase({required this.cardsRepository});

  final CardsRepository cardsRepository;

  Future<void> call({
    required CreditCardType creditCardType,
    required Bank bank,
    required DateTime duedate,
    required DateTime closeDate,
  }) => cardsRepository.addCreditCard(
    creditCardType: creditCardType,
    bank: bank,
    dueDate: duedate,
    closeDate: closeDate,
  );
}
