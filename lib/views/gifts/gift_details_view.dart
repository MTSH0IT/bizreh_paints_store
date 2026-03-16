import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class GiftDetailsView extends StatelessWidget {
  const GiftDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GiftsController>();

    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'gifts.title'),
      body: SafeArea(
        child: Obx(() {
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

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ImageNetwork(image: gift.image ?? ''),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${gift.points ?? 0} ${tr('gifts.points')}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
