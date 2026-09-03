import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pockets_repository.dart';

class AddMoneyPocketUseCase {
  AddMoneyPocketUseCase({required this.moneyPocketRepository});

  final MoneyPocketsRepository moneyPocketRepository;

  Future<void> call({required String name, required double amount}) =>
      moneyPocketRepository.addMoneyPocket(name: name, amount: amount);
}
