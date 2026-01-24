import 'packaging_option.dart';

class AllOption {
  int? id;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? mainImage;
  List<PackagingOption>? packagingOptions;

  AllOption({
    this.id,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.mainImage,
    this.packagingOptions,
  });

  @override
  String toString() {
    return 'AllOption(id: $id, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, mainImage: $mainImage, packagingOptions: $packagingOptions)';
  }

  factory AllOption.fromJson(Map<String, dynamic> json) => AllOption(
    id: json['id'] as int?,
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    mainImage: json['main_image'] as String?,
    packagingOptions: (json['packaging_options'] as List<dynamic>?)
        ?.map((e) => PackagingOption.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'main_image': mainImage,
    'packaging_options': packagingOptions?.map((e) => e.toJson()).toList(),
  };
}
