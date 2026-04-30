import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/models/point_rule_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class RewardsServices {
  final DioClient _dioClient;

  RewardsServices({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<DiscontModel>> getDiscountOffers() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getDiscountOffers);
      final apiResponse = ApiResponse<List<DiscontModel>>.fromJson(
        response.data,
        (json) {
          final list = (json as List?) ?? [];
          return list
              .map((e) => DiscontModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "rewards service AppException get discounts : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("rewards service DioException get discounts : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("rewards service catch get discounts : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<PointRuleModel>> getPointsRules() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getPointsRules);
      final apiResponse = ApiResponse<List<PointRuleModel>>.fromJson(
        response.data,
        (json) {
          final list = (json as List?) ?? [];
          return list
              .map((e) => PointRuleModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "rewards service AppException get points rules : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("rewards service DioException get points rules : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("rewards service catch get points rules : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
