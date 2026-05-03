import 'dart:developer';

import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/notification_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/utils/consts/api_endpoint.dart';
class NotificationsServices {
  final IApiClient _apiClient;

  NotificationsServices({required IApiClient apiClient})
    : _apiClient = apiClient;

  Future<List<NotificationModel>> getNotification() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.getNotifications);
      final apiResponse = ApiResponse<List<NotificationModel>>.fromJson(
        response,
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
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> readNotification({required int id}) async {
    try {
      final response = await _apiClient.patch(ApiEndpoint.readNotification(id));
      final apiResponse = ApiResponse<void>.fromJson(response, null);
      if (apiResponse.success) {
        log("notifications service read notification : ${apiResponse.message}");
      } else {
        throw Exception(apiResponse.message);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> readAllNotifications() async {
    try {
      final response = await _apiClient.patch(ApiEndpoint.readAllNotifications);
      final apiResponse = ApiResponse<void>.fromJson(response, null);
      if (apiResponse.success) {
        log(
          "notifications service read all notification : ${apiResponse.message}",
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.unreadCount);
      final apiResponse = ApiResponse<int>.fromJson(response, (json) {
        return json['unread_count'] as int;
      });
      if (apiResponse.success && apiResponse.data != null) {
        log("notifications service get unread count : ${apiResponse.message}");
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
