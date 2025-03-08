import 'package:equatable/equatable.dart';
import 'package:swypex_task/core/usecase/usecase.dart';
import '../../../../core/helpers/typedef.dart';
import '../entities/exchange_rates_entity.dart';
import '../repositories/exchange_rates_repository.dart';

/// A use case that retrieves exchange rates from the repository.
class GetExchangeRates
    extends UseCaseWithParams<ExchangeRatesEntity, ExchangeRatesParams> {
  final ExchangeRatesRepository repository;

  GetExchangeRates(this.repository);

  @override
  FutureEitherExchangeRates call(ExchangeRatesParams params) {
    return repository.getExchangeRates(
      startDate: params.startDate,
      endDate: params.endDate,
      source: params.source,
    );
  }
}

class ExchangeRatesParams extends Equatable {
  final String startDate;
  final String endDate;
  final String source;

  const ExchangeRatesParams({
    required this.startDate,
    required this.endDate,
    required this.source,
  });

  @override
  List<Object?> get props => [startDate, endDate, source];
}
