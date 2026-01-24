import 'all_option.dart';
import 'brand.dart';
import 'categories.dart';

class Product {
  int? id;
  String? title;
  String? arTitle;
  String? description;
  String? arDescription;
  String? image;
  int? brandId;
  int? subCategoryId;
  bool? isActive;
  DateTime? createdAt;
  Brand? brand;
  Categories? categories;
  List<AllOption>? allOptions;

  Product({
    this.id,
    this.title,
    this.arTitle,
    this.description,
    this.arDescription,
    this.image,
    this.brandId,
    this.subCategoryId,
    this.isActive,
    this.createdAt,
    this.brand,
    this.categories,
    this.allOptions,
  });

  @override
  String toString() {
    return 'Product(id: $id, title: $title, arTitle: $arTitle, description: $description, arDescription: $arDescription, image: $image, brandId: $brandId, subCategoryId: $subCategoryId, isActive: $isActive, createdAt: $createdAt, brand: $brand, categories: $categories, allOptions: $allOptions)';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    description: json['description'] as String?,
    arDescription: json['ar_description'] as String?,
    image: json['image'] as String?,
    brandId: json['brand_id'] as int?,
    subCategoryId: json['sub_category_id'] as int?,
    isActive: json['is_active'] as bool?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    categories: json['categories'] == null
        ? null
        : Categories.fromJson(json['categories'] as Map<String, dynamic>),
    allOptions: (json['all_options'] as List<dynamic>?)
        ?.map((e) => AllOption.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'description': description,
    'ar_description': arDescription,
    'image': image,
    'brand_id': brandId,
    'sub_category_id': subCategoryId,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'brand': brand?.toJson(),
    'categories': categories?.toJson(),
    'all_options': allOptions?.map((e) => e.toJson()).toList(),
  };
}
