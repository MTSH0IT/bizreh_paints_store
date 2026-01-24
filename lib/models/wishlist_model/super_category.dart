class SuperCategory {
  String? name;
  String? arName;

  SuperCategory({this.name, this.arName});

  @override
  String toString() => 'SuperCategory(name: $name, arName: $arName)';

  factory SuperCategory.fromJson(Map<String, dynamic> json) => SuperCategory(
    name: json['name'] as String?,
    arName: json['ar_name'] as String?,
  );

  Map<String, dynamic> toJson() => {'name': name, 'ar_name': arName};
}
