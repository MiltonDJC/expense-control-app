import 'package:expense_control_app/app.dart';
import 'package:expense_control_app/config/initialization.dart';
import 'package:expense_control_app/core/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  final appDatabase = await Initialization.init();

  runApp(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(appDatabase)],
      child: const App(),
    ),
  );
}
