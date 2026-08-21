import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';

class ExpenseEntity {
  ExpenseEntity({
    required this.id,
    required this.name,
    required this.payMethod,
    required this.isFixed,
  });

  final int id;
  final String name;
  final PayMethod payMethod;
  final bool isFixed;
}
