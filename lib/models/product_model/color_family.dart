class ColorFamily {
  int? id;
  int? productOptionId;
  int? optionPackagingId;
  String? colorDegree;
  DateTime? createdAt;

  ColorFamily({
    this.id,
    this.productOptionId,
    this.optionPackagingId,
    this.colorDegree,
    this.createdAt,
  });

  @override
  String toString() {
    return 'ColorFamily(id: $id, productOptionId: $productOptionId, optionPackagingId: $optionPackagingId, colorDegree: $colorDegree, createdAt: $createdAt)';
  }

  factory ColorFamily.fromJson(Map<String, dynamic> json) => ColorFamily(
    id: json['id'] as int?,
    productOptionId: json['product_option_id'] as int?,
    optionPackagingId: json['option_packaging_id'] as int?,
    colorDegree: json['color_degree'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_option_id': productOptionId,
    'option_packaging_id': optionPackagingId,
    'color_degree': colorDegree,
    'created_at': createdAt?.toIso8601String(),
  };
}
