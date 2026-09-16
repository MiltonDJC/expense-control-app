// import 'package:drift/drift.dart';
import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/cards/data/models/card_model.dart';

class CardsLocalDataSource {
  CardsLocalDataSource({required this.appDatabase});

  final AppDatabase appDatabase;

  Future<List<CardModel>> getAllCards() async {
    try {
      final cardsRows = await appDatabase.managers.card.get();
      final cardsModels = cardsRows
          .map((cardRow) => CardModel.fromDrift(cardRow))
          .toList();
      return cardsModels;
    } catch (e) {
      throw Exception(
        'No se pudo obtener las tarjetas registradas en la base de datos.',
      );
    }
  }
}
