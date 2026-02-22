import 'brand.dart';
import 'category.dart';
import 'color.dart';
import 'option_packaging.dart';
import 'packaging.dart';
import 'product.dart';
import 'product_option.dart';

class Item {
  int? orderItemId;
  int? orderId;
  int? optionPackagingId;
  int? quantityPerUnit;
  String? productSku;
  num? unitPrice;
  num? totalPrice;
  String? discountAmount;
  String? finalItemPrice;
  String? appliedDiscountName;
  DateTime? createdAt;
  Product? product;
  ProductOption? productOption;
  OptionPackaging? optionPackaging;
  Packaging? packaging;
  Color? color;
  Category? category;
  Brand? brand;

  Item({
    this.orderItemId,
    this.orderId,
    this.optionPackagingId,
    this.quantityPerUnit,
    this.productSku,
    this.unitPrice,
    this.totalPrice,
    this.discountAmount,
    this.finalItemPrice,
    this.appliedDiscountName,
    this.createdAt,
    this.product,
    this.productOption,
    this.optionPackaging,
    this.packaging,
    this.color,
    this.category,
    this.brand,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    orderItemId: json['order_item_id'] as int?,
    orderId: json['order_id'] as int?,
    optionPackagingId: json['option_packaging_id'] as int?,
    quantityPerUnit: json['quantity_per_unit'] as int?,
    productSku: json['product_sku'] as String?,
    unitPrice: json['unit_price'] as num?,
    totalPrice: json['total_price'] as num?,
    discountAmount: json['discount_amount'] as String?,
    finalItemPrice: json['final_item_price'] as String?,
    appliedDiscountName: json['applied_discount_name'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
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
    packaging: json['packaging'] == null
        ? null
        : Packaging.fromJson(json['packaging'] as Map<String, dynamic>),
    color: json['color'] == null
        ? null
        : Color.fromJson(json['color'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'order_item_id': orderItemId,
    'order_id': orderId,
    'option_packaging_id': optionPackagingId,
    'quantity_per_unit': quantityPerUnit,
    'product_sku': productSku,
    'unit_price': unitPrice,
    'total_price': totalPrice,
    'discount_amount': discountAmount,
    'final_item_price': finalItemPrice,
    'applied_discount_name': appliedDiscountName,
    'created_at': createdAt?.toIso8601String(),
    'product': product?.toJson(),
    'product_option': productOption?.toJson(),
    'option_packaging': optionPackaging?.toJson(),
    'packaging': packaging?.toJson(),
    'color': color?.toJson(),
    'category': category?.toJson(),
    'brand': brand?.toJson(),
  };
}
