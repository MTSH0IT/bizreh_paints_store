import 'address.dart';
import 'financial_summary.dart';
import 'item.dart';
import 'supplier.dart';
import 'user.dart';

class OrderModel {
  int? id;
  String? orderNumber;
  int? userId;
  int? supplierId;
  int? addressId;
  dynamic driverId;
  double? totalAmount;
  String? status;
  String? paymentStatus;
  DateTime? createdAt;
  User? user;
  Address? address;
  dynamic driver;
  Supplier? supplier;
  FinancialSummary? financialSummary;
  List<Item>? items;

  OrderModel({
    this.id,
    this.orderNumber,
    this.userId,
    this.supplierId,
    this.addressId,
    this.driverId,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.user,
    this.address,
    this.driver,
    this.supplier,
    this.financialSummary,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as int?,
    orderNumber: json['order_number'] as String?,
    userId: json['user_id'] as int?,
    supplierId: json['supplier_id'] as int?,
    addressId: json['address_id'] as int?,
    driverId: json['driver_id'] as dynamic,
    totalAmount: (json['total_amount'] as num?)?.toDouble(),
    status: json['status'] as String?,
    paymentStatus: json['payment_status'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    driver: json['driver'] as dynamic,
    supplier: json['supplier'] == null
        ? null
        : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
    financialSummary: json['financial_summary'] == null
        ? null
        : FinancialSummary.fromJson(
            json['financial_summary'] as Map<String, dynamic>,
          ),
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_number': orderNumber,
    'user_id': userId,
    'supplier_id': supplierId,
    'address_id': addressId,
    'driver_id': driverId,
    'total_amount': totalAmount,
    'status': status,
    'payment_status': paymentStatus,
    'created_at': createdAt?.toIso8601String(),
    'user': user?.toJson(),
    'address': address?.toJson(),
    'driver': driver,
    'supplier': supplier?.toJson(),
    'financial_summary': financialSummary?.toJson(),
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
