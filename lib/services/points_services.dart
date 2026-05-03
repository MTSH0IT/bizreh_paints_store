import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/points_history_model/points_history_model.dart';
import 'package:bizreh_paints_store/models/user_points_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class PointsServices {
  final IApiClient _apiClient;

  PointsServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<UserPointsModel> getUserPoints() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getUserPoints);
      final apiResponse = ApiResponse.fromJson(response, (json) {
        final points = (json as Map<String, dynamic>?) ?? {};
        return UserPointsModel.fromJson(points);
      });

      if (apiResponse.success && apiResponse.data != null) {
        log("points service get points : ${apiResponse.message}");
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on AppException {
      rethrow;
    } catch (e) {
      log("points service catch get points : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<PointsHistoryModel>> getPointsHistory() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getPointsHistory);
      final apiResponse = ApiResponse.fromJson(response, (json) {
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
    } on AppException {
      rethrow;
    } catch (e) {
      log("points service catch get history : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
