class PointsHistoryModel {
  int? id;
  int? userId;
  int? points;
  String? pointsType;
  String? reason;
  DateTime? createdAt;
  int? orderId;
  int? userGiftId;
  String? orderNumber;
  String? giftTitle;

  PointsHistoryModel({
    this.id,
    this.userId,
    this.points,
    this.pointsType,
    this.reason,
    this.createdAt,
    this.orderId,
    this.userGiftId,
    this.orderNumber,
    this.giftTitle,
  });

  @override
  String toString() {
    return 'PointsHistoryModel(id: $id, userId: $userId, points: $points, pointsType: $pointsType, reason: $reason, createdAt: $createdAt, orderId: $orderId, userGiftId: $userGiftId, orderNumber: $orderNumber, giftTitle: $giftTitle)';
  }

  factory PointsHistoryModel.fromJson(Map<String, dynamic> json) {
    return PointsHistoryModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      points: json['points'] as int?,
      pointsType: json['points_type'] as String?,
      reason: json['reason'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      orderId: json['order_id'] as int?,
      userGiftId: json['user_gift_id'] as int?,
      orderNumber: json['order_number'] as String?,
      giftTitle: json['gift_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'points': points,
    'points_type': pointsType,
    'reason': reason,
    'created_at': createdAt?.toIso8601String(),
    'order_id': orderId,
    'user_gift_id': userGiftId,
    'order_number': orderNumber,
    'gift_title': giftTitle,
  };
}
