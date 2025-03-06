import 'package:flutter/material.dart';
import 'currency_selector.dart';

class CurrenciesSelectorsWidget extends StatelessWidget {
  const CurrenciesSelectorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CurrencySelector(),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CurrencySelector(),
        ),
      ],
    );
  }
}
