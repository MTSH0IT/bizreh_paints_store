class ProductbModel {
  int? id;
  String? title;
  String? arTitle;
  String? description;
  String? arDescription;
  double? pricePerUnit;
  int? subCategoryId;
  int? brandId;
  int? isActive;
  DateTime? createdAt;

  ProductbModel({
    this.id,
    this.title,
    this.arTitle,
    this.description,
    this.arDescription,
    this.pricePerUnit,
    this.subCategoryId,
    this.brandId,
    this.isActive,
    this.createdAt,
  });

  factory ProductbModel.fromJson(Map<String, dynamic> json) => ProductbModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    description: json['description'] as String?,
    arDescription: json['ar_description'] as String?,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
    subCategoryId: json['sub_category_id'] as int?,
    brandId: json['brand_id'] as int?,
    isActive: json['is_active'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'description': description,
    'ar_description': arDescription,
    'price_per_unit': pricePerUnit,
    'sub_category_id': subCategoryId,
    'brand_id': brandId,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
  };
}
