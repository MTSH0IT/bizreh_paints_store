import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

/// Interceptor for handling HTTP errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = TimeoutException(
          message: tr('errors.connection_timeout'),
        );
        break;

      case DioExceptionType.badResponse:
        exception = _handleHttpError(err.response);
        break;

      case DioExceptionType.cancel:
        exception = RequestCancelledException(message: tr('errors.request_cancelled'));
        break;

      case DioExceptionType.connectionError:
        exception = NetworkException(
          message: tr('errors.no_internet'),
        );
        break;

      case DioExceptionType.badCertificate:
        exception = CertificateException(
          message: tr('errors.certificate_failed'),
        );
        break;

      default:
        exception = UnknownException(
          message: tr('errors.something_went_wrong'),
        );
    }

    return handler.next(
      err.copyWith(
        error: exception,
      ),
    );
  }

  /// Handle HTTP response errors
  AppException _handleHttpError(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;

    // Extract error message from response
    String message = tr('errors.an_error_occurred');
    if (data is Map<String, dynamic>) {
      message = data['message'] ?? data['error'] ?? message;
    }

    switch (statusCode) {
      case 400:
        return BadRequestException(message: message);
      case 401:
        return UnauthorizedException(message: message);
      case 403:
        return ForbiddenException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 422:
        return ValidationException(
          message: message,
          errors: data is Map ? data['errors'] : null,
        );
      case 500:
        return ServerException(
          message: tr('errors.server_error'),
        );
      case 503:
        return ServiceUnavailableException(
          message: tr('errors.service_unavailable'),
        );
      default:
        return UnknownException(message: message);
    }
  }
}
