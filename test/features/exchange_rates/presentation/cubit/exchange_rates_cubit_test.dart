import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:swypex_task/core/errors/failures.dart';
import 'package:swypex_task/features/exchange_rates/domain/entities/exchange_rates_entity.dart';
import 'package:swypex_task/features/exchange_rates/domain/usecases/get_exchange_rates.dart';
import 'package:swypex_task/features/exchange_rates/presentation/cubit/exchange_rates_cubit.dart';
import 'package:swypex_task/features/exchange_rates/presentation/cubit/exchange_rates_state.dart';

import 'exchange_rates_cubit_test.mocks.dart';

@GenerateMocks([GetExchangeRates])
void main() {
  late ExchangeRatesCubit cubit;
  late MockGetExchangeRates mockGetExchangeRates;

  setUp(() {
    mockGetExchangeRates = MockGetExchangeRates();
    cubit = ExchangeRatesCubit(getExchangeRates: mockGetExchangeRates);
  });

  const tStartDate = '2025-02-01';
  const tEndDate = '2025-03-08';
  const tFromCurrency = 'USD';
  const tToCurrency = 'EGP';

  final tExchangeRatesEntity = ExchangeRatesEntity(
    startDate: tStartDate,
    endDate: tEndDate,
    source: '$tFromCurrency,$tToCurrency',
    quotes: {
      "2025-02-01": {"USDEGP": 50.227262},
      "2025-02-02": {"USDEGP": 50.796625},
    },
  );

  group('fetchExchangeRates', () {
    test('Initial state should be ExchangeRatesInitial', () {
      expect(cubit.state, ExchangeRatesInitial());
    });

    blocTest<ExchangeRatesCubit, ExchangeRatesState>(
      'Should emit [ExchangeRatesLoading, ExchangeRatesLoaded] when data is retrieved successfully',
      build: () {
        when(mockGetExchangeRates(any))
            .thenAnswer((_) async => Right(tExchangeRatesEntity));
        return cubit;
      },
      act: (cubit) {
        cubit.startDateController.text = tStartDate;
        cubit.endDateController.text = tEndDate;
        cubit.fromCurrency = tFromCurrency;
        cubit.toCurrency = tToCurrency;
        return cubit.fetchExchangeRates();
      },
      expect: () => [
        ExchangeRatesLoading(),
        ExchangeRatesLoaded(tExchangeRatesEntity),
      ],
    );

    blocTest<ExchangeRatesCubit, ExchangeRatesState>(
      'Should emit [ExchangeRatesLoading, ExchangeRatesError] when an API failure occurs',
      build: () {
        when(mockGetExchangeRates(any)).thenAnswer((_) async =>
            Left(ApiFailure(message: 'API Error', statusCode: 500)));
        return cubit;
      },
      act: (cubit) {
        cubit.startDateController.text = tStartDate;
        cubit.endDateController.text = tEndDate;
        cubit.fromCurrency = tFromCurrency;
        cubit.toCurrency = tToCurrency;
        return cubit.fetchExchangeRates();
      },
      expect: () => [
        ExchangeRatesLoading(),
        ExchangeRatesError('API Error'),
      ],
    );
  });
}
