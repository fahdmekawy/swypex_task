import 'package:dartz/dartz.dart';
import '../../features/exchange_rates/domain/entities/exchange_rates_entity.dart';
import '../errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

typedef ExchangeRatesMap = Map<String, dynamic>;

typedef FutureEitherExchangeRates
    = Future<Either<Failure, ExchangeRatesEntity>>;
