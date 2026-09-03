import 'package:expense_control_app/features/money_pockets/domain/use_cases/add_money_pocket_use_case.dart';
import 'package:expense_control_app/features/money_pockets/domain/use_cases/delete_money_pocket_use_case.dart';
import 'package:expense_control_app/features/money_pockets/domain/use_cases/get_all_money_pockets_use_case.dart';
import 'package:expense_control_app/features/money_pockets/domain/use_cases/update_money_pocket_use_case.dart';
import 'package:expense_control_app/features/money_pockets/presentation/providers/money_pockets_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'money_pockets_use_cases_provider.g.dart';

@riverpod
GetAllMoneyPocketsUseCase getAllMoneyPocketsUseCase(Ref ref) {
  final repository = ref.read(moneyPocketsRepositoryProvider);
  return GetAllMoneyPocketsUseCase(moneyPocketRepository: repository);
}

@riverpod
AddMoneyPocketUseCase addMoneyPocketUseCase(Ref ref) {
  final repository = ref.read(moneyPocketsRepositoryProvider);
  return AddMoneyPocketUseCase(moneyPocketRepository: repository);
}

@riverpod
UpdateMoneyPocketUseCase updateMoneyPocketUseCase(Ref ref) {
  final repository = ref.read(moneyPocketsRepositoryProvider);
  return UpdateMoneyPocketUseCase(moneyPocketRepository: repository);
}

@riverpod
DeleteMoneyPocketUseCase deleteMoneyPocketUseCase(Ref ref) {
  final repository = ref.read(moneyPocketsRepositoryProvider);
  return DeleteMoneyPocketUseCase(moneyPocketRepository: repository);
}
