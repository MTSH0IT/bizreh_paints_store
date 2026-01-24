class Category {
  String? name;
  String? arName;

  Category({this.name, this.arName});

  @override
  String toString() => 'Category(name: $name, arName: $arName)';

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json['name'] as String?,
    arName: json['ar_name'] as String?,
  );

  Map<String, dynamic> toJson() => {'name': name, 'ar_name': arName};
}
