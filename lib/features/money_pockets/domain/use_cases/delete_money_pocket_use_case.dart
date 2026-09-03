import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pockets_repository.dart';

class DeleteMoneyPocketUseCase {
  DeleteMoneyPocketUseCase({required this.moneyPocketRepository});

  final MoneyPocketsRepository moneyPocketRepository;

  Future<void> call({required int id}) =>
      moneyPocketRepository.deleteMoneyPocket(id: id);
}
