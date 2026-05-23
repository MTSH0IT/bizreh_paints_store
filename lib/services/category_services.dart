import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/category_model.dart';
import 'package:bizreh_paints_store/models/category_tree/category_tree_model.dart';
import 'package:bizreh_paints_store/models/sub_categorey_model.dart';
import 'package:bizreh_paints_store/models/super_categorey_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class CategoryServices {
  final IApiClient _apiClient;

  CategoryServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<List<SuperCategoreyModel>> getSuperCategories() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.superCategories);

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final List list = (json['super_categories'] as List?) ?? [];
        return list
            .map((e) => SuperCategoreyModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<SuperCategoreyModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get super category : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getCategories({String? title}) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoint.categories,
        queryParameters: {"title": title},
      );

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final List list = (json['categories'] as List?) ?? [];
        return list
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<CategoryModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get categories : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<SubCategoreyModel>> getSubCategories() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.subCategories);

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final List list = (json['sub_categories'] as List?) ?? [];
        return list
            .map((e) => SubCategoreyModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<SubCategoreyModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get sub categories : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryTreeModle>> getCategoryTree() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.categoryTree);

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final List list = (json['category_tree'] as List?) ?? [];
        return list
            .map((e) => CategoryTreeModle.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<CategoryTreeModle>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get category tree : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<SubCategoreyModel> getSuperCategory({required int id}) async {
    try {
      final response = await _apiClient.get(ApiEndpoint.superCategoryById(id));

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final Map<String, dynamic>? obj =
            json['super_category'] as Map<String, dynamic>?;
        if (obj == null) return null;
        return SubCategoreyModel.fromJson(obj);
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as SubCategoreyModel;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get super category : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<CategoryModel> getCategory({required int id}) async {
    try {
      final response = await _apiClient.get(ApiEndpoint.categoryById(id));

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final Map<String, dynamic>? obj =
            json['category'] as Map<String, dynamic>?;
        if (obj == null) return null;
        return CategoryModel.fromJson(obj);
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as CategoryModel;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get category : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<SubCategoreyModel> getSubCategory({required int id}) async {
    try {
      final response = await _apiClient.get(ApiEndpoint.subCategoryById(id));

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final Map<String, dynamic>? obj =
            json['sub_category'] as Map<String, dynamic>?;
        if (obj == null) return null;
        return SubCategoreyModel.fromJson(obj);
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as SubCategoreyModel;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("category service catch get sub category : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
