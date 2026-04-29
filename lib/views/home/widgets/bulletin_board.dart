import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/models/ads_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';

class BulletinBoard extends StatelessWidget {
  BulletinBoard({super.key});
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isAdsLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(40.0),
          child: BuildProgressIndicator(),
        );
      }
      if (controller.ads.isEmpty) {
        return SizedBox(
          height: 120,
          child: Center(child: Text('home.no_banners'.tr())),
        );
      }

      return Column(
        children: [
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.ads.length,
              itemBuilder: (context, index) {
                final AdsModel ads = controller.ads[index];
                return _BannerCard(banner: ads);
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(controller.ads.length, (i) {
              final isActive = i == controller.currentBannerIndex.value;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: isActive ? 16 : 6,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blueGrey : Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}

class _BannerCard extends StatelessWidget {
  final AdsModel banner;

  const _BannerCard({required this.banner});

  void _showAdDialog(BuildContext context) {
    final description = context.localizedValue(
      en: banner.description,
      ar: banner.arDescription,
      fallback: '',
    );

    if (description.trim().isEmpty) return;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          context.localizedValue(
            en: banner.title,
            ar: banner.arTitle,
            fallback: '',
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        content: Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'cart.ok'.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasDescription = context
        .localizedValue(
          en: banner.description,
          ar: banner.arDescription,
          fallback: '',
        )
        .trim()
        .isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: hasDescription ? () => _showAdDialog(context) : null,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ImageNetwork(image: banner.image ?? ""),
                Positioned(
                  left: 16,
                  top: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localizedValue(
                          en: banner.title,
                          ar: banner.arTitle,
                          fallback: '',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
