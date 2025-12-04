import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/models/wishlist_model.dart';

class CartItemModel {
  final int optionId;
  final int packagingId;
  final double unitPrice;
  final String? title;
  final String? image;
  final String? optionName;
  final String? packagingTitle;
  int quantity;

  CartItemModel({
    required this.optionId,
    required this.packagingId,
    required this.unitPrice,
    required this.title,
    required this.image,
    required this.optionName,
    required this.packagingTitle,
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
    int quantity = 1,
  }) {
    final options = product.options ?? [];
    final optionModel = options.firstWhere(
      (o) => o.id == optionId,
      orElse: () => options.isNotEmpty ? options.first : options.first,
    );

    final packagingList = optionModel.packaging ?? [];
    final packagingModel = packagingList.firstWhere(
      (p) => p.id == packagingId,
      orElse: () =>
          packagingList.isNotEmpty ? packagingList.first : packagingList.first,
    );
    final unitPrice = packagingModel.pricePerUnit ?? 0.0;

    return CartItemModel(
      optionId: optionId,
      packagingId: packagingId,
      unitPrice: unitPrice,
      title: product.title ?? '',
      image: product.image ?? '',
      optionName: optionModel.optionName ?? '',
      packagingTitle: packagingModel.packagingTitle ?? '',
      quantity: quantity,
    );
  }

  factory CartItemModel.fromWishlist(WishlistModel item) {
    return CartItemModel(
      optionId: item.productOptionId ?? 0,
      packagingId: item.optionPackagingId ?? 0,
      unitPrice: item.pricePerUnit ?? 0,
      title: item.title ?? '',
      image: item.mainImage ?? '',
      optionName: item.optionName ?? '',
      packagingTitle: item.packagintTitle ?? '',
      quantity: 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "optionId": optionId,
      "packagingId": packagingId,
      "unitPrice": unitPrice,
      "title": title,
      "image": image,
      "optionName": optionName,
      "packagingTitle": packagingTitle,
      "quantity": quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      optionId: json["optionId"],
      packagingId: json["packagingId"],
      unitPrice: (json["unitPrice"] as num).toDouble(),
      title: json["title"],
      image: json["image"],
      optionName: json["optionName"],
      packagingTitle: json["packagingTitle"],
      quantity: json["quantity"],
    );
  }
}
