import 'option.dart';
import 'packaging.dart';

class ProductModel {
  int? id;
  String? title;
  String? arTitle;
  String? description;
  String? arDescription;
  dynamic image;
  double? pricePerUnit;
  int? subCategoryId;
  int? brandId;
  int? isActive;
  DateTime? createdAt;
  String? brandName;
  String? subCategoryName;
  List<Option>? options;
  List<Packaging>? packaging;

  ProductModel({
    this.id,
    this.title,
    this.arTitle,
    this.description,
    this.arDescription,
    this.image,
    this.pricePerUnit,
    this.subCategoryId,
    this.brandId,
    this.isActive,
    this.createdAt,
    this.brandName,
    this.subCategoryName,
    this.options,
    this.packaging,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, arTitle: $arTitle, description: $description, arDescription: $arDescription, image: $image, pricePerUnit: $pricePerUnit, subCategoryId: $subCategoryId, brandId: $brandId, isActive: $isActive, createdAt: $createdAt, brandName: $brandName, subCategoryName: $subCategoryName, options: $options, packaging: $packaging)';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    description: json['description'] as String?,
    arDescription: json['ar_description'] as String?,
    image: json['image'] as dynamic,
    pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
    subCategoryId: json['sub_category_id'] as int?,
    brandId: json['brand_id'] as int?,
    isActive: json['is_active'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    brandName: json['brand_name'] as String?,
    subCategoryName: json['sub_category_name'] as String?,
    options: (json['options'] as List<dynamic>?)
        ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
        .toList(),
    packaging: (json['packaging'] as List<dynamic>?)
        ?.map((e) => Packaging.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'description': description,
    'ar_description': arDescription,
    'image': image,
    'price_per_unit': pricePerUnit,
    'sub_category_id': subCategoryId,
    'brand_id': brandId,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'brand_name': brandName,
    'sub_category_name': subCategoryName,
    'options': options?.map((e) => e.toJson()).toList(),
    'packaging': packaging?.map((e) => e.toJson()).toList(),
  };
}
