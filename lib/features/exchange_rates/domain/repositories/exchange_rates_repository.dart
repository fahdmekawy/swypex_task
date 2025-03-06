import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/exchange_rates_entity.dart';

abstract class ExchangeRatesRepository {
  Future<Either<Failure, ExchangeRatesEntity>> getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  });
}
