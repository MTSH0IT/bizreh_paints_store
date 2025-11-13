import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/models/product_model.dart';
import 'package:bizreh_paints_store/models/banner_model.dart';
import 'package:bizreh_paints_store/models/brands_featured_model/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/productb_model.dart';
import 'package:bizreh_paints_store/utils/api_response.dart';
import 'package:bizreh_paints_store/services/brands_services.dart';
import 'dart:async';

class HomeController extends GetxController {
  PageController pageController = PageController(viewportFraction: 0.9);

  Timer? _bannerTimer;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxList<BrandModel> brands = <BrandModel>[].obs;
  RxList<ProductbModel> brandProducts = <ProductbModel>[].obs;
  RxInt currentBannerIndex = 0.obs;

  RxBool isLoading = false.obs;
  RxBool isBrandsFeaturedLoading = false.obs;
  RxBool isBrandsLoading = false.obs;
  RxBool isBrandProductsLoading = false.obs;

  Rxn<Pagination> brandProductsPagination = Rxn<Pagination>();

  final BrandsServices _brandsServices = BrandsServices();

  @override
  void onInit() {
    super.onInit();
    loadBanners();
    loadProducts();
    loadFeaturedBrands();
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

  Future<void> loadFeaturedBrands() async {
    isBrandsFeaturedLoading.value = true;
    try {
      final list = await _brandsServices.getFeaturedBrands();
      featuredBrands.assignAll(list);
      isBrandsFeaturedLoading.value = false;
    } on AppException catch (e) {
      log("home controller AppException featured brands : ${e.message}");
    } catch (e) {
      log("home controller catch featured brands : ${e.toString()}");
    } finally {
      isBrandsFeaturedLoading.value = false;
    }
  }

  Future<void> loadBrands() async {
    isBrandsLoading.value = true;
    try {
      final list = await _brandsServices.getBrands();
      brands.assignAll(list);
      isBrandsLoading.value = false;
    } on AppException catch (e) {
      log("home controller AppException brands : ${e.message}");
    } catch (e) {
      log("home controller catch brands : ${e.toString()}");
    } finally {
      isBrandsLoading.value = false;
    }
  }

  Future<void> loadBrandProducts({
    required int brandId,
    int page = 1,
    int limit = 20,
    bool append = false,
  }) async {
    isBrandProductsLoading.value = true;
    try {
      final api = await _brandsServices.getBrandProducts(
        brandId: brandId,
        page: page,
        limit: limit,
      );
      final data = api.data ?? <ProductbModel>[];
      brandProductsPagination.value = api.pagination;
      if (append) {
        brandProducts.addAll(data);
      } else {
        brandProducts.assignAll(data);
      }
    } on AppException catch (e) {
      log("home controller AppException brand products : ${e.message}");
    } catch (e) {
      log("home controller catch brand products : ${e.toString()}");
    } finally {
      isBrandProductsLoading.value = false;
    }
  }
}
