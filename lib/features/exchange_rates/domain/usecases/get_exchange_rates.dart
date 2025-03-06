import 'package:dartz/dartz.dart';
import 'package:swypex_task/core/usecase/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/exchange_rates_entity.dart';
import '../repositories/exchange_rates_repository.dart';

class GetExchangeRates
    extends UseCaseWithParams<ExchangeRatesEntity, ExchangeRatesParams> {
  final ExchangeRatesRepository repository;

  GetExchangeRates(this.repository);

  @override
  Future<Either<Failure, ExchangeRatesEntity>> call(
      ExchangeRatesParams params) {
    return repository.getExchangeRates(
      startDate: params.startDate,
      endDate: params.endDate,
      source: params.source,
    );
  }
}

class ExchangeRatesParams {
  final String startDate;
  final String endDate;
  final String source;

  ExchangeRatesParams({
    required this.startDate,
    required this.endDate,
    required this.source,
  });
}
