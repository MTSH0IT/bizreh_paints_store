import 'option_packaging.dart';
import 'product.dart';
import 'product_option.dart';

class WishlistModel {
  int? wishlistId;
  int? userId;
  int? optionPackagingId;
  DateTime? createdAt;
  ProductOption? productOption;
  OptionPackaging? optionPackaging;
  Product? product;

  WishlistModel({
    this.wishlistId,
    this.userId,
    this.optionPackagingId,
    this.createdAt,
    this.productOption,
    this.optionPackaging,
    this.product,
  });

  @override
  String toString() {
    return 'WishlistModel(wishlistId: $wishlistId, userId: $userId, optionPackagingId: $optionPackagingId, createdAt: $createdAt, productOption: $productOption, optionPackaging: $optionPackaging, product: $product)';
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    wishlistId: json['wishlist_id'] as int?,
    userId: json['user_id'] as int?,
    optionPackagingId: json['option_packaging_id'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    productOption: json['product_option'] == null
        ? null
        : ProductOption.fromJson(
            json['product_option'] as Map<String, dynamic>,
          ),
    optionPackaging: json['option_packaging'] == null
        ? null
        : OptionPackaging.fromJson(
            json['option_packaging'] as Map<String, dynamic>,
          ),
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'wishlist_id': wishlistId,
    'user_id': userId,
    'option_packaging_id': optionPackagingId,
    'created_at': createdAt?.toIso8601String(),
    'product_option': productOption?.toJson(),
    'option_packaging': optionPackaging?.toJson(),
    'product': product?.toJson(),
  };
}
