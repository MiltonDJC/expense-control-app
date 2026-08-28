import 'package:expense_control_app/core/database/app_database.dart';
import 'package:flutter/material.dart';

class Initialization {
  static Future<AppDatabase> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = AppDatabase();
    return database;
  }
}
