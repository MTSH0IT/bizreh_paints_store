import 'package:bizreh_paints_store/views/orderDetails/widgets/order_id_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_items_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/order_summary_card.dart';
import 'package:bizreh_paints_store/views/orderDetails/widgets/shipping_details.dart';
import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          OrderIdCard(
            orderNo: '3456-7890',
            datePlaced: '01/15/2025',
            dateDelivered: '01/15/2025',
            statusLabel: 'Delivered',
          ),
          const SizedBox(height: 12),
          OrderItemsCard(),
          const SizedBox(height: 12),
          OrderSummaryCard(
            subtotal: '30.00',
            shipping: '10.00',
            total: '40.00',
          ),
          const SizedBox(height: 12),
          ShippingDetails(
            name: 'John Doe',
            phone: '123-456-7890',
            address: '123 Main St',
            nickname: 'home',
            note: 'note',
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
