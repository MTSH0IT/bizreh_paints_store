import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_id_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_items_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_summary_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/shipping_details.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/views/orderDetails/widgets/qr_code_button.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: CommonAppBar(
        titleKey: 'order_details.title',
        actions: [
          Obx(() {
            final order = orderController.selectedOrderDetails.value;
            if (order == null || order.id == null) {
              return const SizedBox.shrink();
            }
            /* 
            return IconButton(
              icon: const Icon(Icons.report_problem_outlined),
              tooltip: tr('order_details.send_complaint'),
              onPressed: orderController.isSubmitting.value
                  ? null
                  : () {
                      showTextInputDialog(
                        title: tr('order_details.complaint_title'),
                        hintText: tr('order_details.complaint_hint'),
                        maxLines: 3,
                        confirmText: tr('order_details.send'),
                        cancelText: tr('order_details.cancel'),
                        onConfirm: (controller) async {
                          final msg = controller.text.trim();
                          if (msg.isEmpty) {
                            return;
                          }
                          Get.back();
                          await orderController.complaint(order.id!, msg);
                        },
                      );
                    },
            );
            */

            return QrCodeButton(orderNumber: order.orderNumber.toString());
          }),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (orderController.isOrderDetailsLoading.value) {
            return const BuildProgressIndicator();
          }

          if (orderController.orderDetailsError.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  orderController.orderDetailsError.value,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final order = orderController.selectedOrderDetails.value;
          if (order == null) {
            return Center(child: Text(tr('order_details.no_data')));
          }

          return ListView(
            children: [
              OrderIdCard(
                order: order,
                datePlaced: formatDate(order.createdAt),
              ),
              const SizedBox(height: 12),
              OrderItemsCard(order: order),
              const SizedBox(height: 12),
              OrderSummaryCard(order: order),
              const SizedBox(height: 12),
              ShippingDetails(order: order),
              const SizedBox(height: 12),
              if (order.id != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: MainButton(
                    onPressed: orderController.isSubmitting.value
                        ? null
                        : () async {
                            await orderController.reorder(
                              order.id!,
                              <String, dynamic>{},
                            );
                          },
                    title: orderController.isSubmitting.value
                        ? tr('order_details.reordering')
                        : tr('order_details.reorder'),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
