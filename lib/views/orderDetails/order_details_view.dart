import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/models/order_model/item.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_id_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_items_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_summary_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/shipping_details.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/func/text_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Obx(() {
            final order = orderController.selectedOrderDetails.value;
            if (order == null || order.id == null) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: const Icon(Icons.report_problem_outlined),
              tooltip: 'إرسال شكوى',
              onPressed: orderController.isSubmitting.value
                  ? null
                  : () {
                      showTextInputDialog(
                        title: 'إرسال شكوى',
                        hintText: 'اكتب الشكوى هنا',
                        maxLines: 3,
                        confirmText: 'إرسال',
                        cancelText: 'إلغاء',
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
            return const Center(child: Text('لا توجد بيانات للطلب'));
          }

          final items = order.items ?? <Item>[];
          final totalAmount = order.totalAmount ?? 0.0;
          final discountAmount = order.discountAmount ?? 0.0;
          final finalAmount = order.finalAmount ?? 0.0;

          return ListView(
            children: [
              OrderIdCard(
                orderNo: order.orderNumber ?? order.id?.toString() ?? '',
                datePlaced: formatDate(order.createdAt),
                dateDelivered: formatDate(order.updatedAt),
                statusLabel: order.status ?? '',
              ),
              const SizedBox(height: 12),
              OrderItemsCard(items: items),
              const SizedBox(height: 12),
              OrderSummaryCard(
                subtotal: formatPrice(totalAmount),
                discountAmount: formatPrice(discountAmount),
                finalAmount: formatPrice(finalAmount),
              ),
              const SizedBox(height: 12),
              ShippingDetails(
                name: order.userName ?? '',
                phone: order.userPhone ?? '',
                address: order.addressLine ?? '',
                nickname: order.cityName ?? '',
                note: order.note ?? '',
              ),
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
                        ? 'جاري إعادة الطلب...'
                        : 'إعادة الطلب',
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
