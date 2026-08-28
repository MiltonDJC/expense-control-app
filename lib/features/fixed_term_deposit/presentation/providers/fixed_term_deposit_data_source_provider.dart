import 'package:expense_control_app/core/providers/database_provider.dart';
import 'package:expense_control_app/features/fixed_term_deposit/data/datasources/fixed_term_deposit_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fixed_term_deposit_data_source_provider.g.dart';

@riverpod
FixedTermDepositLocalDataSource fixedTermDepositLocalDataSource(Ref ref) {
  return FixedTermDepositLocalDataSource(
    appDatabase: ref.read(appDatabaseProvider),
  );
}
