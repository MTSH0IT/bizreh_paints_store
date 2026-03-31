import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/offers_cart_model/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class OffersCartService {
  final DioClient _dioClient = DioClient();

  Future<List<OffersCartModel>> getAvailableOffers() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getOffersCartAvailable);
      final apiResponse = ApiResponse<List<OffersCartModel>>.fromJson(
        response.data,
        (json) {
          final list = (json as List?) ?? [];
          return list
              .map((e) => OffersCartModel.fromJson(e as Map<String, dynamic>))
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
          'offers cart service AppException get available offers : ${err.message}${err.statusCode}',
        );
        throw err;
      }
      log(
        'offers cart service DioException get available offers : ${e.message}',
      );
      throw Exception(e.message);
    } catch (e) {
      log('offers cart service catch get available offers : ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  Future<void> purchaseOffer({
    required int offerId,
    required int quantity,
    required int addressId,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.purchaseOffersCart(offerId),
        data: {'quantity': quantity, 'address_id': addressId},
      );

      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          'offers cart service AppException purchase offer : ${err.message}${err.statusCode}',
        );
        throw err;
      }
      log('offers cart service DioException purchase offer : ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      log('offers cart service catch purchase offer : ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
