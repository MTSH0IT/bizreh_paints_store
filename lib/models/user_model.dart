class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String userType;
  DateTime createdAt;
  int isActive;
  int? ordersCount;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userType,
    required this.createdAt,
    required this.isActive,
    required this.ordersCount,
  });

  @override
  String toString() {
    return "UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, userType: $userType, createdAt: $createdAt, isActive: $isActive, ordersCount: $ordersCount)";
  }

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
    id: data['id'] as int,
    firstName: data['first_name'] as String,
    lastName: data['last_name'] as String,
    email: data['email'] as String,
    phone: data['phone'] as String,
    userType: data['user_type'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
    isActive: data['is_active'] as int,
    ordersCount: data['orders_count'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone': phone,
    'user_type': userType,
    'created_at': createdAt.toIso8601String(),
    'is_active': isActive,
    'orders_count': ordersCount,
  };
}
