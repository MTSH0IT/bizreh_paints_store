import 'dart:developer';

import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetailsController extends GetxController {
  final CartController cartController;

  ProductDetailsController({required this.cartController});
  var selectedOption = (-1).obs;
  var selectedPackaging = (-1).obs;
  var selectedColorId = (-1).obs;

  void selectOption(int index) {
    selectedOption.value = index;
    selectedPackaging.value = -1;
    selectedColorId.value = -1;
  }

  void selectPackaging(int optionPackagingId, {int? colorFamilyId}) {
    selectedPackaging.value = optionPackagingId;
    selectedColorId.value = colorFamilyId ?? 0;
  }

  void selectColor(int id) {
    selectedColorId.value = id;
    log("${selectedColorId.value}");
  }

  Future<void> addToCart({required int quantity}) async {
    if (selectedOption.value < 0 || selectedPackaging.value < 0) {
      showMassage(tr('common.please_select_type_and_packaging'), false);
      return;
    }

    await cartController.addToCart(
      optionPackagingId: selectedPackaging.value,
      colorFamilyId: selectedColorId.value < 0 ? 0 : selectedColorId.value,
      quantity: quantity,
    );
  }
}
