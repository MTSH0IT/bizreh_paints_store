import 'package:bizreh_paints_store/models/available_gifts_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:flutter/material.dart';

class AvailableGiftCard extends StatelessWidget {
  final AvailableGiftsModel gift;
  final bool isRedeeming;
  final VoidCallback? onRedeem;

  const AvailableGiftCard({
    super.key,
    required this.gift,
    required this.isRedeeming,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    final title = gift.title ?? '';
    final points = gift.points ?? 0;
    final image = gift.image ?? '';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 56,
                  height: 56,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '$points Points',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          // decoration: BoxDecoration(
                          //   color: canRedeem
                          //       ? const Color(
                          //           0xFF16A34A,
                          //         ).withValues(alpha: 0.12)
                          //       : const Color(
                          //           0xFFDC2626,
                          //         ).withValues(alpha: 0.10),
                          //   borderRadius: BorderRadius.circular(999),
                          // ),
                          // child: Text(
                          //   canRedeem ? 'Redeemable' : 'Not redeemable',
                          //   style: TextStyle(
                          //     color: canRedeem
                          //         ? const Color(0xFF16A34A)
                          //         : const Color(0xFFDC2626),
                          //     fontWeight: FontWeight.w800,
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: isRedeeming ? null : onRedeem,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isRedeeming
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Redeem',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
