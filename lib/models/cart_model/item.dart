import 'brand.dart';
import 'category.dart';
import 'option.dart';
import 'packaging.dart';
import 'product.dart';

class Item {
  int? id;
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
  Option? option;
  Packaging? packaging;
  Category? category;
  Brand? brand;
  num? subtotal;
  dynamic availableStock;

  Item({
    this.id,
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
    this.option,
    this.packaging,
    this.category,
    this.brand,
    this.subtotal,
    this.availableStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'] as int?,
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
    option: json['option'] == null
        ? null
        : Option.fromJson(json['option'] as Map<String, dynamic>),
    packaging: json['packaging'] == null
        ? null
        : Packaging.fromJson(json['packaging'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    subtotal: json['subtotal'] as num?,
    availableStock: json['available_stock'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
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
    'option': option?.toJson(),
    'packaging': packaging?.toJson(),
    'category': category?.toJson(),
    'brand': brand?.toJson(),
    'subtotal': subtotal,
    'available_stock': availableStock,
  };
}
