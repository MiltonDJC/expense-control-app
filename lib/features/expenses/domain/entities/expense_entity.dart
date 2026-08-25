import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';

class ExpenseEntity {
  ExpenseEntity({
    required this.id,
    required this.name,
    required this.payMethod,
    this.bank,
    required this.isFixed,
  });

  final int id;
  final String name;
  final PayMethod payMethod;
  final Bank? bank;
  final bool isFixed;
}
