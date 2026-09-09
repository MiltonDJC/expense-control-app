import 'package:flutter/material.dart';

class FormDatePickerSection extends StatefulWidget {
  const FormDatePickerSection({
    super.key,
    required this.title,
    this.hintText,
    required this.datePicked,
    required this.validator,
  });

  final String title;
  final String? hintText;
  final Function(DateTime?) datePicked;

  // TODO: Revisar si cambiar el 'String?' de la función validator por DateTime?
  // * Relacionado con el archivo: lib\features\fixed_term_deposit\presentation\widgets\fixed_term_deposit_alert_dialog_form\fixed_term_deposit_alert_dialog_form_update_widget.dart

  final String? Function(String?)? validator;

  @override
  State<FormDatePickerSection> createState() => _FormDatePickerSectionState();
}

class _FormDatePickerSectionState extends State<FormDatePickerSection> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2026),
      lastDate: DateTime(2030),
      confirmText: 'Confirmar',
      cancelText: 'Cancelar',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.datePicked(selectedDate);
        _dateController.text =
            '${selectedDate!.day.toString().length > 1 ? '${selectedDate!.day}' : '0${selectedDate!.day}'}\\${selectedDate!.month.toString().length > 1 ? '${selectedDate!.month}' : '0${selectedDate!.month}'}\\${selectedDate!.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          onTap: _pickDate,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: widget.validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
