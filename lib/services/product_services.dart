import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class ProductServices {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<List<ProductModel>>> getProducts({
    int page = 1,
    int limit = 20,
    int? subCategory,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.getProducts,
        queryParameters: {
          'page': page,
          'limit': limit,
          'sub_category': subCategory,
        },
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
        log("product service get products : ${apiResponse.message}");
        return apiResponse;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "product service AppException get products : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("product service DioException get products : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductModel> getProductById({required int id}) async {
    try {
      final response = await _dioClient.get(ApiEndpoint.productById(id));
      final apiResponse = ApiResponse<ProductModel>.fromJson(response.data, (
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
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "product service AppException get product by id : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("product service DioException get product by id : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
