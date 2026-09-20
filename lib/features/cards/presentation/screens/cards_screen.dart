import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/app_circular_progress_indicator.dart';
import 'package:expense_control_app/core/presentation/widgets/custom_floating_action_button.dart';
import 'package:expense_control_app/features/cards/presentation/state/cards_notifier.dart';
import 'package:expense_control_app/features/cards/presentation/utils/get_card_color.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/card_alert_dialog_form_add.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/card_alert_dialog_form_update.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardsScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsProvider);

    return Stack(
      children: [
        cards.when(
          data: (state) => state.cards.isEmpty
              ? const Center(
                  child: Text(
                    'No hay tarjetas registradas por el momento...',
                    style: TextStyle(fontSize: 26),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 72, top: 18),
                  child: Center(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.6,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 12,
                          ),
                      itemCount: state.cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Builder(
                          builder: (BuildContext innerContext) {
                            return InkWell(
                              onLongPress: () async {
                                final RenderBox renderBox =
                                    innerContext.findRenderObject()
                                        as RenderBox;
                                final size = renderBox.size;
                                final position = renderBox.localToGlobal(
                                  Offset.zero,
                                );

                                final centerX =
                                    position.dx + (size.width / 2.5);
                                final centerY =
                                    position.dy + (size.height / 2.5);

                                await showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    centerX,
                                    centerY,
                                    centerX,
                                    centerY,
                                  ),
                                  items: [
                                    const PopupMenuItem(
                                      child: Icon(Icons.arrow_back),
                                    ),
                                    PopupMenuItem(
                                      child: const Text('Editar'),
                                      onTap: () async => await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CardAlertDialogFormUpdate(
                                              id: state.cards[index].id,
                                              creditCardType: state
                                                  .cards[index]
                                                  .creditCardType,
                                              bank: state.cards[index].bank,
                                              dueDate:
                                                  state.cards[index].dueDate,
                                              closeDate:
                                                  state.cards[index].closeDate,
                                            ),
                                        barrierDismissible: false,
                                        animationStyle: const AnimationStyle(
                                          curve: Curves.easeInOut,
                                          duration: Duration(milliseconds: 250),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onTap: () async => await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: const SizedBox(
                                            width: 288,
                                            height: 100,
                                            child: Center(
                                              child: Text(
                                                '¿Segura quiere eliminar la tarjeta?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ActionButtonWidget(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              text: 'Cancelar',
                                            ),
                                            ActionButtonWidget(
                                              onPressed: () async {
                                                await ref
                                                    .read(
                                                      cardsProvider.notifier,
                                                    )
                                                    .deleteCard(
                                                      id: state.cards[index].id,
                                                    );
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              text: 'Confirmar',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              child: CreditCardWidget(
                                creditCardType:
                                    state.cards[index].creditCardType,
                                bank: state.cards[index].bank,
                                dueDate: state.cards[index].dueDate,
                                closeDate: state.cards[index].closeDate,
                                cardColor: getCardColor(
                                  state.cards[index].bank,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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
              title: 'Agregar tarjeta',
              tooltip: 'Agregar nueva tarjeta',
              icon: Icons.add,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const CardAlertDialogFormAdd();
                  },
                  barrierDismissible: false,
                  animationStyle: const AnimationStyle(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 250),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
