import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pocket_repository.dart';

class DeleteMoneyPocketUseCase {
  DeleteMoneyPocketUseCase({required this.moneyPocketRepository});

  final MoneyPocketRepository moneyPocketRepository;

  Future<void> call({required int id}) =>
      moneyPocketRepository.deleteMoneyPocket(id: id);
}
