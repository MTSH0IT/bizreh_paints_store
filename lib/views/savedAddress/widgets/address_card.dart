import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AddressCard({
    super.key,
    required this.address,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon, title, default badge, and action buttons
          Row(
            children: [
              // Icon and title
              Row(
                children: [
                  Icon(Icons.location_on, color: primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    address.nickname,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: primaryColor, size: 20),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      color: primaryColor,
                      size: 20,
                    ),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Full name
          Text(
            address.city,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // Address
          Text(
            address.address,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          // Notes
          Text(
            'Notes: ${address.notes}',
            style: TextStyle(fontSize: 12, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
