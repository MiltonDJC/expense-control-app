import 'package:expense_control_app/features/balance/presentation/screens/balance_screen.dart';
import 'package:expense_control_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/screens/fixed_term_deposit_screen.dart';
import 'package:expense_control_app/features/money_pockets/presentation/screens/money_pockets_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final screens = <Widget>[
    const BalanceScreen(),
    const MoneyPocketsScreen(),
    const ExpensesScreen(),
    const FixedTermDepositScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: NavigationBar(
          shadowColor: Colors.black,
          elevation: 6,
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) =>
              setState(() => selectedIndex = value),
          indicatorColor: Theme.of(context).focusColor,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined, size: 28),
              selectedIcon: Icon(Icons.account_balance_wallet, size: 32),
              label: 'Balance',
              tooltip: 'Mi balance',
            ),
            NavigationDestination(
              icon: Icon(Icons.savings_outlined, size: 28),
              selectedIcon: Icon(Icons.savings, size: 32),
              label: 'Bolsillos',
              tooltip: 'Mis bolsillos',
            ),
            NavigationDestination(
              icon: Icon(Icons.money_off_csred_outlined, size: 28),
              selectedIcon: Icon(Icons.money_off_csred, size: 32),
              label: 'Gastos',
              tooltip: 'Mis gastos',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_outlined, size: 28),
              selectedIcon: Icon(Icons.account_balance, size: 32),
              label: 'Plazos Fijos',
              tooltip: 'Mis plazos fijos',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 24, right: 12),
        child: screens[selectedIndex],
      ),
    );
  }
}
