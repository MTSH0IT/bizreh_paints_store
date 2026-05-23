import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/cities_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';

class AddressServices {
  final IApiClient _apiClient;

  AddressServices({required IApiClient apiClient}) : _apiClient = apiClient;

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getAddresses);
      final apiResponse = ApiResponse<List<AddressModel>>.fromJson(response, (
        json,
      ) {
        final list = json['addresses'] as List? ?? [];
        return list.map((e) => AddressModel.fromJson(e)).toList();
      });
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<AddressModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch get addresses : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAddress({required int id}) async {
    try {
      final response = await _apiClient.delete(ApiEndpoint.deleteAddress(id));
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch delete address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> createAddress({
    required int cityId,
    required String addressLine,
    required String nickName,
    required String note,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.createAddress,
        data: {
          'nickname': nickName,
          'city_id': cityId,
          'address_line': addressLine,
          'note': note,
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch create address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> updateAddress({
    required int id,
    required String nickName,
    required int cityId,
    required String addressLine,
    required String note,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoint.updateAddress(id),
        data: {
          'nickname': nickName,
          'city_id': cityId,
          'address_line': addressLine,
          'note': note,
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch update address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> setDefaultAddress({required int id}) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoint.setDefaultAddress(id),
      );
      final apiResponse = ApiResponse.fromJson(response, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch set default address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<AddressModel> getDefaultAddress() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getDefaultAddress);
      final apiResponse = ApiResponse.fromJson(response, (json) {
        return AddressModel.fromJson(json['address']);
      });
      if (apiResponse.success && apiResponse.data != null) {
        log("getDefaultAddress");
        log(apiResponse.data.toString());

        return apiResponse.data as AddressModel;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch get default address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<CitiesModel>> getCities() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getCities);
      final apiResponse = ApiResponse.fromJson(response, (json) {
        final list = json['cities'] as List? ?? [];
        return list.map((e) => CitiesModel.fromJson(e)).toList();
      });
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<CitiesModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log("Address service catch get cities : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
