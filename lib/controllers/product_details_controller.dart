import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';

class ProductDetailsController extends GetxController {
  var selectedOption = (-1).obs;
  var selectedPackaging = (-1).obs;

  void selectOption(int index) {
    selectedOption.value = index;
    // reset packaging selection when option changes
    selectedPackaging.value = -1;
  }

  void selectPackaging(int index) {
    selectedPackaging.value = index;
  }

  void addToCart(ProductModel product) {
    if (selectedOption.value < 0 || selectedPackaging.value < 0) {
      showMassage("اختر الخيار المناسب وطريقة التغليف", false);
      return;
    }
    final cartController = Get.find<MyCartController>();

    final options = product.options ?? [];
    final selectedOptionId = selectedOption.value;
    final selectedPackagingId = selectedPackaging.value;

    var optionModel = options.firstWhere(
      (o) => o.id == selectedOptionId,
      orElse: () => options.first,
    );

    final packagingList = optionModel.packaging ?? [];
    final packagingModel = packagingList.firstWhere(
      (p) => p.id == selectedPackagingId,
      orElse: () => packagingList.first,
    );

    final unitPrice = packagingModel.pricePerUnit ?? 0.0;

    cartController.addToCart(
      product,
      optionId: optionModel.id ?? selectedOptionId,
      packagingId: packagingModel.id ?? selectedPackagingId,
      unitPrice: unitPrice,
    );

    showMassage("تم اضافة المنتج الى السلة", true);
  }
}
