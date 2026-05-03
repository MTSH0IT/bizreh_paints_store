import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class ProductServices {
  final IApiClient _apiClient;

  ProductServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<ApiResponse<List<ProductModel>>> getProducts({
    int? subCategory,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};
      if (subCategory != null) queryParameters['sub_category'] = subCategory;

      final response = await _apiClient.get(
        ApiEndpoint.getProducts,
        queryParameters: queryParameters,
      );

      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
        response,
        (json) {
          final List raw = (json['products'] as List?) ?? [];
          return raw
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );

      if (apiResponse.success) {
        log("product service get products : ${apiResponse.message}");
        return apiResponse;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getTopSelling() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.topSellingProduct);
      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
        response,
        (json) {
          final List raw = (json['products'] as List?) ?? [];
          return raw
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      if (apiResponse.success || apiResponse.data != null) {
        log("product service get top selling : ${apiResponse.message}");
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductModel> getProductById({required int id}) async {
    try {
      final response = await _apiClient.get(ApiEndpoint.productById(id));
      final apiResponse = ApiResponse<ProductModel>.fromJson(response, (
        json,
      ) {
        return ProductModel.fromJson(json['product'] as Map<String, dynamic>);
      });
      if (apiResponse.success && apiResponse.data != null) {
        log("product service get product by id : ${apiResponse.message}");
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
