import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';

class AllProductsView extends StatelessWidget {
  AllProductsView({super.key});
  final contr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Obx(() {
          if (contr.isLoading.value) {
            return const BuildProgressIndicator();
          }

          if (contr.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            child: ProductsGrid(
              isNeverScrollable: false,
              products: contr.products,
            ),
          );
        }),
      ),
    );
  }
}
