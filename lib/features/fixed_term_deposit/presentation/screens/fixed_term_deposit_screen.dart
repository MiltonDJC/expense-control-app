import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            : ListView.builder(
                itemCount: state.fixedTermDeposits.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: Key(state.fixedTermDeposits[index].id.toString()),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await ref
                                .read(fixedTermDepositProvider.notifier)
                                .updateFixedTermDeposit(
                                  id: state.fixedTermDeposits[index].id,
                                  depositAmount: 6,
                                  depositAmountReceived: 100,
                                  depositDate: DateTime(2000, 1, 1),
                                  depositDueDate: DateTime(2000, 1, 6),
                                  dolarPrice: 1.0,
                                  name: 'Depósito actualizado',
                                );
                            ref.invalidate(fixedTermDepositProvider);
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Editar',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await ref
                                .read(fixedTermDepositProvider.notifier)
                                .deleteFixedTermDeposit(
                                  id: state.fixedTermDeposits[index].id,
                                );
                            ref.invalidate(fixedTermDepositProvider);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Eliminar',
                        ),
                      ],
                    ),
                    child: FixedTermDepositCard(
                      id: state.fixedTermDeposits[index].id,
                      fixedTermDepositName: state.fixedTermDeposits[index].name,
                      depositAmount:
                          state.fixedTermDeposits[index].depositAmount,
                      depositAmountReceived:
                          state.fixedTermDeposits[index].depositAmountReceived,
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
                      onEdited: () async {
                        await ref
                            .read(fixedTermDepositProvider.notifier)
                            .updateFixedTermDeposit(
                              id: state.fixedTermDeposits[index].id,
                              depositAmount: 6,
                              depositAmountReceived: 100,
                              depositDate: DateTime(2000, 1, 1),
                              depositDueDate: DateTime(2000, 1, 6),
                              dolarPrice: 1.0,
                              name: 'Depósito actualizado',
                            );
                        ref.invalidate(fixedTermDepositProvider);
                      },
                    ),
                  );
                },
              ),
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () async {
                await ref
                    .read(fixedTermDepositProvider.notifier)
                    .addFixedTermDeposit(
                      depositAmount: 6,
                      depositAmountReceived: 100,
                      depositDate: DateTime(2000, 1, 1),
                      depositDueDate: DateTime(2000, 1, 30),
                      dolarPrice: 1.0,
                      name: 'Depósito actualizado',
                    );
                ref.invalidate(fixedTermDepositProvider);
              },
              label: const Row(
                children: [
                  Icon(Icons.add, size: 26, fontWeight: FontWeight.w600),
                  SizedBox(width: 6),
                  Text(
                    'Agregar plazo fijo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      persistentFooterDecoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black)),
      ),
    );
  }
}
