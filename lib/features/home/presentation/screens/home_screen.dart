import 'package:expense_control_app/features/balance/presentation/screens/balance_screen.dart';
import 'package:expense_control_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/screens/fixed_term_deposit_screen.dart';
import 'package:expense_control_app/features/fixed_term_deposit/presentation/state/fixed_term_deposit_notifier.dart';
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
    const Center(child: Text('Money Pockets Screen')),
    const ExpensesScreen(),
    const FixedTermDepositScreen(),
    // MoneyPockets(),
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
          indicatorColor: Colors.transparent,
          indicatorShape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(.circular(10)),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet),
              label: 'Balance',
              tooltip: 'Mi balance',
            ),
            NavigationDestination(
              icon: Icon(Icons.savings_outlined),
              selectedIcon: Icon(Icons.savings),
              label: 'Bolsillos',
              tooltip: 'Mis bolsillos',
            ),
            NavigationDestination(
              icon: Icon(Icons.money_off_csred_outlined),
              selectedIcon: Icon(Icons.money_off_csred),
              label: 'Gastos',
              tooltip: 'Mis gastos',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_outlined),
              selectedIcon: Icon(Icons.account_balance),
              label: 'Plazos Fijos',
              tooltip: 'Mis plazos fijos',
            ),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
