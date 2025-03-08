import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:swypex_task/core/errors/exceptions.dart';
import 'package:swypex_task/core/errors/failures.dart';
import 'package:swypex_task/features/exchange_rates/data/datasources/exchange_rates_remote_data_source.dart';
import 'package:swypex_task/features/exchange_rates/data/models/exchange_rates_model.dart';
import 'package:swypex_task/features/exchange_rates/data/repositories/exchange_rates_repository_impl.dart';
import 'package:swypex_task/features/exchange_rates/domain/entities/exchange_rates_entity.dart';

import 'exchange_rates_repository_impl_test.mocks.dart';

@GenerateMocks([ExchangeRatesRemoteDataSource])
void main() {
  late ExchangeRatesRepositoryImpl repository;
  late MockExchangeRatesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockExchangeRatesRemoteDataSource();
    repository =
        ExchangeRatesRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tStartDate = '2025-02-01';
  const tEndDate = '2025-03-08';
  const tSource = 'USD';

  final tExchangeRatesModel = ExchangeRatesModel(
    startDate: tStartDate,
    endDate: tEndDate,
    source: tSource,
    quotes: {
      "2025-02-01": {"USDEGP": 50.227262},
      "2025-02-02": {"USDEGP": 50.796625},
    },
  );

  final tExchangeRatesEntity = ExchangeRatesEntity(
    startDate: tStartDate,
    endDate: tEndDate,
    source: tSource,
    quotes: tExchangeRatesModel.quotes,
  );

  group('getExchangeRates', () {
    test(
        'Should return exchange rates when remote data source call is successful',
        () async {
      when(mockRemoteDataSource.getExchangeRates(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        source: anyNamed('source'),
      )).thenAnswer((_) async => tExchangeRatesModel);

      // Act
      final result = await repository.getExchangeRates(
        startDate: tStartDate,
        endDate: tEndDate,
        source: tSource,
      );

      // Assert
      expect(result, Right(tExchangeRatesEntity));
      verify(mockRemoteDataSource.getExchangeRates(
        startDate: tStartDate,
        endDate: tEndDate,
        source: tSource,
      ));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'Should return ApiFailure when remote data source throws an ApiException',
        () async {
      // Arrange
      const tApiException = ApiException(message: 'API error', statusCode: 500);
      when(mockRemoteDataSource.getExchangeRates(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        source: anyNamed('source'),
      )).thenThrow(tApiException);

      // Act
      final result = await repository.getExchangeRates(
        startDate: tStartDate,
        endDate: tEndDate,
        source: tSource,
      );

      // Assert
      expect(result, Left(ApiFailure(message: 'API error', statusCode: 500)));
    });
  });
}
