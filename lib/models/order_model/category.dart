class Category {
  String? title;
  String? arTitle;

  Category({this.title, this.arTitle});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
  );

  Map<String, dynamic> toJson() => {'title': title, 'ar_title': arTitle};
}
