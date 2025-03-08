import 'package:dartz/dartz.dart';
import 'package:swypex_task/core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/typedef.dart';
import '../../domain/entities/exchange_rates_entity.dart';
import '../../domain/repositories/exchange_rates_repository.dart';
import '../datasources/exchange_rates_remote_data_source.dart';
import '../models/exchange_rates_model.dart';

/// Implementation of [ExchangeRatesRepository] that handles fetching exchange rates from a remote data source.
class ExchangeRatesRepositoryImpl implements ExchangeRatesRepository {
  final ExchangeRatesRemoteDataSource remoteDataSource;

  ExchangeRatesRepositoryImpl({required this.remoteDataSource});

  @override
  FutureEitherExchangeRates getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  }) async {
    try {
      final ExchangeRatesModel result = await remoteDataSource.getExchangeRates(
        startDate: startDate,
        endDate: endDate,
        source: source,
      );

      final ExchangeRatesEntity entity = ExchangeRatesEntity(
        startDate: result.startDate,
        endDate: result.endDate,
        source: result.source,
        quotes: Map<String, dynamic>.from(result.quotes),
      );

      /// Return the successful result wrapped in a `Right` (indicating success).
      return Right(entity);
    } on ApiException catch (e) {
      /// If an API exception occurs, return a `Left` containing an `ApiFailure`.
      return Left(
        ApiFailure(
          statusCode: e.statusCode,
          message: e.message,
        ),
      );
    }
  }
}
