import 'package:expense_control_app/features/fixed_term_deposit/domain/use_cases/add_fixed_term_deposit_use_case.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/use_cases/delete_fixed_term_deposit_use_case.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/use_cases/get_all_fixed_term_deposit_use_case.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/use_cases/update_fixed_term_deposit_use_case.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/providers/fixed_term_deposit_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fixed_term_deposit_use_cases_provider.g.dart';

@riverpod
AddFixedTermDepositUseCase addFixedTermDepositUseCase(Ref ref) {
  final repository = ref.read(fixedTermDepositRepositoryProvider);
  return AddFixedTermDepositUseCase(fixedTermDepositRepository: repository);
}

@riverpod
UpdateFixedTermDepositUseCase updateFixedTermDepositUseCase(Ref ref) {
  final repository = ref.read(fixedTermDepositRepositoryProvider);
  return UpdateFixedTermDepositUseCase(fixedTermDepositRepository: repository);
}

@riverpod
DeleteFixedTermDepositUseCase deleteFixedTermDepositUseCase(Ref ref) {
  final repository = ref.read(fixedTermDepositRepositoryProvider);
  return DeleteFixedTermDepositUseCase(fixedTermDepositRepository: repository);
}

@riverpod
GetAllFixedTermDepositsUseCase getAllFixedTermDepositsUseCase(Ref ref) {
  final repository = ref.read(fixedTermDepositRepositoryProvider);
  return GetAllFixedTermDepositsUseCase(fixedTermDepositRepository: repository);
}
