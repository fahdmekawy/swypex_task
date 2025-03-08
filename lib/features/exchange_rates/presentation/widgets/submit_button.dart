import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_task/core/theming/text_styles.dart';
import 'package:swypex_task/features/exchange_rates/presentation/cubit/exchange_rates_cubit.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () => context.read<ExchangeRatesCubit>().fetchExchangeRates(),
        child: Center(
          child: Text(
            'Submit',
            style: AppTextStyles.boldBlack18,
          ),
        ),
      ),
    );
  }
}
