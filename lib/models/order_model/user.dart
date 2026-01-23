class User {
  String? name;
  String? email;
  String? phone;

  User({this.name, this.email, this.phone});

  @override
  String toString() => 'User(name: $name, email: $email, phone: $phone)';

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
  };
}
