import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final userName = order.user?.name ?? '';
    final userPhone = order.user?.phone ?? '';
    final cityName = order.address?.cityName ?? '';
    final addressLine = order.address?.addressLine ?? '';
    final note = order.address?.note ?? '';
    final driverPhone = order.driver?.phone;
    final supplierPhone = order.supplier?.phone;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (userName.isNotEmpty) ...[
              _buildDetailRow(Icons.person_outline, userName),
              const SizedBox(height: 12),
            ],
            if (userPhone.isNotEmpty) ...[
              _buildDetailRow(Icons.phone_android_outlined, userPhone),
              const SizedBox(height: 12),
            ],
            if (cityName.isNotEmpty) ...[
              _buildDetailRow(Icons.location_city_outlined, cityName),
              const SizedBox(height: 12),
            ],
            if (addressLine.isNotEmpty) ...[
              _buildDetailRow(Icons.location_on_outlined, addressLine),
              const SizedBox(height: 12),
            ],
            if (note.isNotEmpty) ...[
              _buildDetailRow(Icons.note, note),
              const SizedBox(height: 12),
            ],
            if (driverPhone != null && driverPhone.trim().isNotEmpty) ...[
              _buildDetailRow(Icons.local_shipping_outlined, driverPhone),
              const SizedBox(height: 12),
            ],
            if (supplierPhone != null && supplierPhone.trim().isNotEmpty)
              _buildDetailRow(Icons.store_outlined, supplierPhone),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}
