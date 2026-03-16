import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

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
          Text(
            tr('gifts.title'),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          TextButton(
            onPressed: () {
              if (ctrl.gifts.isEmpty) {
                ctrl.loadGifts();
              }
              Get.to(() => const AllGiftsView());
            },
            child: Text(
              tr('gifts.view_all'),
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
