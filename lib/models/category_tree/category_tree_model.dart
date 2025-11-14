import 'category.dart';

class CategoryTreeModle {
  int? id;
  String? title;
  String? arTitle;
  String? image;
  List<Category>? categories;

  CategoryTreeModle({
    this.id,
    this.title,
    this.arTitle,
    this.image,
    this.categories,
  });

  @override
  String toString() {
    return 'CategoryTree(id: $id, title: $title, arTitle: $arTitle, image: $image, categories: $categories)';
  }

  factory CategoryTreeModle.fromJson(Map<String, dynamic> json) =>
      CategoryTreeModle(
        id: json['id'] as int?,
        title: json['title'] as String?,
        arTitle: json['ar_title'] as String?,
        image: json['image'] as String?,
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'image': image,
    'categories': categories?.map((e) => e.toJson()).toList(),
  };
}
