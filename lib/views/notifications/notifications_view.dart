import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/notifications_controllers.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'widgets/notification_card.dart';
import 'widgets/notification_details_sheet.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  final NotificationsControllers controller =
      Get.find<NotificationsControllers>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Obx(() {
          final count = controller.unreadCount.value;
          if (count > 0) {
            return Text(
              tr('notifications.title_with_count', args: [count.toString()]),
            );
          }
          return Text(tr('notifications.title'));
        }),
        actions: [
          Obx(() {
            final hasNotifications = controller.notifications.isNotEmpty;
            final loading = controller.isReadAllNotificationsLoading.value;
            if (!hasNotifications) {
              return const SizedBox.shrink();
            }
            return TextButton(
              onPressed: loading || controller.unreadCount.value == 0
                  ? null
                  : () async {
                      await controller.readAllNotifications();
                      controller.unreadCount.value = 0;
                      for (final item in controller.notifications) {
                        item.isRead = 1;
                      }
                      controller.notifications.refresh();
                    },
              child: loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: BuildProgressIndicator(),
                    )
                  : const Icon(Icons.mark_email_read_outlined),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isNotificationsLoading.value) {
            return const BuildProgressIndicator();
          }

          final list = controller.notifications;

          return AppRefreshWrapper(
            onRefresh: () async {
              await Future.wait([
                controller.getUnreadCount(),
                controller.getNotifications(),
              ]);
            },
            child: controller.notifications.isEmpty
                ? ListView(
                    children: [
                      SizedBox(height: 240),
                      Text(tr('notifications.empty')),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final notification = list[index];
                      return NotificationCard(
                        notification: notification,
                        onTap: () async {
                          final id = notification.id;
                          if (id != null && (notification.isRead ?? 0) != 1) {
                            await controller.readNotification(id: id);
                            notification.isRead = 1;
                            controller.unreadCount.value--;
                            controller.notifications.refresh();
                          }

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: CardColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => NotificationDetailsSheet(
                              notification: notification,
                            ),
                          );
                        },
                      );
                    },
                  ),
          );
        }),
      ),
    );
  }
}
