class UserPointsModel {
  int? totalEarned;
  int? totalSpent;
  int? balance;

  UserPointsModel({this.totalEarned, this.totalSpent, this.balance});

  @override
  String toString() {
    return 'UserPointsModel(totalEarned: $totalEarned, totalSpent: $totalSpent, balance: $balance)';
  }

  factory UserPointsModel.fromJson(Map<String, dynamic> json) {
    return UserPointsModel(
      totalEarned: json['total_earned'] as int?,
      totalSpent: json['total_spent'] as int?,
      balance: json['balance'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_earned': totalEarned,
    'total_spent': totalSpent,
    'balance': balance,
  };
}
