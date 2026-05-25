class UserReport {
  double? totalPayments;
  double? totalBonus;
  double? totalRemaining;
  int? paymentCount;
  double? ordersTotal;
  int? ordersCount;
  int? totalPointsBalance;
  int? pointsEarned;
  int? pointsSpent;
  int? totalOperations;

  UserReport({
    this.totalPayments,
    this.totalBonus,
    this.totalRemaining,
    this.paymentCount,
    this.ordersTotal,
    this.ordersCount,
    this.totalPointsBalance,
    this.pointsEarned,
    this.pointsSpent,
    this.totalOperations,
  });

  factory UserReport.fromJson(Map<String, dynamic> json) => UserReport(
    totalPayments: (json['total_payments'] as num?)?.toDouble(),
    totalBonus: (json['total_bonus'] as num?)?.toDouble(),
    totalRemaining: (json['total_remaining'] as num?)?.toDouble(),
    paymentCount: json['payment_count'] as int?,
    ordersTotal: (json['orders_total'] as num?)?.toDouble(),
    ordersCount: json['orders_count'] as int?,
    totalPointsBalance: json['total_points_balance'] as int?,
    pointsEarned: json['points_earned'] as int?,
    pointsSpent: json['points_spent'] as int?,
    totalOperations: json['points_redemption_count'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'total_payments': totalPayments,
    'total_bonus': totalBonus,
    'total_remaining': totalRemaining,
    'payment_count': paymentCount,
    'orders_total': ordersTotal,
    'orders_count': ordersCount,
    'total_points_balance': totalPointsBalance,
    'points_earned': pointsEarned,
    'points_spent': pointsSpent,
    'total_operations': totalOperations,
    'points_redemption_count': totalOperations,
  };
}
