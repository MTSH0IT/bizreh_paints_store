import 'color_family.dart';
import 'packaging.dart';

class Option {
  int? id;
  int? productId;
  String? optionName;
  String? arOptionName;
  String? optionSku;
  String? mainImage;
  DateTime? createdAt;
  int? packagingCount;
  int? imagesCount;
  List<Packaging>? packaging;
  List<dynamic>? images;
  List<ColorFamily>? colorFamilies;

  Option({
    this.id,
    this.productId,
    this.optionName,
    this.arOptionName,
    this.optionSku,
    this.mainImage,
    this.createdAt,
    this.packagingCount,
    this.imagesCount,
    this.packaging,
    this.images,
    this.colorFamilies,
  });

  @override
  String toString() {
    return 'Option(id: $id, productId: $productId, optionName: $optionName, arOptionName: $arOptionName, optionSku: $optionSku, mainImage: $mainImage, createdAt: $createdAt, packagingCount: $packagingCount, imagesCount: $imagesCount, packaging: $packaging, images: $images, colorFamilies: $colorFamilies)';
  }

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json['id'] as int?,
    productId: json['product_id'] as int?,
    optionName: json['option_name'] as String?,
    arOptionName: json['ar_option_name'] as String?,
    optionSku: json['option_sku'] as String?,
    mainImage: json['main_image'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    packagingCount: json['packaging_count'] as int?,
    imagesCount: json['images_count'] as int?,
    packaging: (json['packaging'] as List<dynamic>?)
        ?.map((e) => Packaging.fromJson(e as Map<String, dynamic>))
        .toList(),
    images: json['images'] as List<dynamic>?,
    colorFamilies: (json['color_families'] as List<dynamic>?)
        ?.map((e) => ColorFamily.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'option_name': optionName,
    'ar_option_name': arOptionName,
    'option_sku': optionSku,
    'main_image': mainImage,
    'created_at': createdAt?.toIso8601String(),
    'packaging_count': packagingCount,
    'images_count': imagesCount,
    'packaging': packaging?.map((e) => e.toJson()).toList(),
    'images': images,
    'color_families': colorFamilies?.map((e) => e.toJson()).toList(),
  };
}
