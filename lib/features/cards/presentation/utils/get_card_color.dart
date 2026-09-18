import 'package:expense_control_app/domain/enums/bank.dart';
import 'package:flutter/material.dart';

Color getCardColor(Bank bank) {
  return switch (bank) {
    Bank.bancoMacro => const Color(0xff2041EE),
    Bank.bancoProvincia => const Color.fromARGB(255, 170, 169, 169),
    Bank.bancoNacion => const Color(0xff005A7F),
    Bank.bancoComafi => const Color(0xff7B9040),
  };
}
