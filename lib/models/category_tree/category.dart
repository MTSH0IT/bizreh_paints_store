import 'sub_category.dart';

class Category {
  int? id;
  String? title;
  String? arTitle;
  String? image;
  List<SubCategory>? subCategories;

  Category({this.id, this.title, this.arTitle, this.image, this.subCategories});

  @override
  String toString() {
    return 'Category(id: $id, title: $title, arTitle: $arTitle, image: $image, subCategories: $subCategories)';
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    image: json['image'] as String?,
    subCategories: (json['sub_categories'] as List<dynamic>?)
        ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'image': image,
    'sub_categories': subCategories?.map((e) => e.toJson()).toList(),
  };
}
