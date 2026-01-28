import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/gift_card.dart';
import 'widgets/gifts_empty_state.dart';

class AllGiftsView extends StatelessWidget {
  const AllGiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GiftsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Gifts'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        if (ctrl.isLoadingGifts.value && ctrl.gifts.isEmpty) {
          return const BuildProgressIndicator();
        }

        if (ctrl.gifts.isEmpty) {
          return const GiftsEmptyState(
            title: 'No gifts found',
            subtitle: 'Try again later.',
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
    );
  }
}
