import 'dart:developer';

import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';
import 'package:bizreh_paints_store/models/cart_item_model.dart';

class ProductDetailsController extends GetxController {
  var selectedOption = (-1).obs;
  var selectedPackaging = (-1).obs;
  var selectedColorId = (-1).obs;

  void selectOption(int index) {
    selectedOption.value = index;
    selectedPackaging.value = -1;
    selectedColorId.value = -1;
  }

  void selectPackaging(int index) {
    selectedPackaging.value = index;
    selectedColorId.value = -1;
  }

  void selectColor(int id) {
    selectedColorId.value = id;
    log("${selectedColorId.value}");
  }

  void addToCart(ProductModel product) {
    if (selectedOption.value < 0 ||
        selectedPackaging.value < 0 ||
        selectedColorId.value < 0) {
      showMassage("اختر النوع وطريقة التغليف واللون", false);
      return;
    }
    final cartController = Get.find<MyCartController>();

    final cartItem = CartItemModel.fromProduct(
      product,
      optionId: selectedOption.value,
      packagingId: selectedPackaging.value,
    );

    cartController.addToCart(cartItem);

    showMassage("تم اضافة المنتج الى السلة", true);
  }
}
