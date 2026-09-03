import 'package:expense_control_app/features/money_pockets/domain/entities/money_pocket_entity.dart';
import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pocket_repository.dart';

class GetAllMoneyPocketsUseCase {
  GetAllMoneyPocketsUseCase({required this.moneyPocketRepository});

  final MoneyPocketRepository moneyPocketRepository;

  Future<List<MoneyPocketEntity>> call() =>
      moneyPocketRepository.getAllMoneyPockets();
}
