import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class BrandsServices {
  final IApiClient _apiClient;

  BrandsServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.brandsFeatured);

      final apiResponse = ApiResponse.fromJson(response, (json) {
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
    } on AppException {
      rethrow;
    } catch (e) {
      log("brands service catch featured brands : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.brands);

      final apiResponse = ApiResponse.fromJson(response, (json) {
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
    } on AppException {
      rethrow;
    } catch (e) {
      log("brands service catch brands : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<ApiResponse<List<ProductModel>>> getBrandProducts({
    required int brandId,
  }) async {
    try {
      final response = await _apiClient.get(ApiEndpoint.brandProducts(brandId));

      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(response, (
        json,
      ) {
        final List raw = (json['products'] as List?) ?? [];
        return raw
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success) {
        return apiResponse;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("brands service catch brand products : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
