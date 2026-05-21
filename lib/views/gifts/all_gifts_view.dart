import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import 'widgets/gift_card.dart';
import 'widgets/gifts_empty_state.dart';

class AllGiftsView extends StatelessWidget {
  const AllGiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GiftsController>();

    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'gifts.title'),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Obx(() {
              if (ctrl.isLoadingGifts.value && ctrl.gifts.isEmpty) {
                return const BuildProgressIndicator();
              }

              if (ctrl.gifts.isEmpty) {
                return GiftsEmptyState(
                  title: tr('gifts.no_gifts_found'),
                  subtitle: tr('gifts.try_again_later'),
                );
              }

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: ctrl.gifts.length,
                itemBuilder: (context, index) {
                  final gift = ctrl.gifts[index];
                  return GiftCard(gift: gift);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
