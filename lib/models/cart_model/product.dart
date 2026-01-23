class Product {
  int? id;
  String? title;
  String? arTitle;
  String? description;
  String? arDescription;
  String? image;
  int? subCategoryId;
  int? brandId;
  int? isActive;

  Product({
    this.id,
    this.title,
    this.arTitle,
    this.description,
    this.arDescription,
    this.image,
    this.subCategoryId,
    this.brandId,
    this.isActive,
  });

  @override
  String toString() {
    return 'Product(id: $id, title: $title, arTitle: $arTitle, description: $description, arDescription: $arDescription, image: $image, subCategoryId: $subCategoryId, brandId: $brandId, isActive: $isActive)';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    description: json['description'] as String?,
    arDescription: json['ar_description'] as String?,
    image: json['image'] as String?,
    subCategoryId: json['sub_category_id'] as int?,
    brandId: json['brand_id'] as int?,
    isActive: json['is_active'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'description': description,
    'ar_description': arDescription,
    'image': image,
    'sub_category_id': subCategoryId,
    'brand_id': brandId,
    'is_active': isActive,
  };
}
