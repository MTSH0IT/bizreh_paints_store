import 'package:bizreh_paints_store/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({required this.product, required this.quantity});

  num calculateTotalPrice() {
    return product.price * quantity;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  factory CartItemModel.fromProduct(ProductModel product, {int quantity = 1}) {
    return CartItemModel(product: product, quantity: quantity);
  }

  Map<String, dynamic> toJson() {
    return {"product": product.toJson(), "quantity": quantity};
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json["product"]),
      quantity: json["quantity"],
    );
  }
}
