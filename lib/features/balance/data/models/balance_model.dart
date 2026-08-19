import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_model.freezed.dart';

@freezed
abstract class BalanceModel with _$BalanceModel {
  const factory BalanceModel({required double amount}) = _BalanceModel;
}
