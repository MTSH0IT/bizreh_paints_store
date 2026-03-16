import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/orderDetails/order_details_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/text_input_dialog.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'widgets/order_history_item.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();

    if (orderController.orders.isEmpty &&
        !orderController.isHistoryLoading.value) {
      orderController.loadOrderHistory();
    }

    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'orders.history.title'),
      body: Obx(() {
        if (orderController.isHistoryLoading.value) {
          return const BuildProgressIndicator();
        }

        if (orderController.historyError.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                orderController.historyError.value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final orders = orderController.orders;
        if (orders.isEmpty) {
          return Center(child: Text(tr('orders.history.empty')));
        }

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final o = orders[index];
            final date = formatDate(o.createdAt);
            final amount = o.financialSummary?.total ?? 0.0;
            final status = o.status ?? '';

            return OrderHistoryItem(
              orderNo: o.orderNumber ?? '',
              date: date,
              amount: amount,
              statusLabel: status,
              onAction: () {
                if (o.id != null) {
                  orderController.loadOrderDetails(o.id!);
                  Get.to(() => const OrderDetailsView());
                }
              },
              onCancel: status == 'pending' && o.id != null
                  ? () {
                      showTextInputDialog(
                        title: tr('orders.cancel.title'),
                        hintText: tr('orders.cancel.reason_hint'),
                        maxLines: 2,
                        confirmText: tr('common.confirm'),
                        cancelText: tr('common.cancel'),
                        onConfirm: (controller) async {
                          String reason = controller.text.trim();
                          if (reason.isEmpty) {
                            reason = tr('orders.cancel.no_reason');
                          }
                          Get.back();
                          await orderController.cancelOrder(o.id!, reason);
                        },
                      );
                    }
                  : null,
            );
          },
        );
      }),
    );
  }
}
