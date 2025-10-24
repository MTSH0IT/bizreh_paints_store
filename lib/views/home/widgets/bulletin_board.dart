import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/banner_model.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';

class BulletinBoard extends StatelessWidget {
  BulletinBoard({super.key});
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.banners.isEmpty) {
        return const SizedBox(
          height: 150,
          child: Center(child: Text('No banners available')),
        );
      }

      return Column(
        children: [
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.banners.length,
              itemBuilder: (context, index) {
                final BannerModel banner = controller.banners[index];
                return _BannerCard(banner: banner);
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(controller.banners.length, (i) {
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
  final BannerModel banner;

  const _BannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageNetwork(image: banner.image),
            Positioned(
              left: 16,
              top: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    banner.subtitle,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
