class FixedTermDepositEntity {
  FixedTermDepositEntity({
    required this.id,
    required this.depositAmount,
    required this.depositAmountReceived,
    required this.depositDate,
    required this.depositDueDate,
    required this.dolarPrice,
    required this.name,
  });

  final int id;
  final double depositAmount;
  final double depositAmountReceived;
  final DateTime depositDate;
  final DateTime depositDueDate;
  final double dolarPrice;
  final String name;
}
