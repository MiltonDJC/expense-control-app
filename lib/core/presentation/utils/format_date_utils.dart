String formatDate(DateTime dateTime) {
  final day = dateTime.day.toString().length > 1
      ? '${dateTime.day}'
      : '0${dateTime.day}';
  final month = dateTime.month.toString().length > 1
      ? '${dateTime.month}'
      : '0${dateTime.month}';
  final year = dateTime.year;
  return '$day/$month/$year';
}
