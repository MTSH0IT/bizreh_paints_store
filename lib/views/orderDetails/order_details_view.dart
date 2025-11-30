import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/models/order_model/item.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_id_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_items_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_summary_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/shipping_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    return '$d/$m/$y';
  }

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
                      final messageController = TextEditingController();
                      Get.defaultDialog(
                        title: 'إرسال شكوى',
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),
                            TextField(
                              controller: messageController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'اكتب الشكوى هنا',
                              ),
                            ),
                          ],
                        ),
                        textConfirm: 'إرسال',
                        textCancel: 'إلغاء',
                        onConfirm: () async {
                          final msg = messageController.text.trim();
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
                datePlaced: _formatDate(order.createdAt),
                dateDelivered: _formatDate(order.updatedAt),
                statusLabel: order.status ?? '',
              ),
              const SizedBox(height: 12),
              OrderItemsCard(items: items),
              const SizedBox(height: 12),
              OrderSummaryCard(
                subtotal: totalAmount.toStringAsFixed(2),
                discountAmount: discountAmount.toStringAsFixed(2),
                finalAmount: finalAmount.toStringAsFixed(2),
              ),
              const SizedBox(height: 12),
              ShippingDetails(
                name: order.userName ?? '',
                phone: order.userPhone ?? '',
                address: order.addressLine ?? '',
                nickname: order.cityId?.toString() ?? '',
                note: '',
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
