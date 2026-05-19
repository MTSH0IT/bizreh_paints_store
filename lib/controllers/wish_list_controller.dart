import 'dart:developer';

import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/wishlist_model/wishlist_model.dart';
import 'package:bizreh_paints_store/services/wishList_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class WishListController extends GetxController {
  final WishListServices _wishListServices;

  WishListController({required WishListServices wishListServices})
    : _wishListServices = wishListServices;
  final RxList<WishlistModel> items = <WishlistModel>[].obs;
  final RxBool isGetLoading = false.obs;
  final RxBool isAddRemoveLoading = false.obs;
  final RxInt removingId = (-1).obs;
  final RxInt movingToCartId = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadWishListProducts();
  }

  Future<void> loadWishListProducts() async {
    isGetLoading.value = true;
    try {
      final list = await _wishListServices.getWishlist();
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
      showMassage(tr('common.please_select_item_to_add'), false);
      return;
    }
    isAddRemoveLoading.value = true;
    try {
      await _wishListServices.addWishlistItems(optionPackagingId: id);
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

  Future<void> clearAll() async {
    if (items.isEmpty) return;
    isAddRemoveLoading.value = true;
    try {
      await _wishListServices.clearWishlist();
      items.clear();
      showMassage(tr('common.deleted_successfully'), true);
    } on AppException catch (e) {
      log("wish list controller AppException clear : ${e.message}");
    } catch (e) {
      log("wish list controller catch clear : ${e.toString()}");
    } finally {
      isAddRemoveLoading.value = false;
    }
  }

  Future<void> removeItem(int id) async {
    isAddRemoveLoading.value = true;
    removingId.value = id;
    try {
      await _wishListServices.removeWishlistItem(wishlistId: id);
      items.removeWhere((e) => e.optionPackagingId == id);
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
    return items.any((item) => item.optionPackagingId == id);
  }

  Future<void> addWishlistItemToCart(
    WishlistModel wishlistItem, {
    required int quantity,
  }) async {
    movingToCartId.value = wishlistItem.optionPackagingId!;
    try {
      final cartController = Get.find<CartController>();
      await cartController.addToCart(
        optionPackagingId: wishlistItem.optionPackagingId!,
        //colorFamilyId: wishlistItem.colorFamilyId!,
        quantity: quantity,
      );
    } catch (e) {
      // Error already handled in CartController
    } finally {
      movingToCartId.value = -1;
    }
  }
}
