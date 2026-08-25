import 'package:expense_control_app/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase appDatabase(Ref ref) => AppDatabase();
