import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:swypex_task/core/errors/failures.dart';
import 'package:swypex_task/features/exchange_rates/domain/entities/exchange_rates_entity.dart';
import 'package:swypex_task/features/exchange_rates/domain/repositories/exchange_rates_repository.dart';
import 'package:swypex_task/features/exchange_rates/domain/usecases/get_exchange_rates.dart';

import 'get_exchange_rates_test.mocks.dart';

@GenerateMocks([ExchangeRatesRepository])
void main() {
  late GetExchangeRates useCase;
  late MockExchangeRatesRepository mockRepository;

  setUp(() {
    mockRepository = MockExchangeRatesRepository();
    useCase = GetExchangeRates(mockRepository);
  });

  const tParams = ExchangeRatesParams(
    startDate: '2025-02-01',
    endDate: '2025-03-08',
    source: 'USD',
  );

  final tExchangeRatesEntity = ExchangeRatesEntity(
    startDate: '2025-02-01',
    endDate: '2025-03-08',
    source: 'USD',
    quotes: {
      "2025-02-01": {"USDEGP": 50.227262},
      "2025-02-02": {"USDEGP": 50.796625},
    },
  );

  test('Should call the repository and return exchange rates', () async {
    // Arrange
    when(mockRepository.getExchangeRates(
      startDate: anyNamed('startDate'),
      endDate: anyNamed('endDate'),
      source: anyNamed('source'),
    )).thenAnswer((_) async => Right(tExchangeRatesEntity));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, Right(tExchangeRatesEntity));
    verify(mockRepository.getExchangeRates(
      startDate: '2025-02-01',
      endDate: '2025-03-08',
      source: 'USD',
    ));
    verifyNoMoreInteractions(mockRepository);
  });

  test('Should return ApiFailure when repository call fails', () async {
    // Arrange
    const tFailure = ApiFailure(message: 'API error', statusCode: 500);

    when(mockRepository.getExchangeRates(
      startDate: anyNamed('startDate'),
      endDate: anyNamed('endDate'),
      source: anyNamed('source'),
    )).thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, Left(tFailure));
  });
}
