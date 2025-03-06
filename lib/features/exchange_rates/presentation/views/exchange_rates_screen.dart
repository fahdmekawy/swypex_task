import 'package:flutter/material.dart';
import 'package:swypex_task/features/exchange_rates/presentation/widgets/currencies_selectors_widget.dart';
import 'package:swypex_task/features/exchange_rates/presentation/widgets/dates_widget.dart';
import '../widgets/exchange_rates_table.dart';
import '../widgets/next_and_previous_buttons.dart';
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
              _TopControlsSection(),
              SizedBox(height: 20),
              ExchangeRatesTable(),
              SizedBox(height: 32),
              NextAndPreviousButtons(),
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
