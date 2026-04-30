import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/points_history_model/points_history_model.dart';
import 'package:bizreh_paints_store/models/user_points_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class PointsServices {
  final DioClient _dioClient;

  PointsServices({required DioClient dioClient}) : _dioClient = dioClient;

  Future<UserPointsModel> getUserPoints() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getUserPoints);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final points = (json as Map<String, dynamic>?) ?? {};
        return UserPointsModel.fromJson(points);
      });

      if (apiResponse.success && apiResponse.data != null) {
        log("points service get points : ${apiResponse.message}");
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "points service AppException get points : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("points service DioException get points : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("points service catch get points : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<PointsHistoryModel>> getPointsHistory() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getPointsHistory);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final list = (json['history'] as List?) ?? [];
        return list
            .map((e) => PointsHistoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        log("points service get history : ${apiResponse.message}");
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "points service AppException get history : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("points service DioException get history : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("points service catch get history : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
