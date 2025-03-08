import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/end_points.dart';
import '../models/exchange_rates_model.dart';

/// Abstract data source that defines the contract for fetching exchange rates remotely.
abstract class ExchangeRatesRemoteDataSource {
  Future<ExchangeRatesModel> getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  });
}

/// Implementation of [ExchangeRatesRemoteDataSource] that interacts with an API using Dio.
class ExchangeRatesRemoteDataSourceImpl
    implements ExchangeRatesRemoteDataSource {
  /// HTTP client for making API requests.
  final Dio dio;

  ExchangeRatesRemoteDataSourceImpl({required this.dio});

  @override
  Future<ExchangeRatesModel> getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getTimeframe,
        queryParameters: {
          'start_date': startDate,
          'end_date': endDate,
          'currencies': source,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200 && response.data['success'] == true) {
        return ExchangeRatesModel.fromJson(response.data);
      } else {
        throw ApiException(
          message: response.data['error']['type'] ?? 'Unknown error',
          statusCode: response.data['error']['code'] ?? 500,
        );
      }
    } on DioException catch (e) {
      throw ApiException(
          message: e.message ?? 'API request failed',
          statusCode: e.response?.statusCode ?? 500);
    }
  }
}
