class OrderHistoryModel {
  int? id;
  String? orderNumber;
  int? userId;
  int? addressId;
  dynamic driverId;
  num? totalAmount;
  num? discountAmount;
  num? finalAmount;
  String? status;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  String? userEmail;
  dynamic driverName;
  String? addressLine;

  OrderHistoryModel({
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
    this.driverName,
    this.addressLine,
  });

  @override
  String toString() {
    return 'OrderHistoryModel(id: $id, orderNumber: $orderNumber, userId: $userId, addressId: $addressId, driverId: $driverId, totalAmount: $totalAmount, discountAmount: $discountAmount, finalAmount: $finalAmount, status: $status, paymentStatus: $paymentStatus, createdAt: $createdAt, updatedAt: $updatedAt, userName: $userName, userEmail: $userEmail, driverName: $driverName, addressLine: $addressLine)';
  }

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'] as int?,
      orderNumber: json['order_number'] as String?,
      userId: json['user_id'] as int?,
      addressId: json['address_id'] as int?,
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
      userName: json['user_name'] as String?,
      userEmail: json['user_email'] as String?,
      driverName: json['driver_name'] as dynamic,
      addressLine: json['address_line'] as String?,
    );
  }

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
    'driver_name': driverName,
    'address_line': addressLine,
  };
}
