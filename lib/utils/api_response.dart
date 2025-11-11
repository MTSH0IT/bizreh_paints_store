import 'package:bizreh_paints_store/utils/consts/const_key.dart';

/// Generic API response wrapper
class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({required this.success, this.message, this.data, this.errors});

  /// Create from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json[JsonKey.success] ?? false,
      message: json[JsonKey.message],
      data: json[JsonKey.data] != null && fromJsonT != null
          ? fromJsonT(json[JsonKey.data])
          : json[JsonKey.data],
      errors: json[JsonKey.errors],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      JsonKey.success: success,
      JsonKey.message: message,
      JsonKey.data: data,
      JsonKey.errors: errors,
    };
  }

  /// Success response
  factory ApiResponse.success({String? message, T? data}) {
    return ApiResponse<T>(success: true, message: message, data: data);
  }

  /// Error response
  factory ApiResponse.error({String? message, Map<String, dynamic>? errors}) {
    return ApiResponse<T>(success: false, message: message, errors: errors);
  }
}
