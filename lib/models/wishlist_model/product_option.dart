class ProductOption {
  int? id;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? mainImage;
  int? productId;
  List<dynamic>? images;

  ProductOption({
    this.id,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.mainImage,
    this.productId,
    this.images,
  });

  @override
  String toString() {
    return 'ProductOption(id: $id, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, mainImage: $mainImage, productId: $productId, images: $images)';
  }

  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
    id: json['id'] as int?,
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    mainImage: json['main_image'] as String?,
    productId: json['product_id'] as int?,
    images: json['images'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'main_image': mainImage,
    'product_id': productId,
    'images': images,
  };
}
