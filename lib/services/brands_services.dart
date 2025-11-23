import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/brands_featured_model/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class BrandsServices {
  final DioClient _dioClient = DioClient();

  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.brandsFeatured);

      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final List list = (json['brands'] as List?) ?? [];
        return list
            .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<BrandModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "brands service AppException featured brands : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("brands service DioException featured brands : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("brands service catch featured brands : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.brands);

      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final List list = (json['brands'] as List?) ?? [];
        return list
            .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<BrandModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "brands service AppException brands : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("brands service DioException brands : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("brands service catch brands : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<ApiResponse<List<ProductModel>>> getBrandProducts({
    required int brandId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.brandProducts(brandId),
        queryParameters: {'page': page, 'limit': limit},
      );

      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
        response.data,
        (json) {
          final List raw = (json['products'] as List?) ?? [];
          return raw
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
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
          "brands service AppException brand products : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("brands service DioException brand products : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("brands service catch brand products : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
