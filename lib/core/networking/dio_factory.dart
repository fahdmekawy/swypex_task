import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['SERVER']!,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['API_ACCESS_KEY']}', // Optional
      },
    ),
  )..interceptors.addAll([
      PrettyDioLogger(
          requestBody: true, requestHeader: true, responseHeader: true)
    ]);

  static Dio getDio() => _dio;
}
