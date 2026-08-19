import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = <Widget>[
    const Center(child: Text('Balance Screen')),
    const Center(child: Text('Expenses Screen')),
    const Center(child: Text('Fixed Term Deposit Screen')),
    const Center(child: Text('Money Pockets Screen')),
    // ExpensesScreen(),
    // FixedTermDeposit(),
    // MoneyPockets(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Text('titulo')),
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() => selectedIndex = value),
        destinations: [
          NavigationDestination(
            icon: Icon(
              selectedIndex == 0
                  ? Icons.account_balance_wallet
                  : Icons.account_balance_wallet_outlined,
            ),
            label: 'Balance',
          ),
          NavigationDestination(
            icon: Icon(
              selectedIndex == 1 ? Icons.savings : Icons.savings_outlined,
            ),
            label: 'Bolsillos',
          ),
          NavigationDestination(
            icon: Icon(
              selectedIndex == 2 ? Icons.money_off : Icons.money_off_outlined,
            ),
            label: 'Gastos',
          ),
          NavigationDestination(
            icon: Icon(
              selectedIndex == 3
                  ? Icons.account_balance
                  : Icons.account_balance_outlined,
            ),
            label: 'Plazos Fijos',
          ),
        ],
      ),
    );
  }
}
