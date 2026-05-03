import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class CollectionServices {
  final IApiClient _apiClient;

  CollectionServices({required IApiClient apiClient}) : _apiClient = apiClient;
  Future<List<CollectionModel>> getCollections() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getCollection);

      final apiResponse = ApiResponse.fromJson(response, (json) {
        final List list = (json as List?) ?? [];
        return list
            .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<CollectionModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("collection service catch get collection : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
