import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/payments_model/payments_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class PaymentsServices {
  final DioClient _dioClient = DioClient();

  Future<PaymentsModel> getPayments() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getPayments);
      final apiResponse = ApiResponse<PaymentsModel>.fromJson(response.data, (
        json,
      ) {
        final data = (json as Map<String, dynamic>?) ?? {};
        return PaymentsModel.fromJson(data);
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }

      throw Exception(apiResponse.message ?? 'Something went wrong');
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "payments service AppException get payments : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("payments service DioException get payments : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("payments service catch get payments : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
