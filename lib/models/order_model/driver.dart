class Driver {
  String? name;
  String? phone;

  Driver({this.name, this.phone});

  @override
  String toString() => 'Driver(name: $name, phone: $phone)';

  factory Driver.fromJson(Map<String, dynamic> json) =>
      Driver(name: json['name'] as String?, phone: json['phone'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};
}
