import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/cards/data/datasources/cards_local_data_source.dart';
import 'package:expense_control_app/features/cards/domain/entities/card_entity.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/domain/repository/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  CardsRepositoryImpl({required this.dataSource});

  final CardsLocalDataSource dataSource;

  @override
  Future<List<CardEntity>> getAllCards() async {
    final cardsModels = await dataSource.getAllCards();
    return cardsModels.map((cardModel) => cardModel.toEntity()).toList();
  }

  @override
  Future<void> addCreditCard(
    String cardName,
    CreditCardType creditCardType,
    Bank bank,
    DateTime dueDate,
    DateTime closeDate,
  ) {
    // TODO: implement addCreditCard
    throw UnimplementedError();
  }

  @override
  Future<void> updateCard({
    required int id,
    String? cardName,
    CreditCardType? creditCardType,
    Bank? bank,
    DateTime? dueDate,
    DateTime? closeDate,
  }) {
    // TODO: implement updateCard
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCard({required int id}) {
    // TODO: implement deleteCard
    throw UnimplementedError();
  }
}
