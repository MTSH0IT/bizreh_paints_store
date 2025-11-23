class Packaging {
  int? id;
  String? title;
  String? arTitle;
  int? countPerUnit;
  DateTime? createdAt;
  int? productId;

  Packaging({
    this.id,
    this.title,
    this.arTitle,
    this.countPerUnit,
    this.createdAt,
    this.productId,
  });

  @override
  String toString() {
    return 'Packaging(id: $id, title: $title, arTitle: $arTitle, countPerUnit: $countPerUnit, createdAt: $createdAt, productId: $productId)';
  }

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    countPerUnit: json['count_per_unit'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    productId: json['product_id'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'count_per_unit': countPerUnit,
    'created_at': createdAt?.toIso8601String(),
    'product_id': productId,
  };
}
