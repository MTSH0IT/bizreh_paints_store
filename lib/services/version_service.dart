import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class VersionService {
  final IApiClient _apiClient;

  VersionService({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<String> getMinVersion() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getVersion);
      log('Version API response: $response');

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['version'] != null) {
          return response['version'] as String;
        } else {
          throw Exception('API response indicates failure or missing version');
        }
      } else {
        throw Exception('Invalid response format');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("version service catch get min version : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
