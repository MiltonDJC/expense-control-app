import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pockets_repository.dart';

class UpdateMoneyPocketUseCase {
  UpdateMoneyPocketUseCase({required this.moneyPocketRepository});

  final MoneyPocketsRepository moneyPocketRepository;

  Future<void> call({required int id, String? name, double? amount}) =>
      moneyPocketRepository.updateMoneyPocket(
        id: id,
        name: name,
        amount: amount,
      );
}
