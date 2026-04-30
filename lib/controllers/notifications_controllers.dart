import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/services/notifications_services.dart';
import 'package:bizreh_paints_store/models/notification_model.dart';

class NotificationsControllers extends GetxController {
  final NotificationsServices _notificationsServices;

  NotificationsControllers({
    required NotificationsServices notificationsServices,
  }) : _notificationsServices = notificationsServices;

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  RxInt unreadCount = 0.obs;

  RxBool isNotificationsLoading = false.obs;
  RxBool isReadNotificationLoading = false.obs;
  RxBool isReadAllNotificationsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
    getUnreadCount();
  }

  Future<void> getNotifications() async {
    try {
      isNotificationsLoading.value = true;
      final list = await _notificationsServices.getNotification();
      notifications.assignAll(list);
      isNotificationsLoading.value = false;
    } on AppException catch (e) {
      log("notifications controller AppException notifications : ${e.message}");
    } catch (e) {
      log("notifications controller catch notifications : ${e.toString()}");
    } finally {
      isNotificationsLoading.value = false;
    }
  }

  Future<void> readNotification({required int id}) async {
    try {
      isReadNotificationLoading.value = true;
      await _notificationsServices.readNotification(id: id);
      isReadNotificationLoading.value = false;
    } on AppException catch (e) {
      log(
        "notifications controller AppException read notification : ${e.message}",
      );
    } catch (e) {
      log("notifications controller catch read notification : ${e.toString()}");
    } finally {
      isReadNotificationLoading.value = false;
    }
  }

  Future<void> readAllNotifications() async {
    try {
      isReadAllNotificationsLoading.value = true;
      await _notificationsServices.readAllNotifications();
      isReadAllNotificationsLoading.value = false;
    } on AppException catch (e) {
      log(
        "notifications controller AppException read all notification : ${e.message}",
      );
    } catch (e) {
      log(
        "notifications controller catch read all notification : ${e.toString()}",
      );
    } finally {
      isReadAllNotificationsLoading.value = false;
    }
  }

  Future<void> getUnreadCount() async {
    try {
      final count = await _notificationsServices.getUnreadCount();
      unreadCount.value = count;
    } on AppException catch (e) {
      log("notifications controller AppException unread count : ${e.message}");
    } catch (e) {
      log("notifications controller catch unread count : ${e.toString()}");
    }
  }
}
