import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/models/sub_categorey_model.dart';
import 'package:bizreh_paints_store/services/brands_services.dart';
import 'package:bizreh_paints_store/services/category_services.dart';
import 'package:bizreh_paints_store/services/filter_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final BrandsServices _brandsServices;
  final CategoryServices _categoryServices;
  final FilterServices _filterServices;

  FilterController({
    required BrandsServices brandsServices,
    required CategoryServices categoryServices,
    required FilterServices filterServices,
  }) : _brandsServices = brandsServices,
       _categoryServices = categoryServices,
       _filterServices = filterServices;

  final TextEditingController queryController = TextEditingController();

  final RxList<BrandModel> brands = <BrandModel>[].obs;
  final RxList<SubCategoreyModel> subCategories = <SubCategoreyModel>[].obs;

  final RxnInt selectedBrandId = RxnInt();
  final RxnInt selectedSubCategoryId = RxnInt();

  final RxBool isOptionsLoading = false.obs;
  final RxBool isSearching = false.obs;

  final RxList<ProductModel> results = <ProductModel>[].obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadOptions();
  }

  @override
  void onClose() {
    queryController.dispose();
    super.onClose();
  }

  Future<void> loadOptions() async {
    isOptionsLoading.value = true;
    try {
      final loadedBrands = await _brandsServices.getBrands();
      final loadedSub = await _categoryServices.getSubCategories();
      brands.assignAll(loadedBrands);
      subCategories.assignAll(loadedSub);
    } on AppException catch (e) {
      log('search controller AppException load options : ${e.message}');
    } catch (e) {
      log('search controller catch load options : ${e.toString()}');
    } finally {
      isOptionsLoading.value = false;
    }
  }

  void setBrand(int? id) {
    selectedBrandId.value = id;
  }

  void setSubCategory(int? id) {
    selectedSubCategoryId.value = id;
  }

  void clearFilters() {
    selectedBrandId.value = null;
    selectedSubCategoryId.value = null;
    queryController.clear();
    results.clear();
    errorMessage.value = '';
  }

  Future<void> search({bool reset = true}) async {
    if (isSearching.value) return;

    isSearching.value = true;
    errorMessage.value = '';
    try {
      final api = await _filterServices.searchProducts(
        brand: selectedBrandId.value,
        subCategory: selectedSubCategoryId.value,
        query: queryController.text.trim().isEmpty
            ? null
            : queryController.text.trim(),
      );
      final data = api.data ?? <ProductModel>[];
      if (reset) {
        results.assignAll(data);
      } else {
        results.addAll(data);
      }
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isSearching.value = false;
    }
  }
}
