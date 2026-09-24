import 'package:expense_control_app/core/presentation/extensions/string_formatter.dart';
import 'package:expense_control_app/core/presentation/widgets/app_circular_progress_indicator.dart';
import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:expense_control_app/features/expenses/domain/enums/pay_method.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/bank_utils.dart';
import 'package:expense_control_app/features/expenses/presentation/utils/pay_method_utils.dart';
import 'package:expense_control_app/core/presentation/utils/format_date_utils.dart';
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
    required this.createdDate,
  });

  final String expenseName;
  final double amount;
  final Bank? bankName;
  final bool isFixed;
  final PayMethod payMethod;
  final int? moneyPocketId;
  final DateTime createdDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 14,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expenseName.capitalize,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                if (isFixed)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      'Gasto Fijo',
                      style: Theme.of(context).primaryTextTheme.titleLarge,
                    ),
                  ),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.payments),
                    ),
                    Text(
                      'Monto pagado: \$$amount',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.paid),
                    ),
                    Text(
                      'Pagado con: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      getPayMethodName(payMethod.name),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (bankName != null)
                      Text(
                        ' (${getBankName(bankName!.name)})',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.calendar_month),
                    ),
                    Text(
                      'Fecha realizado: ${formatDate(createdDate)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Todo: Is necessary use FutureBuilder to get it's moneyPocket? Review it
                    FutureBuilder(
                      future: ref.read(getAllMoneyPocketsUseCaseProvider)(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: AppCircularProgressIndicator(),
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
                          return Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.savings),
                              ),
                              Text(
                                'Bolsillo utilizado: ${moneyPocketName.capitalize}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
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
