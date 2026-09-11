import 'package:expense_control_app/core/presentation/utils/format_date_utils.dart';
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
        _dateController.text = formatDate(selectedDate!);
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
