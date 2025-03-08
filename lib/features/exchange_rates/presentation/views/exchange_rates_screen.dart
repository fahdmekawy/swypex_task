import 'package:flutter/material.dart';
import 'package:swypex_task/features/exchange_rates/presentation/widgets/currencies_selectors_widget.dart';
import 'package:swypex_task/features/exchange_rates/presentation/widgets/dates_widget.dart';

import '../widgets/exchange_rates_table.dart';
import '../widgets/submit_button.dart';

class ExchangeRatesScreen extends StatelessWidget {
  const ExchangeRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: ListView(
            children: const [
              /// This container contains Dates selection, Currencies selection and Submit button
              _TopControlsSection(),
              SizedBox(height: 20),

              /// This container contains the exchange rates table, Error message and Loading indicator
              ExchangeRatesTable(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopControlsSection extends StatelessWidget {
  const _TopControlsSection();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: const [
                DatesWidget(),
                SizedBox(height: 8),
                CurrenciesSelectorsWidget(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SubmitButton(),
            ),
          ),
        ],
      ),
    );
  }
}
