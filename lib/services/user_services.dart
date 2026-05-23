import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/user_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:bizreh_paints_store/models/user_report.dart';

class UserService {
  final IApiClient _apiClient;

  UserService({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<UserModel> getProfile() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getProfile);
      final apiResponse = ApiResponse.fromJson(
        response,
        (json) => UserModel.fromJson(json[JsonKey.user]),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("user service catch get profile : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> updateProfail({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  }) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoint.updateProfile,
        data: {
          JsonKey.firstName: firstName,
          JsonKey.lastName: lastName,
          JsonKey.phone: phone,
          JsonKey.email: email,
        },
      );

      final apiResponse = ApiResponse.fromJson(response, null);

      if (apiResponse.success) {
        log("user service update profile : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoint.changePassword,
        data: {
          JsonKey.currentPassword: currentPassword,
          JsonKey.newPassword: newPassword,
        },
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        log("user service change password : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoint.deleteAccount,
        data: {JsonKey.password: password},
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        log("user service delete account : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserReport> getUserReport() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getUserReport);
      final apiResponse = ApiResponse.fromJson(
        response,
        (json) => UserReport.fromJson(json),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("user service catch get user report : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
