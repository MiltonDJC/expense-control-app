import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';

class ExpenseEntity {
  ExpenseEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.payMethod,
    this.bank,
    required this.isFixed,
    this.moneyPocketId,
    required this.createdDate,
  });

  final int id;
  final String name;
  final double amount;
  final PayMethod payMethod;
  final Bank? bank;
  final bool isFixed;
  final int? moneyPocketId;
  final DateTime createdDate;
}
