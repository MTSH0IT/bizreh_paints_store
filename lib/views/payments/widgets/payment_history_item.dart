import 'package:bizreh_paints_store/models/payments_model/payment.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentHistoryItem extends StatelessWidget {
  final Payment item;

  const PaymentHistoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isRegular = (item.type ?? '').toLowerCase() == 'regular';
    final mainColor = isRegular
        ? const Color(0xFF16A34A)
        : const Color(0xFF1D4ED8);

    final amount = double.tryParse(item.amount ?? '') ?? 0;
    final date = formatDate(item.createdAt);
    final fullName = _buildFullName(item.firstName, item.lastName);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: mainColor.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isRegular ? Icons.payments_outlined : Icons.card_giftcard,
                  color: mainColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.type ?? tr('payments.unknown_type'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date.isEmpty ? '---' : date,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Text(
                  formatPrice(amount),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip(
                label: '${tr('payments.id')}: ${item.id ?? '---'}',
                color: const Color(0xFF334155),
              ),
              _buildChip(
                label: '${tr('payments.user_id')}: ${item.userId ?? '---'}',
                color: const Color(0xFF0F766E),
              ),
            ],
          ),
          if (_cleanText(item.notes).isNotEmpty) ...[
            const SizedBox(height: 10),
            _buildSectionTitle(tr('payments.notes')),
            const SizedBox(height: 4),
            Text(
              _cleanText(item.notes),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 10),
          _buildSectionTitle(tr('payments.customer_info')),
          const SizedBox(height: 8),
          _buildDetailRow(tr('payments.name'), fullName),
          _buildDetailRow(tr('payments.email'), _cleanText(item.email)),
          _buildDetailRow(tr('payments.phone'), _cleanText(item.phone)),
        ],
      ),
    );
  }

  Widget _buildChip({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 108,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '---' : value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildFullName(String? firstName, String? lastName) {
    final first = _cleanText(firstName);
    final last = _cleanText(lastName);
    if (first.isEmpty && last.isEmpty) {
      return '';
    }
    return '$first $last'.trim();
  }

  String _cleanText(String? text) {
    return text?.trim() ?? '';
  }
}
