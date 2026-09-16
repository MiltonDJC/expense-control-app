import 'package:expense_control_app/features/cards/data/repositories/cards_repository_impl.dart';
import 'package:expense_control_app/features/cards/domain/repository/cards_repository.dart';
import 'package:expense_control_app/features/cards/presentation/providers/cards_local_data_source_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cards_repository_provider.g.dart';

@riverpod
CardsRepository cardsRepository(Ref ref) {
  final dataSource = ref.read(cardsLocalDataSourceProvider);
  return CardsRepositoryImpl(dataSource: dataSource);
}
