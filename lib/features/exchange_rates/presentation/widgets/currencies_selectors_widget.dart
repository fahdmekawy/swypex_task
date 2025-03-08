import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_task/features/exchange_rates/presentation/cubit/exchange_rates_cubit.dart';
import 'currency_selector.dart';

class CurrenciesSelectorsWidget extends StatefulWidget {
  const CurrenciesSelectorsWidget({super.key});

  @override
  State<CurrenciesSelectorsWidget> createState() =>
      _CurrenciesSelectorsWidgetState();
}

class _CurrenciesSelectorsWidgetState extends State<CurrenciesSelectorsWidget> {
  @override
  Widget build(BuildContext context) {
    var exchangeCubit = context.read<ExchangeRatesCubit>();
    return Row(
      children: [
        Expanded(
          child: CurrencySelector(
            selectedCurrency: exchangeCubit.fromCurrency,
            placeHolder: 'From',
            onCurrencyChanged: (string) {
              setState(() {
                exchangeCubit.fromCurrency = string;
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CurrencySelector(
            selectedCurrency: exchangeCubit.toCurrency,
            placeHolder: 'To',
            onCurrencyChanged: (string) {
              setState(() {
                exchangeCubit.toCurrency = string;
              });
            },
          ),
        ),
      ],
    );
  }
}
