import 'package:expense_control_app/app.dart';
import 'package:expense_control_app/config/initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  Initialization.init();
  runApp(const ProviderScope(child: App()));
}
