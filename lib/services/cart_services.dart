import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/cart_model/cart_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class CartServices {
  final DioClient _dioClient = DioClient();

  Future<void> addToCart({
    required int optionPackagingId,
    int? colorFamilyId,
    required int quantity,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.addToCart,
        data: {
          'option_packaging_id': optionPackagingId,
          'color_family_id': colorFamilyId,
          'quantity': quantity,
        },
      );

      final apiResponse = ApiResponse.fromJson(response.data, null);

      if (apiResponse.success) {
        log("Cart service add item : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Cart service AppException add item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Cart service DioException add item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Cart service catch add item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  /// Update cart item (PUT /user/cart/{id})
  Future<void> updateCart({
    required int cartItemId,
    required int quantity,
    //required int colorFamilyId,
  }) async {
    try {
      final response = await _dioClient.put(
        ApiEndpoint.updateCart(cartItemId),
        data: {'quantity': quantity},
      );

      final apiResponse = ApiResponse.fromJson(response.data, null);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Cart service AppException update item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Cart service DioException update item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Cart service catch update item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  /// Delete cart item (DELETE /user/cart/{id})
  Future<void> deleteCartItem({required int cartItemId}) async {
    try {
      final response = await _dioClient.delete(
        ApiEndpoint.deleteCart(cartItemId),
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Cart service AppException delete item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Cart service DioException delete item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Cart service catch delete item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  /// Increase cart item quantity (POST /user/cart/{id}/increase)
  Future<void> increaseCartItem({
    required int cartItemId,
    required int? quantity,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.increaseCart(cartItemId),
        data: {'quantity': quantity},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Cart service AppException increase item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Cart service DioException increase item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Cart service catch increase item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  /// Decrease cart item quantity (POST /user/cart/{id}/decrease)
  Future<void> decreaseCartItem({
    required int cartItemId,
    required int? quantity,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.decreaseCart(cartItemId),
        data: {'quantity': quantity},
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Cart service AppException decrease item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Cart service DioException decrease item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Cart service catch decrease item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<CartModel> getCart() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getCart);
      final apiResponse = ApiResponse<CartModel>.fromJson(
        response.data,
        (json) => CartModel.fromJson(json),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as CartModel;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Cart service AppException get cart : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("Cart service DioException get cart : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Cart service catch get cart : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
