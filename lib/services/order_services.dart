import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/order_history_model.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class OrderServices {
  final DioClient _dioClient = DioClient();

  Future<void> createOrder({
    required int orderId,
    required int addressId,
  }) async {
    try {
      final response = await _dioClient.patch(
        ApiEndpoint.pendOrder(orderId),
        data: {'address_id': addressId},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Order service AppException create order : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Order service DioException create order : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Order service catch create order : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<ApiResponse<List<OrderHistoryModel>>> getOrderHistory() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getOrder);

      final apiResponse = ApiResponse<List<OrderHistoryModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((e) => OrderHistoryModel.fromJson(e)).toList(),
      );
      if (apiResponse.success) {
        return apiResponse;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Order service AppException get order history : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Order service DioException get order history : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Order service catch get order history : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<OrderModel> getOrderDetails(int id) async {
    try {
      final response = await _dioClient.get(ApiEndpoint.detailsOrder(id));

      final apiResponse = ApiResponse<OrderModel>.fromJson(
        response.data,
        (json) => OrderModel.fromJson(json),
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Order service AppException get order details : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Order service DioException get order details : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Order service catch get order details : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> cancelOrder(int id, String reason) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.cancelOrder(id),
        data: {"reason": reason},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Order service AppException cancel order : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Order service DioException cancel order : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Order service catch cancel order : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> reorder(int id, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.reorder(id),
        data: body,
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Order service AppException reorder : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Order service DioException reorder : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Order service catch reorder : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> complaint(int id, String message) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.complaint(id),
        data: {"message": message},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Order service AppException complaint : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Order service DioException complaint : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Order service catch complaint : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
