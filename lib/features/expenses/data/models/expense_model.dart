import 'package:expense_control_app/features/expenses/data/tables/expense.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'expense_model.freezed.dart';

@freezed
abstract class ExpenseModel with _$ExpenseModel {
  const ExpenseModel._();

  const factory ExpenseModel({
    required int id,
    required String name,
    required PayMethod payMethod,
    required bool isFixed,
  }) = _ExpenseModel;

  factory ExpenseModel.fromDrift(Expense expenseRow) => ExpenseModel(
    id: expenseRow.id as int,
    name: expenseRow.name as String,
    payMethod: expenseRow.payMethod as PayMethod,
    isFixed: expenseRow.isFixed as bool,
  );

  factory ExpenseModel.fromEntity(ExpenseEntity entity) => ExpenseModel(
    id: entity.id,
    name: entity.name,
    payMethod: entity.payMethod,
    isFixed: entity.isFixed,
  );

  ExpenseEntity toEntity() =>
      ExpenseEntity(id: id, name: name, payMethod: payMethod, isFixed: isFixed);
}
