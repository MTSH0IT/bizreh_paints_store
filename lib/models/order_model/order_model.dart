import 'item.dart';

class OrderModel {
  int? id;
  String? orderNumber;
  int? userId;
  int? addressId;
  dynamic driverId;
  double? totalAmount;
  int? discountAmount;
  double? finalAmount;
  String? status;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  String? userEmail;
  String? userPhone;
  dynamic driverName;
  String? addressLine;
  int? cityId;
  List<Item>? items;

  OrderModel({
    this.id,
    this.orderNumber,
    this.userId,
    this.addressId,
    this.driverId,
    this.totalAmount,
    this.discountAmount,
    this.finalAmount,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.driverName,
    this.addressLine,
    this.cityId,
    this.items,
  });

  @override
  String toString() {
    return 'OrderModel(id: $id, orderNumber: $orderNumber, userId: $userId, addressId: $addressId, driverId: $driverId, totalAmount: $totalAmount, discountAmount: $discountAmount, finalAmount: $finalAmount, status: $status, paymentStatus: $paymentStatus, createdAt: $createdAt, updatedAt: $updatedAt, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, driverName: $driverName, addressLine: $addressLine, cityId: $cityId, items: $items)';
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as int?,
    orderNumber: json['order_number'] as String?,
    userId: json['user_id'] as int?,
    addressId: json['address_id'] as int?,
    driverId: json['driver_id'] as dynamic,
    totalAmount: (json['total_amount'] as num?)?.toDouble(),
    discountAmount: json['discount_amount'] as int?,
    finalAmount: (json['final_amount'] as num?)?.toDouble(),
    status: json['status'] as String?,
    paymentStatus: json['payment_status'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    userName: json['user_name'] as String?,
    userEmail: json['user_email'] as String?,
    userPhone: json['user_phone'] as String?,
    driverName: json['driver_name'] as dynamic,
    addressLine: json['address_line'] as String?,
    cityId: json['city_id'] as int?,
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_number': orderNumber,
    'user_id': userId,
    'address_id': addressId,
    'driver_id': driverId,
    'total_amount': totalAmount,
    'discount_amount': discountAmount,
    'final_amount': finalAmount,
    'status': status,
    'payment_status': paymentStatus,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'user_name': userName,
    'user_email': userEmail,
    'user_phone': userPhone,
    'driver_name': driverName,
    'address_line': addressLine,
    'city_id': cityId,
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
