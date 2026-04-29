import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool? isDefaultAddress;
  final bool? isSelcted;

  const AddressCard({
    super.key,
    required this.address,
    this.isDefaultAddress,
    this.isSelcted,
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
        border: Border.all(
          color: isSelcted == true ? primaryColor : Colors.grey[300]!,
          width: isSelcted == true ? 2 : 1,
        ),
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
                    address.nickname ?? tr('address.nickname_default'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (isDefaultAddress == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tr('address.default'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),

              if (onEdit != null || onDelete != null)
                Row(
                  children: [
                    if (onEdit != null)
                      IconButton(
                        onPressed: onEdit,
                        icon: Icon(Icons.edit, color: primaryColor, size: 20),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    // if (onEdit != null && onDelete != null)
                    const SizedBox(width: 4),
                    if (onDelete != null)
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
            context.localizedValue(
                en: address.cityName, ar: address.arCityName),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // Address
          Text(
            address.addressLine ?? tr('address.line_default'),
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          // Notes
          Text(
            '${tr('address.notes')}: ${address.note ?? tr('address.note_default')}',
            style: TextStyle(fontSize: 12, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
