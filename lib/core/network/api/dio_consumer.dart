import 'package:dio/dio.dart';
import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/core/network/errors/exceptions.dart';

/// Implementation of [ApiConsumer] using the [Dio] package
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = ServerStrings.baseUrl;
    dio.options.receiveDataWhenStatusError = true;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  /// Handles Dio errors and maps them to custom [AppException]
  void _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException();
      case DioExceptionType.badResponse:
        _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        throw ServerException(message: 'Request to API server was cancelled');
      case DioExceptionType.connectionError:
        throw NetworkException();
      case DioExceptionType.unknown:
      default:
        throw ServerException(
          message: 'Something went wrong. Please try again later.',
        );
    }
  }

  /// Handles HTTP errors based on status code
  void _handleBadResponse(Response? response) {
    if (response == null) {
      throw ServerException(message: 'No response from server');
    }

    final int statusCode = response.statusCode ?? 0;
    final dynamic data = response.data;
    final String message = data is Map && data.containsKey('message')
        ? data['message']
        : 'Server error occurred';

    switch (statusCode) {
      case 400:
        throw ServerException(message: message, statusCode: 400);
      case 401:
        throw UnauthorizedException();
      case 403:
        throw ForbiddenException(message: message);
      case 404:
        throw NotFoundException();
      case 422:
        throw ValidationException(
          errors: data is Map<String, dynamic> ? data['errors'] : null,
          message: message,
        );
      case 500:
      case 502:
      case 504:
        throw ServerException(message: 'Internal server error', statusCode: statusCode);
      default:
        throw ServerException(message: message, statusCode: statusCode);
    }
  }
}
