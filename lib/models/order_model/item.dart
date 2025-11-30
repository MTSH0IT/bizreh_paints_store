class Item {
  int? id;
  int? orderId;
  int? quantityPerUnit;
  String? productSku;
  int? totalQuantity;
  double? unitPrice;
  double? totalPrice;
  DateTime? createdAt;
  int? optionPackagingId;
  dynamic colorFamilyId;
  int? productOptionId;
  int? packagingId;
  double? pricePerUnit;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? productTitle;
  String? arProductTitle;
  String? packagingTitle;
  String? arPackagingTitle;
  dynamic colorDegree;
  String? brandName;
  String? arBrandName;

  Item({
    this.id,
    this.orderId,
    this.quantityPerUnit,
    this.productSku,
    this.totalQuantity,
    this.unitPrice,
    this.totalPrice,
    this.createdAt,
    this.optionPackagingId,
    this.colorFamilyId,
    this.productOptionId,
    this.packagingId,
    this.pricePerUnit,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.productTitle,
    this.arProductTitle,
    this.packagingTitle,
    this.arPackagingTitle,
    this.colorDegree,
    this.brandName,
    this.arBrandName,
  });

  @override
  String toString() {
    return 'Item(id: $id, orderId: $orderId, quantityPerUnit: $quantityPerUnit, productSku: $productSku, totalQuantity: $totalQuantity, unitPrice: $unitPrice, totalPrice: $totalPrice, createdAt: $createdAt, optionPackagingId: $optionPackagingId, colorFamilyId: $colorFamilyId, productOptionId: $productOptionId, packagingId: $packagingId, pricePerUnit: $pricePerUnit, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, productTitle: $productTitle, arProductTitle: $arProductTitle, packagingTitle: $packagingTitle, arPackagingTitle: $arPackagingTitle, colorDegree: $colorDegree, brandName: $brandName, arBrandName: $arBrandName)';
  }

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'] as int?,
    orderId: json['order_id'] as int?,
    quantityPerUnit: json['quantity_per_unit'] as int?,
    productSku: json['product_sku'] as String?,
    totalQuantity: json['total_quantity'] as int?,
    unitPrice: (json['unit_price'] as num?)?.toDouble(),
    totalPrice: (json['total_price'] as num?)?.toDouble(),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    optionPackagingId: json['option_packaging_id'] as int?,
    colorFamilyId: json['color_family_id'] as dynamic,
    productOptionId: json['product_option_id'] as int?,
    packagingId: json['packaging_id'] as int?,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    productTitle: json['product_title'] as String?,
    arProductTitle: json['ar_product_title'] as String?,
    packagingTitle: json['packaging_title'] as String?,
    arPackagingTitle: json['ar_packaging_title'] as String?,
    colorDegree: json['color_degree'] as dynamic,
    brandName: json['brand_name'] as String?,
    arBrandName: json['ar_brand_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'quantity_per_unit': quantityPerUnit,
    'product_sku': productSku,
    'total_quantity': totalQuantity,
    'unit_price': unitPrice,
    'total_price': totalPrice,
    'created_at': createdAt?.toIso8601String(),
    'option_packaging_id': optionPackagingId,
    'color_family_id': colorFamilyId,
    'product_option_id': productOptionId,
    'packaging_id': packagingId,
    'price_per_unit': pricePerUnit,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'product_title': productTitle,
    'ar_product_title': arProductTitle,
    'packaging_title': packagingTitle,
    'ar_packaging_title': arPackagingTitle,
    'color_degree': colorDegree,
    'brand_name': brandName,
    'ar_brand_name': arBrandName,
  };
}
