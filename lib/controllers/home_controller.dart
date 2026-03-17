import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/ads_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/services/ads_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';

import 'package:bizreh_paints_store/services/brands_services.dart';
import 'package:bizreh_paints_store/services/product_services.dart';
import 'package:bizreh_paints_store/services/category_services.dart';
import 'package:bizreh_paints_store/models/category_tree/category_tree_model.dart';
import 'dart:async';

class HomeController extends GetxController {
  PageController pageController = PageController(viewportFraction: 0.9);

  Timer? _bannerTimer;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> subCategoryProducts = <ProductModel>[].obs;
  RxList<ProductModel> topSellingProducts = <ProductModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxList<BrandModel> brands = <BrandModel>[].obs;
  RxList<ProductModel> brandProducts = <ProductModel>[].obs;
  RxList<AdsModel> ads = <AdsModel>[].obs;
  RxInt currentBannerIndex = 0.obs;

  RxBool isLoading = false.obs;
  RxBool isSubCategoryProductsLoading = false.obs;
  RxBool isTopSellingLoading = false.obs;
  RxBool isBrandsFeaturedLoading = false.obs;
  RxBool isBrandsLoading = false.obs;
  RxBool isBrandProductsLoading = false.obs;
  RxBool isCategoryTreeLoading = false.obs;
  RxBool isAdsLoading = false.obs;

  final BrandsServices _brandsServices = BrandsServices();
  final ProductServices _productServices = ProductServices();
  final CategoryServices _categoryServices = CategoryServices();
  final AdsServices _adsServices = AdsServices();

  // Category tree state
  RxList<CategoryTreeModle> categoryTree = <CategoryTreeModle>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTopSelling();
    loadFeaturedBrands();
    loadCategoryTree();
    loadAds();
    pageController.addListener(_onPageChanged);
  }

  // Load category tree
  Future<void> loadCategoryTree() async {
    isCategoryTreeLoading.value = true;
    try {
      final list = await _categoryServices.getCategoryTree();
      categoryTree.assignAll(list);
    } on AppException catch (e) {
      log("home controller AppException category tree : ${e.message}");
    } catch (e) {
      log("home controller catch category tree : ${e.toString()}");
    } finally {
      isCategoryTreeLoading.value = false;
    }
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

  Future<void> loadAds() async {
    isAdsLoading.value = true;
    try {
      final list = await _adsServices.getAds();
      ads.assignAll(list);
      _startBannerAutoScroll();
      isAdsLoading.value = false;
    } on AppException catch (e) {
      log("home controller AppException ads : ${e.message}");
    } catch (e) {
      log("home controller catch ads : ${e.toString()}");
    } finally {
      isAdsLoading.value = false;
    }
  }

  void _onPageChanged() {
    if (!pageController.hasClients) return;
    final p = pageController.page;
    if (p != null) {
      currentBannerIndex.value = p.round();
    }
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    try {
      final api = await _productServices.getProducts();
      final data = api.data ?? [];
      products.assignAll(data);
    } on AppException catch (e) {
      log("home controller AppException products : ${e.message}");
    } catch (e) {
      log("home controller catch products : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSubCategoryProducts({int? subCategory = 1}) async {
    isSubCategoryProductsLoading.value = true;
    try {
      final api = await _productServices.getProducts(subCategory: subCategory);
      final data = api.data ?? [];
      subCategoryProducts.assignAll(data);
    } on AppException catch (e) {
      log("home controller AppException products : ${e.message}");
    } catch (e) {
      log("home controller catch products : ${e.toString()}");
    } finally {
      isSubCategoryProductsLoading.value = false;
    }
  }

  void _startBannerAutoScroll() {
    if (ads.isEmpty) return;
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!pageController.hasClients) return;
      final current = pageController.page?.round() ?? 0;
      int nextPage = current + 1;
      if (nextPage >= ads.length) nextPage = 0;
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

  Future<void> loadBrandProducts({required int brandId}) async {
    isBrandProductsLoading.value = true;
    try {
      final api = await _brandsServices.getBrandProducts(brandId: brandId);
      final data = api.data ?? <ProductModel>[];
      brandProducts.assignAll(data);
    } on AppException catch (e) {
      log("home controller AppException brand products : ${e.message}");
    } catch (e) {
      log("home controller catch brand products : ${e.toString()}");
    } finally {
      isBrandProductsLoading.value = false;
    }
  }

  Future<void> getTopSelling() async {
    isTopSellingLoading.value = true;
    try {
      final list = await _productServices.getTopSelling();
      topSellingProducts.assignAll(list);
    } on AppException catch (e) {
      log("home controller AppException top selling : ${e.message}");
    } catch (e) {
      log("home controller catch top selling : ${e.toString()}");
    } finally {
      isTopSellingLoading.value = false;
    }
  }
}
