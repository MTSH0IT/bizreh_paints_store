import 'package:bizreh_paints_store/models/points_history_model/order_item.dart';
import 'package:bizreh_paints_store/models/points_history_model/points_history_model.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PointsHistoryItem extends StatelessWidget {
  final PointsHistoryModel item;
  final VoidCallback? onTap;

  const PointsHistoryItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSpent = (item.pointsType ?? '').toLowerCase() == 'spent';
    final mainColor = isSpent
        ? const Color(0xFFDC2626)
        : const Color(0xFF16A34A);
    final pointsValue = item.points ?? 0;
    final absPoints = pointsValue.abs();
    final date = formatDate(item.createdAt);
    final details = item.orderDetails;
    final giftDetails = item.giftDetails;
    final orderItem = details?.orderItem;

    final typeTitle = _buildTypeTitle(context);
    final sourceText = _cleanText(item.sourceDescription);
    final productTitle = _buildProductTitle(orderItem, context.locale.languageCode);
    final actionText = _buildActionText();

    final content = Container(
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
                  isSpent ? Icons.card_giftcard : Icons.shopping_bag_outlined,
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
                      typeTitle,
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
              Text(
                '${isSpent ? '-' : '+'}$absPoints',
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
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
                label: '${tr('points.type')}: ${item.pointsType ?? '---'}',
                color: mainColor,
              ),
              _buildChip(
                label: '${tr('points.reference')}: ${item.referenceId ?? '---'}',
                color: const Color(0xFF334155),
              ),
              _buildChip(
                label:
                    '${tr('points.reference_type')}: ${item.referenceTypeAr ?? item.referenceType ?? '---'}',
                color: const Color(0xFF1D4ED8),
              ),
            ],
          ),
          if (sourceText.isNotEmpty) ...[
            const SizedBox(height: 10),
            _buildSectionTitle(tr('points.source')),
            const SizedBox(height: 4),
            Text(
              sourceText,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
          if (details != null) ...[
            const SizedBox(height: 10),
            _buildSectionTitle(tr('points.order_details')),
            const SizedBox(height: 8),
            _buildDetailRow(
              tr('points.order_number'),
              _cleanText(details.orderNumber, fallback: '#${details.orderId ?? '---'}'),
            ),
            _buildDetailRow(
              tr('points.order_status'),
              _cleanText(details.status),
            ),
            _buildDetailRow(
              tr('points.order_total'),
              details.totalAmount?.toString() ?? '---',
            ),
            if (productTitle.isNotEmpty)
              _buildDetailRow(tr('points.product'), productTitle),
            if (orderItem != null) ...[
              _buildDetailRow(
                tr('points.quantity'),
                orderItem.quantity?.toString() ?? '---',
              ),
              _buildDetailRow(
                tr('points.unit_price'),
                orderItem.unitPrice?.toString() ?? '---',
              ),
              _buildDetailRow(
                tr('points.total_price'),
                orderItem.totalPrice?.toString() ?? '---',
              ),
            ],
          ],
          if (giftDetails != null) ...[
            const SizedBox(height: 10),
            _buildSectionTitle(tr('points.gift_details')),
            const SizedBox(height: 8),
            _buildDetailRow(
              tr('points.gift_name'),
              _cleanText(
                context.locale.languageCode == 'ar'
                    ? giftDetails.arTitle
                    : giftDetails.title,
                fallback: _cleanText(giftDetails.title, fallback: giftDetails.arTitle),
              ),
            ),
            _buildDetailRow(
              tr('points.gift_points'),
              giftDetails.points?.toString() ?? '---',
            ),
            _buildDetailRow(
              tr('points.gift_status'),
              _cleanText(giftDetails.status),
            ),
            _buildDetailRow(
              tr('points.redeemed_at'),
              formatDate(giftDetails.redeemedAt),
            ),
          ],
          if (onTap != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      actionText,
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12, color: mainColor),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: content,
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

  String _buildTypeTitle(BuildContext context) {
    final text = _cleanText(item.referenceTypeAr, fallback: item.referenceType);
    if (text.isNotEmpty) return text;
    final isSpent = (item.pointsType ?? '').toLowerCase() == 'spent';
    return isSpent ? tr('points.gift_redemption') : tr('points.order_earning');
  }

  String _buildProductTitle(OrderItem? orderItem, String localeCode) {
    final ar = _cleanText(orderItem?.product?.arTitle);
    final en = _cleanText(orderItem?.product?.title);
    if (localeCode == 'ar' && ar.isNotEmpty) return ar;
    if (en.isNotEmpty) return en;
    return ar;
  }

  String _buildActionText() {
    final isSpent = (item.pointsType ?? '').toLowerCase() == 'spent';
    return isSpent ? tr('points.open_gift') : tr('points.open_order');
  }

  String _cleanText(String? text, {String? fallback}) {
    final value = text?.trim() ?? '';
    if (value.isNotEmpty) return value;
    return fallback?.trim() ?? '';
  }
}
