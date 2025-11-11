import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/models/auth_response.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:dio/dio.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';

class AuthService {
  final DioClient _dioClient = DioClient();

  Future<AuthResponse> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.login,
        data: {JsonKey.email: email, JsonKey.password: password},
      );
      final apiResponse = ApiResponse<AuthResponse>.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "auth service AppException sign in : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("auth service DioException sign in : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("auth service catch sign in : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<AuthResponse> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.signup,
        data: {
          JsonKey.email: email,
          JsonKey.password: password,
          JsonKey.firstName: firstName,
          JsonKey.lastName: lastName,
          JsonKey.phone: phone,
        },
      );
      final apiResponse = ApiResponse<AuthResponse>.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "auth service AppException sign up : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("auth service DioException sign up : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("auth service catch sign up : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
