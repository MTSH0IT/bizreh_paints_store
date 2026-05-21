import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';

class AllProductsView extends StatelessWidget {
  AllProductsView({super.key});
  final contr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'products.all.title'),
      body: SafeArea(
        child: Obx(() {
          if (contr.isLoading.value) {
            return const BuildProgressIndicator();
          }

          if (contr.products.isEmpty) {
            return Center(child: Text(tr('products.empty')));
          }
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ProductsGrid(
                  isNeverScrollable: false,
                  products: contr.products,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
