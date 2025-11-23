import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';

class ProductDetailsController extends GetxController {
  var selectedOption = 0.obs;
  var selectedPackaging = 0.obs;

  void selectOption(int index) {
    selectedOption.value = index;
  }

  void selectPackaging(int index) {
    selectedPackaging.value = index;
  }

  void addToCart(ProductModel product) {
    if (selectedOption.value == 0 || selectedPackaging.value == 0) {
      Get.snackbar(
        'خطأ',
        'الرجاء اختيار خيار وحزمة',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
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
