import 'package:expense_control_app/features/money_pockets/data/repositories/money_pockets_repository_impl.dart';
import 'package:expense_control_app/features/money_pockets/domain/repositories/money_pockets_repository.dart';
import 'package:expense_control_app/features/money_pockets/presentation/providers/money_pockets_data_source_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'money_pockets_repository_provider.g.dart';

@riverpod
MoneyPocketsRepository moneyPocketsRepository(Ref ref) {
  final dataSource = ref.read(moneyPocketLocalDataSourceProvider);
  return MoneyPocketsRepositoryImpl(dataSource: dataSource);
}
