import 'package:expense_control_app/features/expenses/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/bank_utils.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/pay_method_utils.dart';
import 'package:expense_control_app/features/money_pockets/presentation/providers/money_pockets_use_cases_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseInformationWidget extends ConsumerWidget {
  const new({
    super.key,
    required this.expenseName,
    required this.amount,
    this.bankName,
    required this.isFixed,
    required this.payMethod,
    this.moneyPocketId,
  });

  final String expenseName;
  final double amount;
  final Bank? bankName;
  final bool isFixed;
  final PayMethod payMethod;
  final int? moneyPocketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 28,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expenseName,
                  style: const TextStyle(fontSize: 28, fontWeight: .w600),
                ),
                if (isFixed)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text(
                      'Gasto Fijo',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Column(
              spacing: 16,
              children: [
                Row(
                  children: [
                    Text(
                      'Monto pagado: \$$amount',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Pagado con: ', style: TextStyle(fontSize: 24)),
                    Text(
                      getPayMethodName(payMethod.name),
                      style: const TextStyle(fontSize: 24),
                    ),
                    if (bankName != null)
                      Text(
                        ' (${getBankName(bankName!.name)})',
                        style: const TextStyle(fontSize: 24),
                      ),
                  ],
                ),
                Row(
                  children: [
                    FutureBuilder(
                      future: ref.read(getAllMoneyPocketsUseCaseProvider)(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }

                        if (snapshot.hasData && moneyPocketId != null) {
                          final moneyPocketName = snapshot.requireData
                              .firstWhere(
                                (moneyPocket) =>
                                    moneyPocket.id == moneyPocketId,
                              )
                              .name;
                          return Text(
                            'Bolsillo utilizado: "$moneyPocketName"',
                            style: const TextStyle(fontSize: 24),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
