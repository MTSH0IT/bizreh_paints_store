import 'package:bizreh_paints_store/views/orderDetails/order_details_view.dart';
import 'package:flutter/material.dart';
import 'widgets/order_history_item.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'no': '3456-7890',
        'date': '01/15/2025',
        'amount': 125.50,
        'status': 'Delivered',
      },
      {
        'no': '3456-7889',
        'date': '12/28/2025',
        'amount': 89.99,
        'status': 'Shipped',
      },
      {
        'no': '3456-7888',
        'date': '12/20/2025',
        'amount': 210.00,
        'status': 'Processing',
      },
      {
        'no': '3456-7887',
        'date': '11/05/2025',
        'amount': 76.20,
        'status': 'Delivered',
      },
      {
        'no': '3456-7886',
        'date': '10/18/2025',
        'amount': 150.75,
        'status': 'Delivered',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final o = orders[index];
          return OrderHistoryItem(
            orderNo: o['no'] as String,
            date: o['date'] as String,
            amount: o['amount'] as double,
            statusLabel: o['status'] as String,
            onAction: () {
              Get.to(() => const OrderDetailsView());
            },
          );
        },
      ),
    );
  }
}
