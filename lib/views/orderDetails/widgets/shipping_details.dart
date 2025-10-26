import 'package:flutter/material.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({
    super.key,
    required this.name,
    required this.phone,
    required this.nickname,
    required this.address,
    required this.note,
  });

  final String name;
  final String phone;
  final String nickname;
  final String address;
  final String note;

  @override
  Widget build(BuildContext context) {
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
            _buildDetailRow(Icons.person_outline, name),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.phone_android_outlined, phone),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.location_city_outlined, nickname),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.location_on_outlined, address),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.note, note),
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
