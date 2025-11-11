import 'package:get/get.dart';
import 'package:bizreh_paints_store/models/cart_item_model.dart';
import 'package:bizreh_paints_store/models/product_model.dart';
import 'package:bizreh_paints_store/models/discount_model.dart';

class MyCartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;

  final RxInt selectedDiscount = 0.obs;
  var discounts = <DiscountModel>[].obs;

  @override
  void onInit() {
    lodeDiscount();
    super.onInit();
  }

  void lodeDiscount() {
    discounts.value = demoDiscount;
  }

  void addToCart(ProductModel product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.title == product.title,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].incrementQuantity();
    } else {
      cartItems.add(CartItemModel.fromProduct(product));
    }
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity < 999) {
        cartItems[index].incrementQuantity();
        cartItems.refresh();
      }
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].decrementQuantity();
        cartItems.refresh();
      }
    }
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < cartItems.length && newQuantity > 0) {
      cartItems[index].quantity = newQuantity;
      cartItems.refresh();
    }
  }

  double subtotal() {
    return cartItems.fold(0.0, (sum, item) => sum + item.calculateTotalPrice());
  }

  double shipping() {
    if (subtotal() <= 0) {
      return 0.0;
    }
    if (subtotal() < 50) {
      return 5.0;
    }
    if (subtotal() < 100) {
      return 10.0;
    }
    return 15.0;
  }

  double discountAmount(double subtotal) {
    if (discounts.isEmpty) return 0.0;
    final idx = selectedDiscount.value.clamp(0, discounts.length - 1);
    final d = discounts[idx];
    switch (d.type) {
      case 'percentage':
        return -(subtotal * d.value);
      case 'fixed':
        return -d.value;
      case 'none':
      default:
        return 0.0;
    }
  }

  void setSelectedDiscount(int index) {
    if (discounts.isEmpty) return;
    final clamped = index.clamp(0, discounts.length - 1);
    selectedDiscount.value = clamped;
  }

  int totalItems() {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  bool isEmpty() {
    return cartItems.isEmpty;
  }

  void clearCart() {
    cartItems.clear();
  }
}
