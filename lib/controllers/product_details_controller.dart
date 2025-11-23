import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';

class ProductDetailsController extends GetxController {
  var selectedOption = (-1).obs;
  var selectedPackaging = (-1).obs;

  void selectOption(int index) {
    selectedOption.value = index;
  }

  void selectPackaging(int index) {
    selectedPackaging.value = index;
  }

  void addToCart(ProductModel product) {
    if (selectedOption.value <= 0 || selectedPackaging.value <= 0) {
      showMassage("اختر الخيار المناسب وطريقة التغليف", false);
      return;
    }
    final cartController = Get.find<MyCartController>();
    cartController.addToCart(product);

    showMassage("تم اضافة المنتج الى السلة", true);
  }
}
