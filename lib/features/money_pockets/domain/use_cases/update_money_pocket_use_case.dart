import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pocket_repository.dart';

class UpdateMoneyPocketUseCase {
  UpdateMoneyPocketUseCase({required this.moneyPocketRepository});

  final MoneyPocketRepository moneyPocketRepository;

  Future<void> call({required int id, String? name, double? amount}) =>
      moneyPocketRepository.updateMoneyPocket(
        id: id,
        name: name,
        amount: amount,
      );
}
