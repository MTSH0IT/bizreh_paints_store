class Supplier {
  String? name;
  String? phone;

  Supplier({this.name, this.phone});

  @override
  String toString() => 'Supplier(name: $name, phone: $phone)';

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      Supplier(name: json['name'] as String?, phone: json['phone'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};
}
