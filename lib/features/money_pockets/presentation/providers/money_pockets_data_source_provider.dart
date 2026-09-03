import 'package:expense_control_app/core/providers/database_provider.dart';
import 'package:expense_control_app/features/money_pockets/data/datasources/money_pockets_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'money_pockets_data_source_provider.g.dart';

@riverpod
MoneyPocketsLocalDataSource moneyPocketLocalDataSource(Ref ref) {
  return MoneyPocketsLocalDataSource(
    appDatabase: ref.read(appDatabaseProvider),
  );
}
