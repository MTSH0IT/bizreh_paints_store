import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';
import 'package:bizreh_paints_store/models/product_model.dart';

class WishListController extends GetxController {
  static const String boxName = 'wishlist';
  late Box _box;
  final RxList<ProductModel> items = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _ensureBox().then((_) {
      _reload();
      _box.watch().listen((_) => _reload());
    });
  }

  Future<void> _ensureBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox(boxName);
    } else {
      _box = Hive.box(boxName);
    }
  }

  void _reload() {
    final data = _box.values
        .whereType<Map>()
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    items.assignAll(data);
  }

  Future<void> toggle(ProductModel item) async {
    await _ensureBox();
    if (_box.containsKey(item.title)) {
      await _box.delete(item.title);
    } else {
      await _box.put(item.title, item.toJson());
    }
  }

  bool isFavorite(String id) {
    if (!Hive.isBoxOpen(boxName)) return false;
    return Hive.box(boxName).containsKey(id);
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
