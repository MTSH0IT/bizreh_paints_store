import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../all_gifts_view.dart';

class AllGiftsSection extends StatelessWidget {
  final GiftsController ctrl;

  const AllGiftsSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'All Gifts',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          TextButton(
            onPressed: () {
              if (ctrl.gifts.isEmpty) {
                ctrl.loadGifts();
              }
              Get.to(() => const AllGiftsView());
            },
            child: const Text(
              'View All',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
