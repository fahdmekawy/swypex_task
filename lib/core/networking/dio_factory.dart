import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// A factory class to configure and provide a singleton instance of [Dio] for API requests.
class DioFactory {
  DioFactory._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['SERVER']!,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      queryParameters: {
        'access_key': dotenv.env['API_ACCESS_KEY'],
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.addAll([
      /// Adds a logging interceptor for debugging API requests and responses.
      PrettyDioLogger(
          requestBody: true, requestHeader: true, responseHeader: true)
    ]);

  static Dio getDio() => _dio;
}
