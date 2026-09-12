import 'package:expense_control_app/features/balance/presentation/screens/balance_screen.dart';
import 'package:expense_control_app/features/cards/presentation/screens/cards_screen.dart';
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
    const CardsScreen(),
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
              icon: Icon(Icons.account_balance_wallet_outlined, size: 26),
              selectedIcon: Icon(
                Icons.account_balance_wallet,
                color: Colors.black,
                size: 30,
              ),
              label: 'Balance',
              tooltip: 'Mi balance',
            ),
            NavigationDestination(
              icon: Icon(Icons.savings_outlined, size: 26),
              selectedIcon: Icon(Icons.savings, color: Colors.black, size: 30),
              label: 'Bolsillos',
              tooltip: 'Mis bolsillos',
            ),
            NavigationDestination(
              icon: Icon(Icons.money_off_csred_outlined, size: 26),
              selectedIcon: Icon(
                Icons.money_off_csred,
                color: Colors.black,
                size: 30,
              ),
              label: 'Gastos',
              tooltip: 'Mis gastos',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_outlined, size: 26),
              selectedIcon: Icon(
                Icons.account_balance,
                color: Colors.black,
                size: 30,
              ),
              label: 'Plazos Fijos',
              tooltip: 'Mis plazos fijos',
            ),
            NavigationDestination(
              icon: Icon(Icons.credit_card_outlined, size: 26),
              selectedIcon: Icon(
                Icons.credit_card,
                color: Colors.black,
                size: 30,
              ),
              label: 'Tarjetas',
              tooltip: 'Mis tarjetas',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 4, right: 12),
        child: screens[selectedIndex],
      ),
    );
  }
}
