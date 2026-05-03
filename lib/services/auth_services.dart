import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/models/auth_response.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';

class AuthService {
  final IApiClient _apiClient;

  AuthService({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<AuthResponse> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.login,
        data: {JsonKey.email: email, JsonKey.password: password},
      );
      final apiResponse = ApiResponse<AuthResponse>.fromJson(
        response,
        (json) => AuthResponse.fromJson(json),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("auth service catch sign in : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.signup,
        data: {
          JsonKey.email: email,
          JsonKey.password: password,
          JsonKey.firstName: firstName,
          JsonKey.lastName: lastName,
          JsonKey.phone: phone,
        },
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success && apiResponse.data != null) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("auth service catch sign up : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<String> forgetPassword({required String email}) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.forgetPassword,
        data: {JsonKey.email: email},
      );
      final apiResponse = ApiResponse<dynamic>.fromJson(response, null);
      if (apiResponse.success) {
        return apiResponse.message ?? 'Success';
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("auth service catch forget password : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<String> resendVerification({required String email}) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.resendVerification,
        data: {JsonKey.email: email},
      );
      final apiResponse = ApiResponse<dynamic>.fromJson(response, null);
      if (apiResponse.success) {
        return apiResponse.message ?? 'Success';
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("auth service catch resend verification : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<String> verifyAccount({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.verifyAccount,
        data: {JsonKey.email: email, 'verification_code': verificationCode},
      );
      final apiResponse = ApiResponse<dynamic>.fromJson(response, null);
      if (apiResponse.success) {
        return apiResponse.message ?? 'Success';
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("auth service catch verify account : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
