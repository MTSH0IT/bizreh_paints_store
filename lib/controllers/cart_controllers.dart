import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/cart_model/cart_model.dart';
import 'package:bizreh_paints_store/services/cart_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartServices _cartServices;

  CartController({required CartServices cartServices})
    : _cartServices = cartServices;

  final RxBool isLoading = false.obs;
  final RxBool isMutating = false.obs;
  final Rxn<CartModel> cart = Rxn<CartModel>();

  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  Future<void> getCart() async {
    isLoading.value = true;
    try {
      final result = await _cartServices.getCart();
      cart.value = result;
    } on AppException catch (e) {
      log("cart controller AppException get cart : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("cart controller catch get cart : ${e.toString()}");
      showMassage("تعذر جلب السلة", false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart({
    required int optionPackagingId,
    int? colorFamilyId,
    required int quantity,
  }) async {
    isMutating.value = true;
    try {
      await _cartServices.addToCart(
        optionPackagingId: optionPackagingId,
        colorFamilyId: colorFamilyId,
        quantity: quantity,
      );
      await getCart();
      showMassage("تمت إضافة المنتج إلى السلة", true);
    } on AppException catch (e) {
      log("cart controller AppException add : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("cart controller catch add : ${e.toString()}");
      showMassage("تعذر إضافة المنتج", false);
    } finally {
      isMutating.value = false;
    }
  }

  Future<void> updateCartItem({
    required int cartItemId,
    required int quantity,
    //required int colorFamilyId,
  }) async {
    if (cartItemId <= 0 || quantity <= 0) {
      showMassage("البيانات غير مكتملة لتحديث العنصر", false);
      return;
    }
    isMutating.value = true;
    try {
      await _cartServices.updateCart(
        cartItemId: cartItemId,
        quantity: quantity,
        //colorFamilyId: colorFamilyId,
      );
      await getCart();
      showMassage("تم تحديث العنصر", true);
    } on AppException catch (e) {
      log("cart controller AppException update : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("cart controller catch update : ${e.toString()}");
      showMassage("تعذر تحديث العنصر", false);
    } finally {
      isMutating.value = false;
    }
  }

  Future<void> deleteCartItem(int cartItemId) async {
    if (cartItemId <= 0) {
      showMassage("العنصر غير صالح", false);
      return;
    }
    isMutating.value = true;
    try {
      await _cartServices.deleteCartItem(cartItemId: cartItemId);
      await getCart();
      showMassage("تم حذف العنصر من السلة", true);
    } on AppException catch (e) {
      log("cart controller AppException delete : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("cart controller catch delete : ${e.toString()}");
      showMassage("تعذر حذف العنصر", false);
    } finally {
      isMutating.value = false;
    }
  }

  Future<void> increaseQuantity({
    required int cartItemId,
    required int? quantity,
  }) async {
    if (cartItemId <= 0) {
      showMassage("البيانات غير مكتملة", false);
      return;
    }
    isMutating.value = true;
    try {
      await _cartServices.increaseCartItem(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      await getCart();
      showMassage("تمت زيادة الكمية", true);
    } on AppException catch (e) {
      log("cart controller AppException increase : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("cart controller catch increase : ${e.toString()}");
      showMassage("تعذر تعديل الكمية", false);
    } finally {
      isMutating.value = false;
    }
  }

  Future<void> decreaseQuantity({
    required int cartItemId,
    required int? quantity,
  }) async {
    if (cartItemId <= 0) {
      showMassage("البيانات غير مكتملة", false);
      return;
    }
    isMutating.value = true;
    try {
      await _cartServices.decreaseCartItem(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      await getCart();
      showMassage("تمت تقليل الكمية", true);
    } on AppException catch (e) {
      log("cart controller AppException decrease : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("cart controller catch decrease : ${e.toString()}");
      showMassage("تعذر تعديل الكمية", false);
    } finally {
      isMutating.value = false;
    }
  }
}
