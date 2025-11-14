class SubCategory {
  int? id;
  String? title;
  String? arTitle;
  String? image;

  SubCategory({this.id, this.title, this.arTitle, this.image});

  @override
  String toString() {
    return 'SubCategory(id: $id, title: $title, arTitle: $arTitle, image: $image)';
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'image': image,
  };
}
