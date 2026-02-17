import 'package:bizreh_paints_store/models/gifts_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AllGiftTile extends StatelessWidget {
  final GiftsModel gift;

  const AllGiftTile({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: gift.title,
      ar: gift.arTitle,
      fallback: '',
    );
    final points = gift.points ?? 0;
    final image = gift.image ?? '';

    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 72,
              width: double.infinity,
              child: ImageNetwork(image: image),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$points ${'gifts.points'.tr()}',
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
