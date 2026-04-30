import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/wishlist_model/wishlist_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class WishListServices {
  final DioClient _dioClient;

  WishListServices({required DioClient dioClient}) : _dioClient = dioClient;

  Future<void> addWishlistItems({required int optionPackagingId}) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.addWishlistItems,
        data: {'option_packaging_id': optionPackagingId},
      );

      final apiResponse = ApiResponse.fromJson(response.data, null);

      if (apiResponse.success) {
        log("wishlist service add item : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "wishlist service AppException add item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("wishlist service DioException add item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("wishlist service catch add item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> removeWishlistItem({required int wishlistId}) async {
    try {
      final response = await _dioClient.delete(
        ApiEndpoint.removeWishlistItems(wishlistId),
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        log("wishlist service remove item : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "wishlist service AppException remove item : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("wishlist service DioException remove item : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("wishlist service catch remove item : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> clearWishlist() async {
    try {
      final response = await _dioClient.delete(ApiEndpoint.clearWishlist);
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        log("wishlist service clear : ${apiResponse.message}");
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "wishlist service AppException clear : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("wishlist service DioException clear : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("wishlist service catch clear : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<WishlistModel>> getWishlist() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getWishlist);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
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
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "wishlist service AppException get : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("wishlist service DioException get : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("wishlist service catch get : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
