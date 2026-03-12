class UserPointsModel {
  int? userId;
  int? totalEarned;
  int? totalSpent;
  int? balance;
  int? totalTransactions;

  UserPointsModel({
    this.userId,
    this.totalEarned,
    this.totalSpent,
    this.balance,
    this.totalTransactions,
  });

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  @override
  String toString() {
    return 'UserPointsModel(totalEarned: $totalEarned, totalSpent: $totalSpent, balance: $balance)';
  }

  factory UserPointsModel.fromJson(Map<String, dynamic> json) {
    return UserPointsModel(
      userId: _toInt(json['user_id']),
      totalEarned: _toInt(json['total_points_earned'] ?? json['total_earned']),
      totalSpent: _toInt(json['total_points_used'] ?? json['total_spent']),
      balance: _toInt(json['available_points'] ?? json['balance']),
      totalTransactions: _toInt(json['total_transactions']),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'total_points_earned': totalEarned,
    'total_points_used': totalSpent,
    'available_points': balance,
    'total_transactions': totalTransactions,
  };
}
