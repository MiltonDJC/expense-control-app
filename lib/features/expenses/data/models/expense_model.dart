import 'package:expense_control_app/core/database/app_database.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'expense_model.freezed.dart';

@freezed
abstract class ExpenseModel with _$ExpenseModel {
  const ExpenseModel._();

  const factory ExpenseModel({
    required int id,
    required String name,
    required double amount,
    required PayMethod payMethod,
    Bank? bank,
    required bool isFixed,
  }) = _ExpenseModel;

  factory ExpenseModel.fromDrift(ExpenseData expenseRow) => ExpenseModel(
    id: expenseRow.id,
    name: expenseRow.name,
    amount: expenseRow.amount,
    payMethod: expenseRow.payMethod,
    bank: expenseRow.bank,
    isFixed: expenseRow.isFixed,
  );

  factory ExpenseModel.fromEntity(ExpenseEntity entity) => ExpenseModel(
    id: entity.id,
    name: entity.name,
    amount: entity.amount,
    payMethod: entity.payMethod,
    bank: entity.bank,
    isFixed: entity.isFixed,
  );

  ExpenseEntity toEntity() => ExpenseEntity(
    id: id,
    name: name,
    amount: amount,
    payMethod: payMethod,
    bank: bank,
    isFixed: isFixed,
  );
}
