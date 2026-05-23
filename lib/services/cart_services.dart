import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/cart_model/cart_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class CartServices {
  final IApiClient _apiClient;

  CartServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<void> addToCart({
    required int optionPackagingId,
    int? colorFamilyId,
    required int quantity,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.addToCart,
        data: {
          'option_packaging_id': optionPackagingId,
          'color_family_id': colorFamilyId,
          'quantity': quantity,
        },
      );

      final apiResponse = ApiResponse.fromJson(response, null);

      if (apiResponse.success) {
        log("Cart service add item : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
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
      final response = await _apiClient.put(
        ApiEndpoint.updateCart(cartItemId),
        data: {'quantity': quantity},
      );

      final apiResponse = ApiResponse.fromJson(response, null);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Cart service catch update item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  /// Delete cart item (DELETE /user/cart/{id})
  Future<void> deleteCartItem({required int cartItemId}) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoint.deleteCart(cartItemId),
      );
      final apiResponse = ApiResponse.fromJson(response, null);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
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
      final response = await _apiClient.post(
        ApiEndpoint.increaseCart(cartItemId),
        data: {'quantity': quantity},
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
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
      final response = await _apiClient.post(
        ApiEndpoint.decreaseCart(cartItemId),
        data: {'quantity': quantity},
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Cart service catch decrease item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<CartModel> getCart() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getCart);
      final apiResponse = ApiResponse<CartModel>.fromJson(
        response,
        (json) => CartModel.fromJson(json),
      );

      if (apiResponse.success) {
        if (apiResponse.data != null) {
          return apiResponse.data as CartModel;
        } else {
          return CartModel();
        }
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Cart service catch get cart : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
