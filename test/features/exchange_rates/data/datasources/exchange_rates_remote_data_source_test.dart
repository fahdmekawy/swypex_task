import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:swypex_task/core/errors/exceptions.dart';
import 'package:swypex_task/core/networking/end_points.dart';
import 'package:swypex_task/features/exchange_rates/data/datasources/exchange_rates_remote_data_source.dart';
import 'package:swypex_task/features/exchange_rates/data/models/exchange_rates_model.dart';

import 'exchange_rates_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ExchangeRatesRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() async {
    mockDio = MockDio();
    dataSource = ExchangeRatesRemoteDataSourceImpl(dio: mockDio);
    await dotenv.load(fileName: ".env");
  });

  const tStartDate = '2025-02-01';
  const tEndDate = '2025-03-08';
  const tSource = 'USD';

  final tResponseData = {
    "success": true,
    "timeframe": true,
    "start_date": tStartDate,
    "end_date": tEndDate,
    "source": tSource,
    "quotes": {
      "2025-02-01": {"USDEGP": 50.227262},
      "2025-02-02": {"USDEGP": 50.796625},
    }
  };

  final tExchangeRatesModel = ExchangeRatesModel.fromJson(tResponseData);

  group('getExchangeRates', () {
    test('Should return ExchangeRatesModel when API call is successful',
        () async {
      // Arrange
      when(mockDio.get(
        EndPoints.getTimeframe,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: EndPoints.getTimeframe),
          ));

      // Act
      final result = await dataSource.getExchangeRates(
        startDate: tStartDate,
        endDate: tEndDate,
        source: tSource,
      );

      // Assert
      expect(result, tExchangeRatesModel);
      verify(mockDio.get(
        EndPoints.getTimeframe,
        queryParameters: {
          'start_date': tStartDate,
          'end_date': tEndDate,
          'currencies': tSource,
        },
      ));
      verifyNoMoreInteractions(mockDio);
    });

    test('Should throw ApiException when API call fails with an error response',
        () async {
      // Arrange
      when(mockDio.get(
        EndPoints.getTimeframe,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {
              "error": {"code": 500, "type": "Server Error"}
            },
            statusCode: 500,
            requestOptions: RequestOptions(path: EndPoints.getTimeframe),
          ));

      // Act
      final call = dataSource.getExchangeRates;

      // Assert
      expect(
        () => call(startDate: tStartDate, endDate: tEndDate, source: tSource),
        throwsA(isA<ApiException>()),
      );
    });

    test('Should throw ApiException when Dio throws an error', () async {
      // Arrange
      when(mockDio.get(
        EndPoints.getTimeframe,
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: EndPoints.getTimeframe),
        type: DioExceptionType.connectionError,
      ));

      // Act
      final call = dataSource.getExchangeRates;

      // Assert
      expect(
        () => call(startDate: tStartDate, endDate: tEndDate, source: tSource),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
