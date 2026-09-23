import 'package:expense_control_app/core/presentation/utils/app_snack_bar.dart';
import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/app_alert_dialog.dart';
import 'package:expense_control_app/core/presentation/widgets/app_circular_progress_indicator.dart';
import 'package:expense_control_app/core/presentation/widgets/custom_floating_action_button.dart';
import 'package:expense_control_app/features/expenses/presentation/state/expenses_notifier.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_add_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_alert_dialog_form/expense_alert_dialog_form_update_widget.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpensesScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);

    return Stack(
      children: [
        expenses.when(
          data: (state) => state.expenses.isEmpty
              ? const Center(
                  child: Text('No hay gastos registrados por el momento...'),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 72),
                  child: ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Slidable(
                          key: Key(state.expenses[index].id.toString()),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.2,
                            children: [
                              CustomSlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                onPressed: (context) async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ExpenseAlertDialogFormUpdateWidget(
                                        id: state.expenses[index].id,
                                        expenseName: state.expenses[index].name,
                                        amount: state.expenses[index].amount,
                                        bankName: state.expenses[index].bank,
                                        isFixed: state.expenses[index].isFixed,
                                        payMethod:
                                            state.expenses[index].payMethod,
                                      );
                                    },
                                    barrierDismissible: false,
                                    animationStyle: const AnimationStyle(
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 250),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(height: 4),
                                    Text('Editar'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.2,
                            children: [
                              CustomSlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                onPressed: (context) async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AppAlertDialog(
                                        title: '¿Segura quiere eliminar este gasto?',
                                        actions: [
                                          ActionButtonWidget(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            text: 'Cancelar',
                                          ),
                                          ActionButtonWidget(
                                            onPressed: () async {
                                              await ref
                                                  .read(
                                                    expensesProvider.notifier,
                                                  )
                                                  .deleteExpense(
                                                    id: state
                                                        .expenses[index]
                                                        .id,
                                                  );
                                              ref.invalidate(expensesProvider);
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                              if (context.mounted) {
                                                AppSnackBar.show(
                                                  context,
                                                  'Gasto eliminado con éxito.',
                                                );
                                              }
                                            },
                                            text: 'Confirmar',
                                          ),
                                        ],
                                      );
                                    },
                                    barrierDismissible: false,
                                    animationStyle: const AnimationStyle(
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 250),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(height: 4),
                                    Text('Eliminar'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          child: ExpenseInformationWidget(
                            expenseName: state.expenses[index].name,
                            amount: state.expenses[index].amount,
                            bankName: state.expenses[index].bank,
                            isFixed: state.expenses[index].isFixed,
                            payMethod: state.expenses[index].payMethod,
                            moneyPocketId: state.expenses[index].moneyPocketId,
                            createdDate: state.expenses[index].createdDate,
                          ),
                        ),
                      );
                    },
                  ),
                ),
          error: (error, stackTrace) =>
              Center(child: Text('Ha ocurrido un error: ${error.toString()}')),
          loading: () => const Center(child: AppCircularProgressIndicator()),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: CustomFloatingActionButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const ExpenseAlertDialogFormAddWidget();
                  },
                  barrierDismissible: false,
                  animationStyle: const AnimationStyle(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 250),
                  ),
                );
              },
              tooltip: 'Agregar nuevo gasto',
              title: 'Agregar gasto',
              icon: Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
