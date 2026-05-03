import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/payments_model/payments_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class PaymentsServices {
  final IApiClient _apiClient;

  PaymentsServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<PaymentsModel> getPayments() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getPayments);
      final apiResponse = ApiResponse<PaymentsModel>.fromJson(response, (
        json,
      ) {
        final data = (json as Map<String, dynamic>?) ?? {};
        return PaymentsModel.fromJson(data);
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on AppException {
      rethrow;
    } catch (e) {
      log("payments service catch get payments : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
