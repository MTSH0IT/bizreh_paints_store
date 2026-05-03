import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/ads_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class AdsServices {
  final IApiClient _apiClient;

  AdsServices({required IApiClient apiClient}) : _apiClient = apiClient;
  Future<List<AdsModel>> getAds() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getAds);
      final apiResponse = ApiResponse<List<AdsModel>>.fromJson(response, (
        json,
      ) {
        final List raw = (json as List?) ?? [];
        return raw
            .map((e) => AdsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message);
    } on AppException {
      rethrow;
    } catch (e) {
      log("ads service catch get ads : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
