import 'package:flutter/material.dart';

Color getDueDateColor(int daysBeforeDueDate) {
  return switch (daysBeforeDueDate) {
    <= 3 => Colors.red,
    <= 6 => Colors.deepOrangeAccent,
    _ => Colors.green,
  };
}
