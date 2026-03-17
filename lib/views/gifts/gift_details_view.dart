import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/models/gifts_model.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class GiftDetailsView extends StatelessWidget {
  GiftDetailsView({super.key});
  final ctrl = Get.find<GiftsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'gifts.title'),
      body: Obx(() {
        if (ctrl.isLoadingSelectedGift.value) {
          return const BuildProgressIndicator();
        }

        if (ctrl.selectedGiftError.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ctrl.selectedGiftError.value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          );
        }

        final gift = ctrl.selectedGift.value;
        if (gift == null) {
          return Center(child: Text(tr('order_details.no_data')));
        }

        final title = context.localizedValue(
          en: gift.title,
          ar: gift.arTitle,
          fallback: '',
        );

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image with Gradient Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ImageNetwork(image: gift.image ?? ''),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${gift.points ?? 0} ${tr('gifts.points')}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Content Section
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: gift.isAvailable == true
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: gift.isAvailable == true
                                  ? Colors.green
                                  : Colors.red,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            gift.isAvailable == true
                                ? tr('gifts.available')
                                : tr('gifts.not_available'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: gift.isAvailable == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (gift.totalRedemptions != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${tr('gifts.redeemed')}: ${gift.totalRedemptions}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Gift Details
                    _buildDetailRow(
                      context,
                      tr('gifts.title'),
                      title,
                      Icons.card_giftcard,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      context,
                      tr('gifts.points'),
                      '${gift.points ?? 0} ${tr('gifts.points')}',
                      Icons.star,
                    ),
                    const SizedBox(height: 16),
                    if (gift.createdAt != null)
                      _buildDetailRow(
                        context,
                        tr('gifts.created_date'),
                        formatDate(gift.createdAt!),
                        Icons.calendar_today,
                      ),
                    const SizedBox(height: 16),
                    if (gift.totalRedemptions != null)
                      _buildDetailRow(
                        context,
                        tr('gifts.total_redemptions'),
                        '${gift.totalRedemptions}',
                        Icons.people,
                      ),
                  ],
                ),
              ),

              // Action Button
              if (gift.isAvailable == true && gift.id != null)
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Obx(() {
                    final isRedeeming = ctrl.redeemingGiftId.value == gift.id;
                    return MainButton(
                      title: isRedeeming
                          ? tr('gifts.redeeming')
                          : tr('gifts.redeem'),
                      onPressed: isRedeeming
                          ? null
                          : () => _showRedemptionConfirmation(context, gift),
                    );
                  }),
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.amber, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRedemptionConfirmation(BuildContext context, GiftsModel gift) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('gifts.confirm_redemption')),
        content: Text(
          tr(
            'gifts.confirm_redemption_message',
            args: [
              context.localizedValue(
                en: gift.title,
                ar: gift.arTitle,
                fallback: '',
              ),
              '${gift.points ?? 0}',
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('common.cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ctrl.redeemGift(gift.id!);
            },
            child: Text(tr('gifts.confirm')),
          ),
        ],
      ),
    );
  }
}
