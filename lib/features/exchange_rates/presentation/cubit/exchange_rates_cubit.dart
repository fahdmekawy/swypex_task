import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/exchange_rates_entity.dart';
import '../../domain/usecases/get_exchange_rates.dart';
import 'exchange_rates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This class handles fetching exchange rates by communicating with the [GetExchangeRates] use case
class ExchangeRatesCubit extends Cubit<ExchangeRatesState> {
  final GetExchangeRates getExchangeRates;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  String fromCurrency = '';
  String toCurrency = '';

  ExchangeRatesCubit({required this.getExchangeRates})
      : super(ExchangeRatesInitial());

  /// Fetches exchange rates based on user input.
  Future<void> fetchExchangeRates() async {
    emit(ExchangeRatesLoading());

    final Either<Failure, ExchangeRatesEntity> result = await getExchangeRates(
      ExchangeRatesParams(
        startDate: startDateController.text,
        endDate: endDateController.text,
        source: '$fromCurrency,$toCurrency',
      ),
    );

    result.fold(
      (failure) => emit(ExchangeRatesError(failure.message)),
      (exchangeRates) => emit(ExchangeRatesLoaded(exchangeRates)),
    );
  }
}
