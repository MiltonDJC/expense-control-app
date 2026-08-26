import 'package:drift/drift.dart';
import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:flutter/material.dart';

class Initialization {
  static Future<AppDatabase> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = AppDatabase();
    database
        .into(database.expense)
        .insert(
          const ExpenseCompanion(
            name: Value('Gasto de prueba 1'),
            payMethod: Value(PayMethod.cash),
            isFixed: Value(false),
          ),
        );
    database
        .into(database.expense)
        .insert(
          const ExpenseCompanion(
            name: Value('Gasto de prueba 2'),
            bank: Value(Bank.bancoComafi),
            payMethod: Value(PayMethod.creditCard),
            isFixed: Value(true),
          ),
        );
    return database;
  }
}
