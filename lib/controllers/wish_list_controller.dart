import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/models/wishlist_model.dart';
import 'package:bizreh_paints_store/services/wishList_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';

class WishListController extends GetxController {
  final wishListServices = WishListServices();
  final RxList<WishlistModel> items = <WishlistModel>[].obs;
  final RxBool isGetLoading = false.obs;
  final RxBool isAddRemoveLoading = false.obs;
  final RxInt removingId = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadWishListProducts();
  }

  Future<void> loadWishListProducts() async {
    isGetLoading.value = true;
    try {
      final list = await wishListServices.getWishlist();
      items.assignAll(list);
      isGetLoading.value = false;
    } on AppException catch (e) {
      log("wish list controller AppException : ${e.message}");
    } catch (e) {
      log("wish list controller catch : ${e.toString()}");
    } finally {
      isGetLoading.value = false;
    }
  }

  Future<void> addToWishList(int id) async {
    if (id < 0) {
      showMassage("اختر عنصر لأضافته الى المفضلة", false);
      return;
    }
    isAddRemoveLoading.value = true;
    try {
      await wishListServices.addWishlistItems(productOptionId: id);
      await loadWishListProducts();
      isAddRemoveLoading.value = false;
    } on AppException catch (e) {
      log("wish list controller AppException : ${e.message}");
    } catch (e) {
      log("wish list controller catch : ${e.toString()}");
    } finally {
      isAddRemoveLoading.value = false;
    }
  }

  Future<void> toggle(ProductModel product) async {
    if (isFavorite(product.id!)) {
      await removeItem(product.id!);
    } else {
      await addToWishList(product.id!);
    }
  }

  Future<void> removeItem(int id) async {
    isAddRemoveLoading.value = true;
    removingId.value = id;
    try {
      await wishListServices.removeWishlistItem(wishlistId: id);
      items.removeWhere((e) => e.id == id);
      isAddRemoveLoading.value = false;
    } on AppException catch (e) {
      log("wish list controller AppException : ${e.message}");
    } catch (e) {
      log("wish list controller catch : ${e.toString()}");
    } finally {
      isAddRemoveLoading.value = false;
    }
  }

  bool isFavorite(int id) {
    return items.any((item) => item.id == id);
  }

  void addToCart(ProductModel product) {
    final cartController = Get.find<MyCartController>();
    cartController.addToCart(product);

    Get.snackbar(
      'تمت الإضافة',
      '${product.title} تم إضافته إلى السلة',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
