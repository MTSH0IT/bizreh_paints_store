import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/notification_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
import 'package:dio/dio.dart';

class NotificationsServices {
  final DioClient _dioClient;

  NotificationsServices({required DioClient dioClient})
    : _dioClient = dioClient;

  Future<List<NotificationModel>> getNotification() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.getNotifications);
      final apiResponse = ApiResponse<List<NotificationModel>>.fromJson(
        response.data,
        (json) {
          final notifications = json as List;
          return notifications
              .map((e) => NotificationModel.fromJson(e))
              .toList();
        },
      );
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message);
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "notifications service AppException get notifications : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log(
        "notifications service DioException get notifications : ${e.message}",
      );
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> readNotification({required int id}) async {
    try {
      final response = await _dioClient.patch(ApiEndpoint.readNotification(id));
      final apiResponse = ApiResponse<void>.fromJson(response.data, null);
      if (apiResponse.success) {
        log("notifications service read notification : ${apiResponse.message}");
      } else {
        throw Exception(apiResponse.message);
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "notifications service AppException read notification : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log(
        "notifications service DioException read notification : ${e.message}",
      );
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> readAllNotifications() async {
    try {
      final response = await _dioClient.patch(ApiEndpoint.readAllNotifications);
      final apiResponse = ApiResponse<void>.fromJson(response.data, null);
      if (apiResponse.success) {
        log(
          "notifications service read all notification : ${apiResponse.message}",
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "notifications service AppException read all notification : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log(
        "notifications service DioException read all notification : ${e.message}",
      );
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _dioClient.get(ApiEndpoint.unreadCount);
      final apiResponse = ApiResponse<int>.fromJson(response.data, (json) {
        return json['unread_count'] as int;
      });
      if (apiResponse.success && apiResponse.data != null) {
        log("notifications service get unread count : ${apiResponse.message}");
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message);
      }
    } on DioException catch (e) {
      final err = e.error;
      if (err is AppException) {
        log(
          "notifications service AppException get unread count : ${err.message}${err.statusCode}",
        );
        throw err;
      }
      log("notifications service DioException get unread count : ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
