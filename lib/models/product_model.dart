class ProductModel {
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
  String? brandName;
  String? brandArName;
  String? subCategoryName;
  String? subCategoryArName;

  ProductModel({
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
    this.brandName,
    this.brandArName,
    this.subCategoryName,
    this.subCategoryArName,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, arTitle: $arTitle, description: $description, arDescription: $arDescription, pricePerUnit: $pricePerUnit, subCategoryId: $subCategoryId, brandId: $brandId, isActive: $isActive, createdAt: $createdAt, brandName: $brandName, brandArName: $brandArName, subCategoryName: $subCategoryName, subCategoryArName: $subCategoryArName)';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
    brandName: json['brand_name'] as String?,
    brandArName: json['brand_ar_name'] as String?,
    subCategoryName: json['sub_category_name'] as String?,
    subCategoryArName: json['sub_category_ar_name'] as String?,
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
    'brand_name': brandName,
    'brand_ar_name': brandArName,
    'sub_category_name': subCategoryName,
    'sub_category_ar_name': subCategoryArName,
  };
}
