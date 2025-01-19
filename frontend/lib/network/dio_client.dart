import 'package:dio/dio.dart';
import 'package:frontend/network/app_exceptions.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioHelper {
  final Dio _dio = Dio();

  DioHelper() {
    _dio.options.baseUrl = "http://10.0.38.172:8000/api/";
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
  }

  Future<Response?> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParameters,
   
      );
    } on DioException catch (e) {
      _handleException(e);
      return null;
    }
  }

  Future<Response?> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      _handleException(e);
      return null;
    }
  }

  void _handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(e.response?.data['message']);
          case 401:
            throw UnauthorizedException(e.response?.data['message']);
          case 404:
            throw NotFoundException(e.response?.data['message']);
          case 500:
            throw InternalServerErrorException(e.response?.data['message']);
          default:
            throw FetchDataException(
                'An error occurred: ${e.response?.statusCode}');
        }
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw FetchDataException('Request timeout');
      case DioExceptionType.cancel:
        throw FetchDataException('Request cancelled');
      case DioExceptionType.unknown:
        throw FetchDataException('No internet connection');
      default:
        throw FetchDataException('An unexpected error occurred');
    }
  }
}
