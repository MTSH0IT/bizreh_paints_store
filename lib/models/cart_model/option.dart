class Option {
  int? id;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? mainImage;
  int? stockQuantity;

  Option({
    this.id,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.mainImage,
    this.stockQuantity,
  });

  @override
  String toString() {
    return 'Option(id: $id, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, mainImage: $mainImage, stockQuantity: $stockQuantity)';
  }

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json['id'] as int?,
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    mainImage: json['main_image'] as String?,
    stockQuantity: json['stock_quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'main_image': mainImage,
    'stock_quantity': stockQuantity,
  };
}
