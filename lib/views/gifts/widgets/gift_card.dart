import 'package:bizreh_paints_store/models/gifts_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final GiftsModel gift;

  const GiftCard({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: gift.title,
      ar: gift.arTitle,
      fallback: '',
    );
    final points = gift.points ?? 0;
    final image = gift.image ?? '';
    //final isAvailable = gift.isAvailable ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 72,
              height: 72,
              child: ImageNetwork(image: image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$points ${tr('gifts.points')}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // const SizedBox(height: 8),
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 10,
                //     vertical: 6,
                //   ),
                //   decoration: BoxDecoration(
                //     color: isAvailable
                //         ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                //         : const Color(0xFFDC2626).withValues(alpha: 0.10),
                //     borderRadius: BorderRadius.circular(999),
                //   ),
                //   child: Text(
                //     isAvailable
                //         ? tr('gifts.available')
                //         : tr('gifts.not_available'),
                //     style: TextStyle(
                //       color: isAvailable
                //           ? const Color(0xFF16A34A)
                //           : const Color(0xFFDC2626),
                //       fontWeight: FontWeight.w700,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
