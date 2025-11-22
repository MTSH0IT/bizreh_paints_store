import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/notification_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class NotificationDetailsSheet extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailsSheet({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final createdAt = notification.createdAt;
    final dateText = createdAt != null
        ? '${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}'
        : null;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.notifications_none_rounded, color: primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    notification.title ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (dateText != null) ...[
              const SizedBox(height: 4),
              Text(
                dateText,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Text(
              notification.message ?? '',
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
