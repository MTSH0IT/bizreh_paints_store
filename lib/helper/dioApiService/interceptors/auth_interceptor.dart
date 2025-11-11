import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';

/// Interceptor for adding authentication token to requests
class AuthInterceptor extends Interceptor {
  final StorageService _storageService = StorageService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from storage and attach to headers if present
    try {
      final token = _storageService.getString(StorageKey.accessToken);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {}

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle response if needed
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - Token expired

    return handler.next(err);
  }
}
