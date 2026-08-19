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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Balance',
          ),
          NavigationDestination(icon: Icon(Icons.savings), label: 'Bolsillos'),
          NavigationDestination(icon: Icon(Icons.money_off), label: 'Gastos'),
          NavigationDestination(
            icon: Icon(Icons.account_balance),
            label: 'Plazos Fijos',
          ),
        ],
      ),
    );
  }
}
