import 'package:dartz/dartz.dart';
import 'package:swypex_task/core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/exchange_rates_entity.dart';
import '../../domain/repositories/exchange_rates_repository.dart';
import '../datasources/exchange_rates_remote_data_source.dart';

class ExchangeRatesRepositoryImpl implements ExchangeRatesRepository {
  final ExchangeRatesRemoteDataSource remoteDataSource;

  ExchangeRatesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ExchangeRatesEntity>> getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  }) async {
    try {
      final remoteData = await remoteDataSource.getExchangeRates(
        startDate: startDate,
        endDate: endDate,
        source: source,
      );

      return Right(remoteData);
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    }
  }
}
