import 'package:expense_control_app/core/providers/database_provider.dart';
import 'package:expense_control_app/features/cards/data/datasources/cards_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cards_local_data_source_provider.g.dart';

@riverpod
CardsLocalDataSource cardsLocalDataSource(Ref ref) {
  return CardsLocalDataSource(appDatabase: ref.read(appDatabaseProvider));
}
