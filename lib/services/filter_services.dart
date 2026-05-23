import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class FilterServices {
  final IApiClient _apiClient;

  FilterServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<ApiResponse<List<ProductModel>>> searchProducts({
    int? brand,
    int? subCategory,
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoint.getProducts,
        queryParameters: {
          'brand': brand,
          'sub_category': subCategory,
          'q': query,
          'page': page,
          'limit': limit,
        },
      );

      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(response, (
        json,
      ) {
        final List raw = (json['products'] as List?) ?? [];
        return raw
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success) {
        log("filter service search products : ${apiResponse.message}");
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
}
