import 'package:expense_control_app/features/fixed_term_deposit/data/repositories/fixed_term_deposit_repository_impl.dart';
import 'package:expense_control_app/features/fixed_term_deposit/domain/repositories/fixed_term_deposit_repository.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/providers/fixed_term_deposit_data_source_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fixed_term_deposit_repository_provider.g.dart';

@riverpod
FixedTermDepositRepository fixedTermDepositRepository(Ref ref) {
  final dataSource = ref.read(fixedTermDepositLocalDataSourceProvider);
  return FixedTermDepositRepositoryImpl(dataSource: dataSource);
}
