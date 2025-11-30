import 'package:bizreh_paints_store/models/product_model/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int optionId;
  final int packagingId;
  final double unitPrice;
  int quantity;

  CartItemModel({
    required this.product,
    required this.optionId,
    required this.packagingId,
    required this.unitPrice,
    required this.quantity,
  });

  num calculateTotalPrice() {
    return unitPrice * quantity;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  factory CartItemModel.fromProduct(
    ProductModel product, {
    required int optionId,
    required int packagingId,
    required double unitPrice,
    int quantity = 1,
  }) {
    return CartItemModel(
      product: product,
      optionId: optionId,
      packagingId: packagingId,
      unitPrice: unitPrice,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product": product.toJson(),
      "optionId": optionId,
      "packagingId": packagingId,
      "unitPrice": unitPrice,
      "quantity": quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json["product"]),
      optionId: json["optionId"],
      packagingId: json["packagingId"],
      unitPrice: (json["unitPrice"] as num).toDouble(),
      quantity: json["quantity"],
    );
  }
}
