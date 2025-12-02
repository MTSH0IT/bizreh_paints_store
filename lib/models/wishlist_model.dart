class WishlistModel {
  int? id;
  int? userId;
  int? optionPackagingId;
  DateTime? createdAt;
  String? title;
  String? arTitle;
  String? description;
  String? arDescription;
  dynamic image;
  int? subCategoryId;
  int? brandId;
  int? isActive;
  int? productId;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? mainImage;
  int? productOptionId;
  int? packagingId;
  int? stockQuantity;
  double? pricePerUnit;

  WishlistModel({
    this.id,
    this.userId,
    this.optionPackagingId,
    this.createdAt,
    this.title,
    this.arTitle,
    this.description,
    this.arDescription,
    this.image,
    this.subCategoryId,
    this.brandId,
    this.isActive,
    this.productId,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.mainImage,
    this.productOptionId,
    this.packagingId,
    this.stockQuantity,
    this.pricePerUnit,
  });

  @override
  String toString() {
    return 'WishlistModel(id: $id, userId: $userId, optionPackagingId: $optionPackagingId, createdAt: $createdAt, title: $title, arTitle: $arTitle, description: $description, arDescription: $arDescription, image: $image, subCategoryId: $subCategoryId, brandId: $brandId, isActive: $isActive, productId: $productId, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, mainImage: $mainImage, productOptionId: $productOptionId, packagingId: $packagingId, stockQuantity: $stockQuantity, pricePerUnit: $pricePerUnit)';
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    optionPackagingId: json['option_packaging_id'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    description: json['description'] as String?,
    arDescription: json['ar_description'] as String?,
    image: json['image'] as dynamic,
    subCategoryId: json['sub_category_id'] as int?,
    brandId: json['brand_id'] as int?,
    isActive: json['is_active'] as int?,
    productId: json['product_id'] as int?,
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    mainImage: json['main_image'] as String?,
    productOptionId: json['product_option_id'] as int?,
    packagingId: json['packaging_id'] as int?,
    stockQuantity: json['stock_quantity'] as int?,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'option_packaging_id': optionPackagingId,
    'created_at': createdAt?.toIso8601String(),
    'title': title,
    'ar_title': arTitle,
    'description': description,
    'ar_description': arDescription,
    'image': image,
    'sub_category_id': subCategoryId,
    'brand_id': brandId,
    'is_active': isActive,
    'product_id': productId,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'main_image': mainImage,
    'product_option_id': productOptionId,
    'packaging_id': packagingId,
    'stock_quantity': stockQuantity,
    'price_per_unit': pricePerUnit,
  };
}
