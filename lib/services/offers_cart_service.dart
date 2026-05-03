import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/offers_cart_model/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class OffersCartService {
  final IApiClient _apiClient;

  OffersCartService({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<List<OffersCartModel>> getAvailableOffers() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getOffersCartAvailable);
      final apiResponse = ApiResponse<List<OffersCartModel>>.fromJson(
        response,
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
    } on AppException {
      rethrow;
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
      final response = await _apiClient.post(
        ApiEndpoint.purchaseOffersCart(offerId),
        data: {'quantity': quantity, 'address_id': addressId},
      );

      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on AppException {
      rethrow;
    } catch (e) {
      log('offers cart service catch purchase offer : ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
