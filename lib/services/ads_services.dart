import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/ads_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class AdsServices {
  final DioClient _dioClient = DioClient();
  Future<List<AdsModel>> getAds() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getAds);
      final apiResponse = ApiResponse<List<AdsModel>>.fromJson(response.data, (
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
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "ads service AppException get ads : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("ads service DioException get ads : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("ads service catch get ads : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
