String formatCreditCardDate(DateTime dateTime) {
  final month = dateTime.month.toString().padLeft(2, '0');
  final year = dateTime.year.toString().substring(2);
  return '$month/$year';
}
