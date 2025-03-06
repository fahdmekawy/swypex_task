import 'package:flutter/material.dart';
import 'package:swypex_task/features/exchange_rates/presentation/widgets/currencies_selectors_widget.dart';
import 'package:swypex_task/features/exchange_rates/presentation/widgets/dates_widget.dart';
import '../widgets/exchange_rates_table.dart';
import '../widgets/next_and_previous_buttons.dart';
import '../widgets/submit_button.dart';

class ExchangeRatesScreen extends StatefulWidget {
  const ExchangeRatesScreen({super.key});

  @override
  State<ExchangeRatesScreen> createState() => _ExchangeRatesScreenState();
}

class _ExchangeRatesScreenState extends State<ExchangeRatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          DatesWidget(),
                          const SizedBox(height: 8),
                          CurrenciesSelectorsWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: SubmitButton(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ExchangeRatesTable(),
              const SizedBox(height: 50),
              NextAndPreviousButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
