import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/wishlist_model/wishlist_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class WishListServices {
  final IApiClient _apiClient;

  WishListServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<void> addWishlistItems({required int optionPackagingId}) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.addWishlistItems,
        data: {'option_packaging_id': optionPackagingId},
      );

      final apiResponse = ApiResponse.fromJson(response, null);

      if (apiResponse.success) {
        log("wishlist service add item : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("wishlist service catch add item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> removeWishlistItem({required int wishlistId}) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoint.removeWishlistItems(wishlistId),
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        log("wishlist service remove item : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("wishlist service catch remove item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> clearWishlist() async {
    try {
      final response = await _apiClient.delete(ApiEndpoint.clearWishlist);
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        log("wishlist service clear : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("wishlist service catch clear : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<WishlistModel>> getWishlist() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getWishlist);
      final apiResponse = ApiResponse.fromJson(response, (json) {
        final list = (json['wishlist']['items'] as List?) ?? [];
        return list
            .map((e) => WishlistModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        log("wishlist service get : ${apiResponse.message}");
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("wishlist service catch get : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
