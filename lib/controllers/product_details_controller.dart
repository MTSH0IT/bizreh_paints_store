import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';
import 'package:bizreh_paints_store/models/product_model.dart';

class ProductDetailsController extends GetxController {
  var selectedColor = 0.obs;
  var selectedSheen = 'Matte'.obs;

  final List<Color> colors = const [
    Color(0xFFF2F2F2),
    Color(0xFFE6E6E6),
    Color(0xFFDADADA),
    Color(0xFFCDCDCD),
    Color(0xFFC0C0C0),
    Color(0xFFB3B3B3),
    Color(0xFFA6A6A6),
    Color(0xFF999999),
  ];

  void selectColor(int index) {
    selectedColor.value = index;
  }

  void selectSheen(String sheen) {
    selectedSheen.value = sheen;
  }

  void addToWishlist() {
    // TODO: Implement add to wishlist logic
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
