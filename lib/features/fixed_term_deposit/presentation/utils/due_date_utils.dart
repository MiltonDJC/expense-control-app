import 'package:flutter/material.dart';

Color getDueDateColor(int daysBeforeDueDate) {
  return switch (daysBeforeDueDate) {
    == 0 => Colors.grey,
    <= 3 => Colors.red,
    <= 6 => Colors.deepOrangeAccent,
    _ => Colors.green,
  };
}

String getDueDateMessage(int days) {
  return switch (days) {
    == 1 => '$days día',
    _ => '$days días',
  };
}
