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
    if (pageController.page != null) {
      currentBannerIndex.value = pageController.page!.round();
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
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int nextPage = (pageController.page!.round()) + 1;
      if (nextPage >= banners.length) nextPage = 0;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
