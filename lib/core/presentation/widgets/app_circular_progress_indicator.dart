import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeCap: StrokeCap.round,
      strokeWidth: 4,
    );
  }
}
