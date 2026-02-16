class OptionPackaging {
  int? id;
  num? pricePerUnit;
  int? packagingId;
  int? stockQuantity;

  OptionPackaging({
    this.id,
    this.pricePerUnit,
    this.packagingId,
    this.stockQuantity,
  });

  @override
  String toString() {
    return 'OptionPackaging(id: $id, pricePerUnit: $pricePerUnit, packagingId: $packagingId, stockQuantity: $stockQuantity)';
  }

  factory OptionPackaging.fromJson(Map<String, dynamic> json) {
    return OptionPackaging(
      id: json['id'] as int?,
      pricePerUnit: json['price_per_unit'] as num?,
      packagingId: json['packaging_id'] as int?,
      stockQuantity: json['stock_quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'price_per_unit': pricePerUnit,
    'packaging_id': packagingId,
    'stock_quantity': stockQuantity,
  };
}
