class Packaging {
  int? id;
  int? productOptionId;
  int? packagingId;
  int? stockQuantity;
  double? pricePerUnit;
  DateTime? createdAt;
  String? packagingTitle;
  String? arPackagingTitle;
  int? countPerUnit;

  Packaging({
    this.id,
    this.productOptionId,
    this.packagingId,
    this.stockQuantity,
    this.pricePerUnit,
    this.createdAt,
    this.packagingTitle,
    this.arPackagingTitle,
    this.countPerUnit,
  });

  @override
  String toString() {
    return 'Packaging(id: $id, productOptionId: $productOptionId, packagingId: $packagingId, stockQuantity: $stockQuantity, pricePerUnit: $pricePerUnit, createdAt: $createdAt, packagingTitle: $packagingTitle, arPackagingTitle: $arPackagingTitle, countPerUnit: $countPerUnit)';
  }

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
    id: json['id'] as int?,
    productOptionId: json['product_option_id'] as int?,
    packagingId: json['packaging_id'] as int?,
    stockQuantity: json['stock_quantity'] as int?,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    packagingTitle: json['packaging_title'] as String?,
    arPackagingTitle: json['ar_packaging_title'] as String?,
    countPerUnit: json['count_per_unit'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_option_id': productOptionId,
    'packaging_id': packagingId,
    'stock_quantity': stockQuantity,
    'price_per_unit': pricePerUnit,
    'created_at': createdAt?.toIso8601String(),
    'packaging_title': packagingTitle,
    'ar_packaging_title': arPackagingTitle,
    'count_per_unit': countPerUnit,
  };
}
