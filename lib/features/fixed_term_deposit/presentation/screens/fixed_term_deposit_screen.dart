import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/widgets/fixed_term_deposit_widget.dart';
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
            : ListView.builder(
                itemCount: state.fixedTermDeposits.length,
                itemBuilder: (BuildContext context, int index) {
                  return FixedTermDepositWidget(
                    id: state.fixedTermDeposits[index].id,
                    fixedTermDepositName: state.fixedTermDeposits[index].name,
                    depositAmount: state.fixedTermDeposits[index].depositAmount,
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
        error: (error, stackTrace) =>
            Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
