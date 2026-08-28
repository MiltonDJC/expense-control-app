import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixedTermDepositScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixedTermDeposits = ref.watch(fixedTermDepositProvider);

    return Scaffold(
      body: fixedTermDeposits.when(
        data: (state) => state.fixedTermDeposits.isEmpty
            ? const Center(
                child: Text(
                  'No hay plazos fijos registrados por el momento...',
                  style: TextStyle(fontSize: 26),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ListView.builder(
                  itemCount: state.fixedTermDeposits.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FixedTermDepositCard(
                      id: state.fixedTermDeposits[index].id,
                      fixedTermDepositName: state.fixedTermDeposits[index].name,
                      depositAmount:
                          state.fixedTermDeposits[index].depositAmount,
                      depositDate: state.fixedTermDeposits[index].depositDate,
                      depositDueDate:
                          state.fixedTermDeposits[index].depositDueDate,
                      dolarPrice: state.fixedTermDeposits[index].dolarPrice,
                      onDeleted: () async {
                        await ref
                            .read(fixedTermDepositProvider.notifier)
                            .deleteFixedTermDeposit(
                              id: state.fixedTermDeposits[index].id,
                            );
                        ref.invalidate(fixedTermDepositProvider);
                      },
                      onEdited: () {},
                    );
                  },
                ),
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref
              .read(fixedTermDepositProvider.notifier)
              .addFixedTermDeposit(
                depositAmount: 50.0,
                depositDate: DateTime(2030, 1, 10),
                depositDueDate: DateTime(2030, 2, 12),
                dolarPrice: 10.0,
                name: 'Deposito agregado',
              );
          ref.invalidate(fixedTermDepositProvider);
        },
        tooltip: 'Agregar nuevo gasto',
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
