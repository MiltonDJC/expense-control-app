import 'package:expense_control_app/features/balance/presentation/screens/balance_screen.dart';
import 'package:expense_control_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:expense_control_app/features/home/presentation/widgets/home_navigator_side_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = <Widget>[
    const BalanceScreen(),
    const Center(child: Text('Money Pockets Screen')),
    const ExpensesScreen(),
    const Center(child: Text('Fixed Term Deposit Screen')),
    // FixedTermDeposit(),
    // MoneyPockets(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          HomeNavigatorSideBar(
            onChanged: (newSelectedIndex) =>
                setState(() => selectedIndex = newSelectedIndex),
          ),
          const VerticalDivider(),
          Expanded(child: screens[selectedIndex]),
        ],
      ),
    );
  }
}
