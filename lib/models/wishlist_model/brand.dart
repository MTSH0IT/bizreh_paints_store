class Brand {
  String? name;
  String? arName;

  Brand({this.name, this.arName});

  @override
  String toString() => 'Brand(name: $name, arName: $arName)';

  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(name: json['name'] as String?, arName: json['ar_name'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'ar_name': arName};
}
