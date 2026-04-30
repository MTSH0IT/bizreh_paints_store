import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class CollectionServices {
  final DioClient _dioClient;

  CollectionServices({required DioClient dioClient}) : _dioClient = dioClient;
  Future<List<CollectionModel>> getCollections() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getCollection);

      final apiResponse = ApiResponse.fromJson(response.data, (json) {
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
    } on DioException catch (e) {
      log("collection service DioException get collection : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("collection service catch get collection : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
