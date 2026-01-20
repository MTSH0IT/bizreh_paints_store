class Packaging {
  int? id;
  String? title;
  String? arTitle;
  int? countPerUnit;
  double? pricePerUnit;
  int? stockQuantity;

  Packaging({
    this.id,
    this.title,
    this.arTitle,
    this.countPerUnit,
    this.pricePerUnit,
    this.stockQuantity,
  });

  @override
  String toString() {
    return 'Packaging(id: $id, title: $title, arTitle: $arTitle, countPerUnit: $countPerUnit, pricePerUnit: $pricePerUnit, stockQuantity: $stockQuantity)';
  }

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    countPerUnit: json['count_per_unit'] as int?,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
    stockQuantity: json['stock_quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'count_per_unit': countPerUnit,
    'price_per_unit': pricePerUnit,
    'stock_quantity': stockQuantity,
  };
}
