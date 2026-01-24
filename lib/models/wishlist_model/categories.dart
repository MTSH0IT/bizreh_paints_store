import 'category.dart';
import 'sub_category.dart';
import 'super_category.dart';

class Categories {
  SubCategory? subCategory;
  Category? category;
  SuperCategory? superCategory;

  Categories({this.subCategory, this.category, this.superCategory});

  @override
  String toString() {
    return 'Categories(subCategory: $subCategory, category: $category, superCategory: $superCategory)';
  }

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    subCategory: json['sub_category'] == null
        ? null
        : SubCategory.fromJson(json['sub_category'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    superCategory: json['super_category'] == null
        ? null
        : SuperCategory.fromJson(
            json['super_category'] as Map<String, dynamic>,
          ),
  );

  Map<String, dynamic> toJson() => {
    'sub_category': subCategory?.toJson(),
    'category': category?.toJson(),
    'super_category': superCategory?.toJson(),
  };
}
