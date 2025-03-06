import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/end_points.dart';
import '../models/exchange_rates_model.dart';

abstract class ExchangeRatesRemoteDataSource {
  Future<ExchangeRatesModel> getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  });
}

class ExchangeRatesRemoteDataSourceImpl
    implements ExchangeRatesRemoteDataSource {
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
          'source': source,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ExchangeRatesModel.fromJson(response.data);
      } else {
        throw ApiException(
            message: response.data['error'] ?? 'Unknown error occurred',
            statusCode: response.statusCode!);
      }
    } on DioException catch (e) {
      throw ApiException(
          message: e.message ?? 'API request failed',
          statusCode: e.response!.statusCode!);
    }
  }
}
