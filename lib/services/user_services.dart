import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/user_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:dio/dio.dart';

class UserService {
  final DioClient _dioClient = DioClient();

  Future<UserModel> getProfile() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getProfile);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => UserModel.fromJson(json[JsonKey.user]),
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
          "user service AppException get profile : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("user service DioException get profile : ${e.message}");
      throw Exception(e.message);
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
      final response = await _dioClient.put(
        ApiEndpoint.updateProfile,
        data: {
          JsonKey.firstName: firstName,
          JsonKey.lastName: lastName,
          JsonKey.phone: phone,
          JsonKey.email: email,
        },
      );

      final apiResponse = ApiResponse.fromJson(response.data, null);

      if (apiResponse.success) {
        log("user service update profile : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        throw err;
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dioClient.patch(
        ApiEndpoint.changePassword,
        data: {
          JsonKey.currentPassword: currentPassword,
          JsonKey.newPassword: newPassword,
        },
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        log("user service change password : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        throw err;
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      final response = await _dioClient.delete(
        ApiEndpoint.deleteAccount,
        data: {JsonKey.password: password},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        log("user service delete account : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        throw err;
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
