import 'package:expense_control_app/core/presentation/widgets/action_button_widget.dart';
import 'package:expense_control_app/core/presentation/widgets/form_date_picker_section.dart';
import 'package:expense_control_app/features/cards/domain/enums/credit_card_type.dart';
import 'package:expense_control_app/features/cards/presentation/state/cards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardAlertDialogFormAdd extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<CardAlertDialogFormAdd> createState() =>
      _CardAlertDialogFormAddState();
}

class _CardAlertDialogFormAddState
    extends ConsumerState<CardAlertDialogFormAdd> {
  late TextEditingController cardNameController;

  @override
  void initState() {
    super.initState();
    cardNameController = TextEditingController();
  }

  @override
  void dispose() {
    cardNameController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? dueDate;
  DateTime? closeDate;

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(cardsProvider);

    return cards.when(
      data: (state) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Registrar tarjeta',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tarjeta',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  FormDatePickerSection(
                    title: 'Fecha de cierre',
                    hintText: 'Seleccione una fecha',
                    datePicked: (dateSelected) {
                      closeDate = dateSelected;
                    },
                    validator: null,
                  ),
                  FormDatePickerSection(
                    title: 'Fecha de vencimiento',
                    hintText: 'Seleccione una fecha',
                    datePicked: (dateSelected) {
                      dueDate = dateSelected;
                    },
                    validator: null,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          ActionButtonWidget(
            onPressed: () => Navigator.pop(context),
            text: 'Cancelar',
          ),
          ActionButtonWidget(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (context.mounted) Navigator.pop(context);
              }
            },
            text: 'Confirmar',
          ),
        ],
      ),
      error: (error, stackTrace) =>
          Center(child: Text('Hubo un error: ${error.toString()}')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
