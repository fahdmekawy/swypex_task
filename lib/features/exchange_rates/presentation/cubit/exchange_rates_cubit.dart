import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/exchange_rates_entity.dart';
import '../../domain/usecases/get_exchange_rates.dart';
import 'exchange_rates_state.dart';
import 'package:bloc/bloc.dart';

class ExchangeRatesCubit extends Cubit<ExchangeRatesState> {
  final GetExchangeRates getExchangeRates;

  ExchangeRatesCubit({required this.getExchangeRates})
      : super(ExchangeRatesInitial());

  Future<void> fetchExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  }) async {
    emit(ExchangeRatesLoading());

    final Either<Failure, ExchangeRatesEntity> result = await getExchangeRates(
      ExchangeRatesParams(
          startDate: startDate, endDate: endDate, source: source),
    );

    result.fold(
      (failure) => emit(ExchangeRatesError(failure.message)),
      (exchangeRates) => emit(ExchangeRatesLoaded(exchangeRates)),
    );
  }
}
