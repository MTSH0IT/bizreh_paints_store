import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class OrderServices {
  final IApiClient _apiClient;

  OrderServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<void> createOrder({
    required int orderId,
    required int addressId,
  }) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoint.pendOrder(orderId),
        data: {'address_id': addressId},
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Order service catch create order : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<ApiResponse<List<OrderModel>>> getOrderHistory() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getOrder);

      final apiResponse = ApiResponse<List<OrderModel>>.fromJson(
        response,
        (json) => (json as List).map((e) => OrderModel.fromJson(e)).toList(),
      );
      if (apiResponse.success) {
        return apiResponse;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Order service catch get order history : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<OrderModel> getOrderDetails(int id) async {
    try {
      final response = await _apiClient.get(ApiEndpoint.detailsOrder(id));

      final apiResponse = ApiResponse<OrderModel>.fromJson(
        response,
        (json) => OrderModel.fromJson(json),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Order service catch get order details : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> cancelOrder(int id, String reason) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.cancelOrder(id),
        data: {"reason": reason},
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Order service catch cancel order : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> reorder(int id, Map<String, dynamic> body) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.reorder(id),
        data: body,
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Order service catch reorder : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> complaint(int id, String message) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.complaint(id),
        data: {"message": message},
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Order service catch complaint : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
