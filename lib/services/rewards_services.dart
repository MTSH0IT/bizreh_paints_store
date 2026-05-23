import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/models/point_rule_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class RewardsServices {
  final IApiClient _apiClient;

  RewardsServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<List<DiscontModel>> getDiscountOffers() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getDiscountOffers);
      final apiResponse = ApiResponse<List<DiscontModel>>.fromJson(response, (
        json,
      ) {
        final list = (json as List?) ?? [];
        return list
            .map((e) => DiscontModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on AppException {
      rethrow;
    } catch (e) {
      log("rewards service catch get discounts : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<PointRuleModel>> getPointsRules() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getPointsRules);
      final apiResponse = ApiResponse<List<PointRuleModel>>.fromJson(response, (
        json,
      ) {
        final list = (json as List?) ?? [];
        return list
            .map((e) => PointRuleModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on AppException {
      rethrow;
    } catch (e) {
      log("rewards service catch get points rules : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
