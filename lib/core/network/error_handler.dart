import 'package:dio/dio.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/exceptions.dart';

class ErrorHandler {
  static Exceptions networkError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exceptions(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.receiveTimeout:
        return Exceptions(
          message: 'Receive timeout. Server may be experiencing issues.',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.sendTimeout:
        return Exceptions(
          message: 'Send timeout. Please try again.',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return Exceptions(
          message: 'Request was cancelled',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.connectionError:
        return Exceptions(
          message: 'No internet connection. Please check your network.',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return httpError(error);
      case DioExceptionType.unknown:
      default:
        return Exceptions(
          message: error.message ?? 'An unexpected error occurred',
          statusCode: error.response?.statusCode,
          errorResponse: error.response?.data,
        );
    }
  }

  static Exceptions httpError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 400:
        return Exceptions(
          message: '${response?.data['message']}',
          statusCode: statusCode,
          errorResponse: response?.data,
        );
      case 401:
        return Exceptions(
          message: 'Unauthorized. Please log in again.',
          statusCode: statusCode,
          errorResponse: response?.data,
        );
      case 403:
        return Exceptions(
          message:
              'Forbidden. You do not have permission to access this resource.',
          statusCode: statusCode,
          errorResponse: response?.data,
        );
      case 404:
        return Exceptions(
          message: 'Resource not found.',
          statusCode: statusCode,
          errorResponse: response?.data,
        );
      case 500:
        return Exceptions(
          message: 'Internal server error. Please try again later.',
          statusCode: statusCode,
          errorResponse: response?.data,
        );
      default:
        return Exceptions(
          message: 'An unexpected error occurred',
          statusCode: statusCode,
          errorResponse: response?.data,
        );
    }
  }
}
