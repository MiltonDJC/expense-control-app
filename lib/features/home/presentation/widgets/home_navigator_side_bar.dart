import 'package:flutter/material.dart';

class HomeNavigatorSideBar extends StatelessWidget {
  const new({super.key, required this.onChanged});

  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HomeNavigatorButton(
                  onPressed: () => onChanged(0),
                  labelText: 'Balance',
                  icon: Icons.account_balance_wallet,
                ),
                _HomeNavigatorButton(
                  onPressed: () => onChanged(1),
                  labelText: 'Bolsillos',
                  icon: Icons.savings,
                ),
                _HomeNavigatorButton(
                  onPressed: () => onChanged(2),
                  labelText: 'Gastos',
                  icon: Icons.money_off_csred,
                ),
                _HomeNavigatorButton(
                  onPressed: () => onChanged(3),
                  labelText: 'Plazos Fijos',
                  icon: Icons.account_balance,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeNavigatorButton extends StatelessWidget {
  const new({
    required this.labelText,
    required this.icon,
    required this.onPressed,
  });

  final String labelText;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: TextButton.icon(
        onPressed: onPressed,
        label: Text(
          '  $labelText',
          style: const TextStyle(fontSize: 24, color: Color(0xFF2F3776)),
        ),
        icon: Icon(icon, size: 24, color: const Color(0xFF2F3776)),
      ),
    );
  }
}
