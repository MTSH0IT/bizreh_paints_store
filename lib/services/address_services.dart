import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/cities_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class AddressServices {
  final DioClient _dioClient;

  AddressServices({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getAddresses);
      final apiResponse = ApiResponse<List<AddressModel>>.fromJson(
        response.data,
        (json) {
          final list = json['addresses'] as List? ?? [];
          return list.map((e) => AddressModel.fromJson(e)).toList();
        },
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<AddressModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException get addresses : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException get addresses : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Address service catch get addresses : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAddress({required int id}) async {
    try {
      final response = await _dioClient.delete(ApiEndpoint.deleteAddress(id));
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException delete address : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException delete address : ${e.message}");
      throw Exception(e.message);
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
      final response = await _dioClient.post(
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
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException create address : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException create address : ${e.message}");
      throw Exception(e.message);
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
      final response = await _dioClient.put(
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
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException update address : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException update address : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Address service catch update address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<void> setDefaultAddress({required int id}) async {
    try {
      final response = await _dioClient.patch(
        ApiEndpoint.setDefaultAddress(id),
      );
      final apiResponse = ApiResponse.fromJson(response.data, null);
      if (apiResponse.success) {
        return;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException set default address : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException set default address : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Address service catch set default address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<AddressModel> getDefaultAddress() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getDefaultAddress);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        return AddressModel.fromJson(json['address']);
      });
      if (apiResponse.success && apiResponse.data != null) {
        log("getDefaultAddress");
        log(apiResponse.data.toString());

        return apiResponse.data as AddressModel;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException get default address : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException get default address : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Address service catch get default address : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<CitiesModel>> getCities() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getCities);
      final apiResponse = ApiResponse.fromJson(response.data, (json) {
        final list = json['cities'] as List? ?? [];
        return list.map((e) => CitiesModel.fromJson(e)).toList();
      });
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data as List<CitiesModel>;
      } else {
        throw Exception(apiResponse.message ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "Address service AppException get cities : ${err.message}"
          "${err.statusCode}",
        );
        throw err;
      }
      log("Address service DioException get cities : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("Address service catch get cities : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
