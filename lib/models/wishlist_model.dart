class WishlistModel {
  int? id;
  int? userId;
  int? productOptionId;
  DateTime? createdAt;
  String? title;
  String? arTitle;
  String? description;
  String? arDescription;
  dynamic image;
  double? pricePerUnit;
  int? subCategoryId;
  int? brandId;
  int? isActive;
  int? productId;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? mainImage;
  int? extraPricePerUnit;
  int? stockQuantity;

  WishlistModel({
    this.id,
    this.userId,
    this.productOptionId,
    this.createdAt,
    this.title,
    this.arTitle,
    this.description,
    this.arDescription,
    this.image,
    this.pricePerUnit,
    this.subCategoryId,
    this.brandId,
    this.isActive,
    this.productId,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.mainImage,
    this.extraPricePerUnit,
    this.stockQuantity,
  });

  @override
  String toString() {
    return 'WishlistModel(id: $id, userId: $userId, productOptionId: $productOptionId, createdAt: $createdAt, title: $title, arTitle: $arTitle, description: $description, arDescription: $arDescription, image: $image, pricePerUnit: $pricePerUnit, subCategoryId: $subCategoryId, brandId: $brandId, isActive: $isActive, productId: $productId, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, mainImage: $mainImage, extraPricePerUnit: $extraPricePerUnit, stockQuantity: $stockQuantity)';
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    productOptionId: json['product_option_id'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    description: json['description'] as String?,
    arDescription: json['ar_description'] as String?,
    image: json['image'] as dynamic,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
    subCategoryId: json['sub_category_id'] as int?,
    brandId: json['brand_id'] as int?,
    isActive: json['is_active'] as int?,
    productId: json['product_id'] as int?,
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    mainImage: json['main_image'] as String?,
    extraPricePerUnit: json['extra_price_per_unit'] as int?,
    stockQuantity: json['stock_quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'product_option_id': productOptionId,
    'created_at': createdAt?.toIso8601String(),
    'title': title,
    'ar_title': arTitle,
    'description': description,
    'ar_description': arDescription,
    'image': image,
    'price_per_unit': pricePerUnit,
    'sub_category_id': subCategoryId,
    'brand_id': brandId,
    'is_active': isActive,
    'product_id': productId,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'main_image': mainImage,
    'extra_price_per_unit': extraPricePerUnit,
    'stock_quantity': stockQuantity,
  };
}
