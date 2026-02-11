import 'item.dart';
import 'summary.dart';

class CartModel {
  int? id;
  String? orderNumber;
  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  int? addressId;
  String? addressLine;
  String? addressNote;
  double? longitude;
  double? latitude;
  String? cityName;
  dynamic driverId;
  num? totalAmount;
  num? discountAmount;
  num? finalAmount;
  String? status;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Item>? items;
  Summary? summary;

  CartModel({
    this.id,
    this.orderNumber,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.addressId,
    this.addressLine,
    this.addressNote,
    this.longitude,
    this.latitude,
    this.cityName,
    this.driverId,
    this.totalAmount,
    this.discountAmount,
    this.finalAmount,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.summary,
  });

  @override
  String toString() {
    return 'CartModel(id: $id, orderNumber: $orderNumber, userId: $userId, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, addressId: $addressId, addressLine: $addressLine, addressNote: $addressNote, longitude: $longitude, latitude: $latitude, cityName: $cityName, driverId: $driverId, totalAmount: $totalAmount, discountAmount: $discountAmount, finalAmount: $finalAmount, status: $status, paymentStatus: $paymentStatus, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, summary: $summary)';
  }

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] as int?,
    orderNumber: json['order_number'] as String?,
    userId: json['user_id'] as int?,
    userName: json['user_name'] as String?,
    userEmail: json['user_email'] as String?,
    userPhone: json['user_phone'] as String?,
    addressId: json['address_id'] as int?,
    addressLine: json['address_line'] as String?,
    addressNote: json['address_note'] as String?,
    longitude: (json['longitude'] as num?)?.toDouble(),
    latitude: (json['latitude'] as num?)?.toDouble(),
    cityName: json['city_name'] as String?,
    driverId: json['driver_id'] as dynamic,
    totalAmount: json['total_amount'] as num?,
    discountAmount: json['discount_amount'] as num?,
    finalAmount: json['final_amount'] as num?,
    status: json['status'] as String?,
    paymentStatus: json['payment_status'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
    summary: json['summary'] == null
        ? null
        : Summary.fromJson(json['summary'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_number': orderNumber,
    'user_id': userId,
    'user_name': userName,
    'user_email': userEmail,
    'user_phone': userPhone,
    'address_id': addressId,
    'address_line': addressLine,
    'address_note': addressNote,
    'longitude': longitude,
    'latitude': latitude,
    'city_name': cityName,
    'driver_id': driverId,
    'total_amount': totalAmount,
    'discount_amount': discountAmount,
    'final_amount': finalAmount,
    'status': status,
    'payment_status': paymentStatus,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'items': items?.map((e) => e.toJson()).toList(),
    'summary': summary?.toJson(),
  };
}
