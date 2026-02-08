import 'package:dio/dio.dart';
import 'package:flutter_project/packages/core/network/api_exception.dart';
import 'package:flutter_project/packages/core/network/api_response.dart';

class ApiClient {
  final Dio _dio;
  final String baseUrl;

  ApiClient(this._dio, {required this.baseUrl});

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl$endpoint',
        queryParameters: queryParameters,
      );

      return ApiResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: 'Success',
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred',
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
      );

      return ApiResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: 'Success',
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred',
        statusCode: 500,
      );
    }
  }

  ApiException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: 408,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'No internet connection. Please check your network.',
          statusCode: 0,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          message: e.response?.statusMessage ?? 'Server error occurred',
          statusCode: e.response?.statusCode ?? 500,
        );
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request was cancelled',
          statusCode: 0,
        );
      default:
        return ApiException(
          message: 'An unexpected error occurred',
          statusCode: 500,
        );
    }
  }
}

