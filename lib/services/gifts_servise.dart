import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/available_gifts_model.dart';
import 'package:bizreh_paints_store/models/gifts_model.dart';
import 'package:bizreh_paints_store/models/user_gifts_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class GiftsServise {
  final DioClient _dioClient = DioClient();

  Future<List<GiftsModel>> getAllGifts() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getAllGifts);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final list = (json as List?) ?? [];
        return list
            .map((e) => GiftsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        log("gifts service get all : ${apiResponse.message}");
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "gifts service AppException get all : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("gifts service DioException get all : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("gifts service catch get all : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<UserGiftsModel>> getMyGifts() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getMyGifts);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final list = (json['gifts'] as List?) ?? [];
        return list
            .map((e) => UserGiftsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        log("gifts service get my : ${apiResponse.message}");
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "gifts service AppException get my : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("gifts service DioException get my : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("gifts service catch get my : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<AvailableGiftsResponse> getAvailableGifts() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getAvailableGifts);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => AvailableGiftsResponse.fromJson(json as Map<String, dynamic>),
      );

      if (apiResponse.success && apiResponse.data != null) {
        log("gifts service get available : ${apiResponse.message}");
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "gifts service AppException get available : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("gifts service DioException get available : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("gifts service catch get available : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> redeemGift({required int giftId}) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.redeemGift,
        data: {'gift_id': giftId},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);

      if (apiResponse.success) {
        log("gifts service redeem : ${apiResponse.message}");
        return;
      }
      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "gifts service AppException redeem : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("gifts service DioException redeem : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("gifts service catch redeem : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
