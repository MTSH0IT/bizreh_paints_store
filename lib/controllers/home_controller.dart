import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/models/product_model.dart';
import 'package:bizreh_paints_store/models/banner_model.dart';
import 'dart:async';

class HomeController extends GetxController {
  PageController pageController = PageController(viewportFraction: 0.92);

  Timer? _bannerTimer;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxInt currentBannerIndex = 0.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBanners();
    loadProducts();
    pageController.addListener(_onPageChanged);
  }

  @override
  void onReady() {
    super.onReady();
    _startBannerAutoScroll();
  }

  @override
  void onClose() {
    pageController.removeListener(_onPageChanged);
    pageController.dispose();
    _bannerTimer?.cancel();
    super.onClose();
  }

  void _onPageChanged() {
    if (!pageController.hasClients) return;
    final p = pageController.page;
    if (p != null) {
      currentBannerIndex.value = p.round();
    }
  }

  void loadProducts() {
    isLoading.value = true;

    products.value = demoProducts;
    isLoading.value = false;
  }

  void loadBanners() {
    banners.value = demoBanners;
    // Restart auto scroll if banners are reloaded
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    if (banners.isEmpty) return;
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!pageController.hasClients) return;
      final current = pageController.page?.round() ?? 0;
      int nextPage = current + 1;
      if (nextPage >= banners.length) nextPage = 0;
      if (pageController.hasClients) {
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
